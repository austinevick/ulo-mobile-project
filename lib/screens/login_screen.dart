import 'package:flutter/material.dart';
import 'package:ulomobile_project/screens/welcome_screen.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome\nback.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text('Forgot Password?'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoginButton(
                  onPressed: () {},
                  child: Text(
                    'Login',
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
                      child: Material(
                        child: LoginButton(
                          onPressed: () {},
                          buttonColor: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
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
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  )),
                            ],
                          ),
                          height: 50,
                          width: double.infinity,
                        ),
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
