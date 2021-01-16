import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:ulomobile_project/constants.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class ClientInformationScreen extends StatefulWidget {
  @override
  _ClientInformationScreenState createState() =>
      _ClientInformationScreenState();
}

class _ClientInformationScreenState extends State<ClientInformationScreen> {
  final controller = ScrollController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: [
                    TextFieldWidget(
                      hintText: 'First Name',
                    ),
                    TextFieldWidget(
                      hintText: 'Last Name',
                    ),
                    TextFieldWidget(
                      hintText: 'Street',
                    ),
                    TextFieldWidget(
                      hintText: 'Email Address',
                    ),
                    TextFieldWidget(
                      hintText: 'Postal Code',
                    ),
                    TextFieldWidget(
                      hintText: 'Phone Number',
                    ),
                    TextFieldWidget(
                      maxLine: 4,
                      hintText:
                          'Special Instructions (buzzer, allergies, parking)',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Do you have any',
                      style: clientInfoStyle1,
                    ),
                    CheckboxListTile(
                        title: Text('Pets'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('Stairs'),
                        onChanged: (value) {
                          setState(() => isVisible = value);
                        },
                        value: isVisible),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: isVisible
                          ? Column(
                              children: [
                                CheckboxListTile(
                                    title: Text('1 flight of stairs'),
                                    onChanged: (value) {},
                                    value: false),
                                CheckboxListTile(
                                    title: Text('2 flight of stairs'),
                                    onChanged: (value) {},
                                    value: false),
                                CheckboxListTile(
                                    title: Text('3 or more flight of stairs'),
                                    onChanged: (value) {},
                                    value: false),
                              ],
                            )
                          : Container(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Location',
                      style: clientInfoStyle1,
                    ),
                    CheckboxListTile(
                        title: Text('Home'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('Work'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('Hotel'),
                        onChanged: (value) {},
                        value: false),
                    TextFieldWidget(
                      hintText: 'Other',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Where did you hear about us?',
                      style: clientInfoStyle1,
                    ),
                    CheckboxListTile(
                        title: Text('Instagram'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                      title: Text('Facebook'),
                      onChanged: (value) {},
                      value: false,
                    ),
                    CheckboxListTile(
                        title: Text('Google'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('Referral'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('LinkedIn'),
                        onChanged: (value) {},
                        value: false),
                    CheckboxListTile(
                        title: Text('Flyer'),
                        onChanged: (value) {},
                        value: false),
                  ],
                ),
              ),
            ),
            LoginButton(
              radius: 0,
              buttonColor: Colors.yellow,
              onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                // builder: (ctx) =>));
              },
              height: 65,
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20),
              ),
              width: double.infinity,
            ),
          ],
        ));
  }
}
