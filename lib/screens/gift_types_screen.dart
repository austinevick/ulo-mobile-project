import 'package:flutter/material.dart';

import 'package:ulomobile_project/widgets/inputfield_widget.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

import 'gift_form_screen.dart';

class GiftTypesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Gifts'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Buy Gift',
                  ),
                  Tab(
                    text: 'Redeem Gift',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                GiftFormScreen(),
                Container(
                  child: Column(
                    children: [
                      TextInputField(
                        hintText: 'Gift Code',
                      ),
                      buildButton('Verify gift code', () {})
                    ],
                  ),
                ),
              ],
            )));
  }

  buildButton(String text, Function onPressed) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoginButton(
          buttonColor: Color(0xfffdd13f),
          radius: 8,
          height: 50,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          width: double.infinity,
        ),
      );
}
