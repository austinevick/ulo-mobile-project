import 'package:flutter/material.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class TherapistRegistrationScreen extends StatefulWidget {
  @override
  _TherapistRegistrationScreenState createState() =>
      _TherapistRegistrationScreenState();
}

class _TherapistRegistrationScreenState
    extends State<TherapistRegistrationScreen> {
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final addressController = new TextEditingController();
  final cityNameController = new TextEditingController();
  final provinceNameController = new TextEditingController();
  final postalController = new TextEditingController();
  final emailController = new TextEditingController();
  final phoneController = new TextEditingController();
  final genderController = new TextEditingController();
  final experienceLengthController = new TextEditingController();
  final certificationController = new TextEditingController();
  final referralController = new TextEditingController();
  final languageController = new TextEditingController();
  final firstRefNameController = new TextEditingController();
  final firstRefPhoneController = new TextEditingController();
  final firstRefEmailController = new TextEditingController();
  final secondRefNameController = new TextEditingController();
  final secondRefEmailController = new TextEditingController();
  final secondRefPhoneController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  List<String> materials = ['Portable table', 'Chair', 'Both'];
  var selectedMaterial = 'Portable table';
  static List<String> availableDays = [
    'weekdays',
    'Weekends',
    'Mornings',
    'Afternoons',
    'Evenings'
  ];
  var selectedDays = availableDays.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextInputField(
                controller: firstNameController,
                hintText: 'First Name',
              ),
              TextInputField(
                controller: lastNameController,
                hintText: 'Last Name',
              ),
              TextInputField(
                controller: addressController,
                hintText: 'Street Address',
              ),
              TextInputField(
                hintText: 'City',
                controller: cityNameController,
              ),
              TextInputField(
                controller: provinceNameController,
                hintText: 'Province',
              ),
              TextInputField(
                controller: postalController,
                hintText: 'Postal Code',
              ),
              TextInputField(
                controller: emailController,
                hintText: 'Email Address',
              ),
              TextInputField(
                controller: phoneController,
                hintText: 'Phone Number',
              ),
              TextInputField(
                controller: genderController,
                hintText: 'Gender',
              ),
              TextInputField(
                controller: experienceLengthController,
                hintText: 'Years of experience',
              ),
              TextInputField(
                controller: certificationController,
                hintText: 'I received my certification from',
              ),
              TextInputField(
                controller: referralController,
                hintText: 'Referred by',
              ),
              TextInputField(
                controller: languageController,
                hintText: 'Languages Spoken',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('I have a'),
              ),
              DropdownButtonFormField(
                items: materials
                    .map((items) => DropdownMenuItem(
                          child: Text(items),
                          value: items,
                        ))
                    .toList(),
                value: selectedMaterial,
                onChanged: (value) => setState(() => selectedMaterial = value),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('I would like to work'),
              ),
              DropdownButtonFormField(
                items: availableDays
                    .map((items) => DropdownMenuItem(
                          child: Text(items),
                          value: items,
                        ))
                    .toList(),
                value: selectedDays,
                onChanged: (value) => setState(() => selectedDays = value),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('I am'),
              ),
              CheckboxListTile(
                  title:
                      Text('Willing to carry a massage table to appointment'),
                  onChanged: (v) {},
                  value: false),
              CheckboxListTile(
                  title: Text('Self-Employed (have GST/HST number)'),
                  onChanged: (v) {},
                  value: false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please upload the following documents'),
              ),
              TextButton(
                child: Text('Resume'),
                onPressed: () {},
              ),
              TextButton(
                child: Text('Liability Insurance'),
                onPressed: () {},
              ),
              Text('References'),
              TextInputField(
                controller: firstRefNameController,
                hintText: 'Name',
              ),
              TextInputField(
                controller: firstRefEmailController,
                hintText: 'Email Address',
              ),
              TextInputField(
                controller: firstRefPhoneController,
                hintText: 'Phone Number',
              ),
              SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: secondRefNameController,
                hintText: 'Name',
              ),
              TextInputField(
                controller: secondRefEmailController,
                hintText: 'Email Address',
              ),
              TextInputField(
                controller: secondRefPhoneController,
                hintText: 'Phone Number',
              ),
              SizedBox(
                height: 20,
              ),
              LoginButton(
                buttonColor: Color(0xfff6be00),
                radius: 0,
                child: Text('SUBMIT'),
                height: 60,
                width: double.infinity,
                onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
