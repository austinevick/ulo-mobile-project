import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ulomobile_project/screens/booking_screen.dart';
import 'package:ulomobile_project/screens/pick_location.dart';
import 'package:ulomobile_project/widgets/drawer_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

import '../internet_connectivity.dart';
import 'therapist_registration_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: Text(
          'Ulo Mobile Spa',
          style: GoogleFonts.bungee(fontSize: 18),
        ),
      ),
      drawer: Drawer(child: DrawerWidget()),
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Text(
                'Welcome to Ulo Mobile Spa',
                style: GoogleFonts.bungee(fontSize: 22, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'A new way for you to experience a professional massage at home, work or even in a hotel.',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.oleoScript(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: FadeIn(
              duration: Duration(seconds: 2),
              child: Image.asset('images/image1.png')),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginButton(
            onPressed: () =>
                NetworkConnectivityChecker.checkConnection(context, () {
              showBarModalBottomSheet(
                  shape: OutlineInputBorder(borderSide: BorderSide.none),
                  builder: (context) => PickLocationScreen(),
                  context: context);
            }),
            radius: 50,
            width: double.infinity,
            buttonColor: Color(0xfff6be00),
            height: 50,
            child: Text(
              'Book a massage',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => TherapistRegistrationScreen())),
            radius: 50,
            buttonColor: Colors.indigo,
            height: 50,
            width: double.infinity,
            child: Text(
              'Join our team',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Spacer()
      ]),
    );
  }
}
