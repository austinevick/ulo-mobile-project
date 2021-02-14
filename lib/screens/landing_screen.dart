import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

import 'therapist_registration_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'images/ulo_logo.png',
              width: 130,
              height: 140,
            ),
          ),
        ),
        Text(
          'Welcome to Ulo Mobile Spa',
          style: GoogleFonts.bungee(fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'A new way for you to experience a professional massage at home, work or even in a hotel.',
            textAlign: TextAlign.center,
            style: GoogleFonts.oleoScript(fontSize: 14),
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
            onPressed: () => null,
            radius: 50,
            width: double.infinity,
            buttonColor: Color(0xfff6be00),
            height: 50,
            child: Text(
              'Get Started',
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
