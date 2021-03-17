import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/payment_screen.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';

class ClientInformationScreen extends StatefulWidget {
  final String date;

  const ClientInformationScreen({
    Key key,
    this.date,
  }) : super(key: key);
  @override
  _ClientInformationScreenState createState() =>
      _ClientInformationScreenState();
}

class _ClientInformationScreenState extends State<ClientInformationScreen> {
  final formKey = new GlobalKey<FormState>();
  final fnameController = new TextEditingController();
  final lnameController = new TextEditingController();

  final homeAdressController = new TextEditingController();
  final emailController = new TextEditingController();
  final postalCodeController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final instructionController = new TextEditingController();
  final otherController = new TextEditingController();
  final controller = ScrollController();
  List<String> pets = ['No Pets', 'Cats', 'Dogs', 'Both'];
  List<String> stairs = ['None', '1 flight', '2 flights', '3+ flights'];
  List<String> locations = ['Home', 'Office', 'Hotel'];
  List<String> socialChoice = [
    'Instagram',
    'Facebook',
    'Referral',
    'LinkedIn',
    'Twitter',
    'Flyer'
  ];

  var currentsocialChoice = 'Instagram';
  var currentLocation = 'Home';
  var currentStairs = 'None';
  var currentPet = 'No Pets';
  Widget headerText(String title) => Text(
        title,
        style: GoogleFonts.aclonica(fontSize: 16),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, booking, child) => Scaffold(
            appBar: ScrollAppBar(
              controller: controller,
              title: Text('Personal Information'),
            ),
            body: Scrollbar(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextInputField(
                                  validator: (value) => value.isEmpty
                                      ? 'Field must not be empty'
                                      : null,
                                  autofillHints: [AutofillHints.name],
                                  controller: fnameController,
                                  hintText: 'first Name*',
                                ),
                                TextInputField(
                                  validator: (value) => value.isEmpty
                                      ? 'Field must not be empty'
                                      : null,
                                  autofillHints: [AutofillHints.name],
                                  controller: lnameController,
                                  hintText: 'Last Name*',
                                ),
                                TextInputField(
                                    validator: (value) => value.isEmpty
                                        ? 'Field must not be empty'
                                        : null,
                                    controller: homeAdressController,
                                    hintText:
                                        'Street* (Please fill in your correct address)'),
                                TextInputField(
                                  validator: (value) => !value.contains('@')
                                      ? 'Provide a valid email'
                                      : null,
                                  hintText: 'Email Address*',
                                  textInputType: TextInputType.emailAddress,
                                  controller: emailController,
                                ),
                                TextInputField(
                                  validator: (value) => value.isEmpty
                                      ? 'Field must not be empty'
                                      : null,
                                  autofillHints: [AutofillHints.postalCode],
                                  controller: postalCodeController,
                                  hintText: 'Postal Code* ',
                                ),
                                TextInputField(
                                  validator: (value) => validateMobile(value),
                                  autofillHints: [
                                    AutofillHints.telephoneNumber
                                  ],
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  controller: phoneNumberController,
                                  hintText: 'Phone Number* ',
                                  textInputType: TextInputType.phone,
                                ),
                                TextInputField(
                                  controller: instructionController,
                                  obscureText: false,
                                  maxLines: null,
                                  hintText:
                                      'Special Instructions (buzzer, allergies, parking)',
                                ),
                                SizedBox(height: 15),
                                headerText(
                                  'Pets',
                                ),
                                DropdownButtonFormField(
                                  value: currentPet,
                                  items: pets
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() => currentPet = value);
                                  },
                                ),
                                SizedBox(height: 15),
                                headerText(
                                  'Stairs',
                                ),
                                DropdownButtonFormField(
                                  items: stairs
                                      .map((items) => DropdownMenuItem(
                                            child: Text(items),
                                            value: items,
                                          ))
                                      .toList(),
                                  value: currentStairs,
                                  onChanged: (value) =>
                                      setState(() => currentStairs = value),
                                ),
                                SizedBox(height: 15),
                                headerText(
                                  'Location',
                                ),
                                DropdownButtonFormField(
                                  items: locations
                                      .map((items) => DropdownMenuItem(
                                            child: Text(items),
                                            value: items,
                                          ))
                                      .toList(),
                                  value: currentLocation,
                                  onChanged: (value) =>
                                      setState(() => currentLocation = value),
                                ),
                                TextInputField(
                                  controller: otherController,
                                  hintText: 'Other',
                                ),
                                SizedBox(height: 15),
                                headerText(
                                  'Where did you hear about us?',
                                ),
                                DropdownButtonFormField(
                                  items: socialChoice
                                      .map((items) => DropdownMenuItem(
                                            child: Text(items),
                                            value: items,
                                          ))
                                      .toList(),
                                  value: currentsocialChoice,
                                  onChanged: (value) => setState(
                                      () => currentsocialChoice = value),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  phoneNumberController.text.isEmpty
                      ? Container()
                      : ReusableButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => PaymentScreen()));
                            }
                          },
                        )
                ],
              ),
            )));
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
