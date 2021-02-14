import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Widget detailText(String text, [FontWeight fontWeight]) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: fontWeight, fontSize: 16),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, therapist, child) => Scaffold(
              appBar: AppBar(
                title: Text('Payment Information'),
              ),
              body: ListView(
                children: [
                  TextInputField(
                    hintText: 'card',
                  ),
                  TextInputField(
                    hintText: 'Discount code',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [detailText('Cost'), detailText('451')],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [detailText('Tax'), detailText('451')],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              detailText('Total', FontWeight.bold),
                              detailText('451')
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
                      onPressed: () => null,
                      radius: 50,
                      buttonColor: Colors.indigo,
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
