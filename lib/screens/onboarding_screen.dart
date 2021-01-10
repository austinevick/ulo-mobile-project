import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ulomobile_project/screens/login_screen.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/onboarding_list.dart';

import 'pick_location.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
                print(value);
              },
              children: pages),
          currentPage == 0
              ? Positioned(
                  bottom: 280,
                  left: 16,
                  right: 16,
                  child: Center(
                    child: FlatButton(
                      child: Text(
                        'Have an account? login',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => LoginScreen())),
                    ),
                  ),
                )
              : Container(),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      pages.length,
                      (i) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: 6,
                              width: currentPage == i ? 20 : 6,
                              decoration: BoxDecoration(
                                  color: currentPage == i
                                      ? Colors.white
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )),
                ),
                SizedBox(
                  height: 16,
                ),
                LoginButton(
                  buttonColor: Colors.yellow,
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    showBarModalBottomSheet(
                        builder: (context) => PickLocationScreen(),
                        context: context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
