import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:ulomobile_project/apikey.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/landing_screen.dart';
import 'package:ulomobile_project/service/payment_service.dart';
import 'package:ulomobile_project/widgets/animated_dialog.dart';
import 'package:ulomobile_project/widgets/failure_dialog.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/success_dialog.dart';

class StripePaymentScreen extends StatefulWidget {
  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  final String postCreateIntentURL =
      "https://api.ulomobilespa.com/stripePayment";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StripeCard card = StripeCard();

  final Stripe stripe = Stripe(
    "$publishableKey", //Your Publishable Key
    stripeAccount:
        "acct_1G...", //Merchant Connected Account ID. It is the same ID set on server-side.
    returnUrlForSca: "stripesdk://3ds.stripesdk.io", //Return URL for SCA
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment"),
      ),
      body: new SingleChildScrollView(
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: Column(
              children: [
                CardForm(formKey: formKey, card: card),
                Container(
                  child: TextButton(
                      child: const Text('Pay', style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        formKey.currentState.validate();
                        formKey.currentState.save();
                        buy(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buy(context) async {
    final StripeCard stripeCard = card;

    final String customerEmail = getCustomerEmail();

    if (!stripeCard.validateCVC()) {
      showAlertDialog(context, "Error", "CVC not valid.");
      return;
    }
    if (!stripeCard.validateDate()) {
      showAlertDialog(context, "Errore", "Date not valid.");
      return;
    }
    if (!stripeCard.validateNumber()) {
      showAlertDialog(context, "Error", "Number not valid.");
      return;
    }

    Map<String, dynamic> paymentIntentRes =
        await createPaymentIntent(stripeCard, customerEmail);
    String clientSecret = paymentIntentRes['client_secret'];
    String paymentMethodId = paymentIntentRes['payment_method'];
    String status = paymentIntentRes['status'];

    if (status == 'requires_action') //3D secure is enable in this card
      paymentIntentRes =
          await confirmPayment3DSecure(clientSecret, paymentMethodId);

    if (paymentIntentRes['status'] != 'succeeded') {
      showAlertDialog(context, "Warning", "Canceled Transaction.");
      return;
    }

    if (paymentIntentRes['status'] == 'succeeded') {
      showAlertDialog(context, "Success", "Thanks for buying!");
      return;
    }
    showAlertDialog(
        context, "Warning", "Transaction rejected.\nSomething went wrong");
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      StripeCard stripeCard, String customerEmail) async {
    String clientSecret;
    Map<String, dynamic> paymentIntentRes, paymentMethod;
    try {
      paymentMethod = await stripe.api.createPaymentMethodFromCard(stripeCard);
      clientSecret =
          await postCreatePaymentIntent(customerEmail, paymentMethod['id']);
      paymentIntentRes = await stripe.api.retrievePaymentIntent(clientSecret);
    } catch (e) {
      print("ERROR_CreatePaymentIntentAndSubmit: $e");
      showAlertDialog(context, "Error", "Something went wrong.");
    }
    return paymentIntentRes;
  }

  Future<String> postCreatePaymentIntent(
      String email, String paymentMethodId) async {
    String clientSecret;
    http.Response response = await http.post(
      postCreateIntentURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'payment_method_id': paymentMethodId,
      }),
    );
    clientSecret = json.decode(response.body);
    return clientSecret;
  }

  Future<Map<String, dynamic>> confirmPayment3DSecure(
      String clientSecret, String paymentMethodId) async {
    Map<String, dynamic> paymentIntentRes_3dSecure;
    try {
      await stripe.confirmPayment(clientSecret,
          paymentMethodId: paymentMethodId);
      paymentIntentRes_3dSecure =
          await stripe.api.retrievePaymentIntent(clientSecret);
    } catch (e) {
      print("ERROR_ConfirmPayment3DSecure: $e");
      showAlertDialog(context, "Error", "Something went wrong.");
    }
    return paymentIntentRes_3dSecure;
  }

  String getCustomerEmail() {
    String customerEmail;
    //Define how to get this info.
    // -Ask to the customer through a textfield.
    // -Get it from firebase Account.
    customerEmail = "alessandro.berti@me.it";
    return customerEmail;
  }

  showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(), // dismiss dialog
            ),
          ],
        );
      },
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String street;
  final String emailAddress;
  final String postalCode;
  final String phoneNumber;
  final String specialInstruction;
  final String pet;
  final String stairs;
  final String location;
  final String other;
  final String source;

  const PaymentScreen(
      {Key key,
      this.firstName,
      this.lastName,
      this.street,
      this.emailAddress,
      this.postalCode,
      this.phoneNumber,
      this.specialInstruction,
      this.pet,
      this.stairs,
      this.location,
      this.other,
      this.source})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget detailText(String text, [FontWeight fontWeight]) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: fontWeight, fontSize: 16),
        ),
      );

  @override
  void initState() {
    StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(builder: (context, provider, child) {
      var cost = provider.selectedDuration.price;
      var tax = 5 / 100 * cost;
      var total = cost + tax;
      var amount = (total).ceil();
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Payment Information'),
        ),
        body: ListView(
          children: [
            TextInputField(
              hintText: 'Enter discount code (if any)',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailText('Cost'),
                        detailText('\$' + cost.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [detailText('Tax'), detailText('\$' + '$tax')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailText('Total', FontWeight.bold),
                        detailText('\$' + '$total')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginButton(
                onPressed: () => //print('${roundedFigure.toString()}0000'),
                    payViaNewCard(context, '${amount.toString()}00'),
                radius: 50,
                buttonColor: Colors.indigo,
                height: 50,
                width: double.infinity,
                child: Text(
                  'Make Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  payViaNewCard(BuildContext context, amount) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: amount, currency: 'USD');
    response.toString();
    await dialog.hide();
    animatedDialog(
        context: context,
        child: response.success
            ? SuccessDialog(
                respond: response.message,
              )
            : FailureDialog(respond: response.message));
  }
}
