import 'package:flutter/material.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Icon(
                  Icons.keyboard_backspace,
                  size: 35,
                ),
              ),
              Text(
                'Create\nAccount.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoginButton(
                  onPressed: () {},
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  buttonColor: Color(0xfffdd13f),
                  height: 50,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Or Continue with')),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoginButton(
                        onPressed: () {},
                        buttonColor: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'images/google.png',
                                        ))),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  'Google',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        height: 50,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoginButton(
                        onPressed: () {},
                        buttonColor: Color(0xff1a7cdd),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 20,
                                height: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'images/facebook.png',
                                        ))),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  'Facebook',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                        height: 50,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
