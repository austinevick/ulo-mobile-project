import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/service/payment_service.dart';
import 'package:ulomobile_project/widgets/animated_dialog.dart';
import 'package:ulomobile_project/widgets/failure_dialog.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/success_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final String date;
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
      this.source,
      this.date})
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
    var response = await payWithNewCard(amount: amount, currency: 'USD');
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

  PaymentMethod paymentMethod;
  Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        sendPaymentToken();
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  sendPaymentToken() async {
    final provider = Provider.of<NetworkProvider>(context, listen: false);
    final url = 'https://api.ulomobilespa.com/stripePayment';
    var body = {
      "token": {
        "id": paymentMethod.id,
        "object": "payment_method",
        "card": {
          "id": "${paymentMethod.id}",
          "object": "card",
          "address_city": null,
          "address_country": null,
          "address_line1": null,
          "address_line1_check": null,
          "address_line2": null,
          "address_state": null,
          "address_zip": null,
          "address_zip_check": null,
          "brand": paymentMethod.card.brand,
          "country": paymentMethod.card.country,
          "cvc_check": paymentMethod.card.cvc,
          "dynamic_last4": null,
          "exp_month": paymentMethod.card.expMonth,
          "exp_year": paymentMethod.card.expYear,
          "funding": paymentMethod.card.funding,
          "last4": paymentMethod.card.last4,
          "name": null,
          "tokenization_method": null
        },
        "client_ip": "**redacted**",
        "created": paymentMethod.created,
        "livemode": paymentMethod.livemode,
        "type": paymentMethod.type,
        "used": false
      },
      "paymentData": {
        "cityId": provider.selectedCity,
        "treatmentId": provider.selectedTreatment,
        "therapistIds": [8],
        "duration": {
          "id": provider.selectedDuration.id,
          "length": provider.selectedDuration.length,
          "price": provider.selectedDuration.price
        },
        "date": widget.date,
        "time": {
          "key": provider.availability.key,
          "displayValue": provider.availability.displayValue
        },
        "client": {
          "firstName": widget.firstName,
          "lastName": widget.lastName,
          "street": widget.street,
          "postalCode": "${widget.postalCode}",
          "emailAddress": widget.emailAddress,
          "phoneNumber": "${widget.phoneNumber}",
          "specialInstructions":
              "Please do not come for this appointment. It is a test",
          "buildingType": "${widget.stairs}",
          "source": "${widget.source}",
          "city": "Calgary",
          "province": "AB"
        },
        "discountCode": ""
      }
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 201) {
        print('${response.reasonPhrase}');
        print('${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }
}
