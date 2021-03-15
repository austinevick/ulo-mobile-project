import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/landing_screen.dart';
import 'package:ulomobile_project/service/payment_service.dart';
import 'package:ulomobile_project/widgets/animated_dialog.dart';
import 'package:ulomobile_project/widgets/failure_dialog.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/success_dialog.dart';

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
