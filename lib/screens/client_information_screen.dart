import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/payment_screen.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

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
  final nameController = new TextEditingController();
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
            body: ListView(
              controller: controller,
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInputField(
                          autofillHints: [AutofillHints.name],
                          controller: nameController,
                          hintText: 'full Name',
                        ),
                        TextInputField(
                            controller: homeAdressController,
                            onTap: () async {
                              Map result = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {}
                                      // GetUserLocationScreen()
                                      ));
                              if (result != null &&
                                  result.containsKey('item')) {
                                setState(() =>
                                    homeAdressController.text = result['item']);
                                print(homeAdressController.text);
                              }
                            },
                            readOnly: true,
                            hintText: 'Home Address'),
                        TextInputField(
                          readOnly: true,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        TextInputField(
                          autofillHints: [AutofillHints.postalCode],
                          controller: postalCodeController,
                          hintText: 'Postal Code ',
                        ),
                        TextInputField(
                            autofillHints: [AutofillHints.telephoneNumber],
                            controller: phoneNumberController,
                            hintText: 'Phone Number ',
                            textInputType: TextInputType.phone,
                            validator: (value) {
                              Pattern pattern =
                                  r'^(?:\+?1[-.●]?)?\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Enter a valid phone number';
                              else
                                return null;
                            }),
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
                                    child: Text('$item'),
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
                          onChanged: (value) =>
                              setState(() => currentsocialChoice = value),
                        ),
                      ],
                    ),
                  ),
                ),
                LoginButton(
                  radius: 0,
                  buttonColor: Color(0xfffdd13f),
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => PaymentScreen()));
                    print(
                        '${booking.selectedCity}, ${booking.selectedDuration}, ${widget.date}');
                  },
                  height: 65,
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
                  ),
                  width: double.infinity,
                ),
              ],
            )));
  }
}
