import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Timer timer;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1050));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    init();
    super.initState();
  }

  init() {
    timer = Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => OnBoardingScreen(),
            )));
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => OnBoardingScreen())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animation,
              child: Image.asset(
                'images/ulo_logo.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
