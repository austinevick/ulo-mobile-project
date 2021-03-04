import 'package:flutter/material.dart';

import 'login_button.dart';

class ReusableButton extends StatelessWidget {
  final Function onPressed;

  const ReusableButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        color: Colors.indigo,
        child: LoginButton(
            buttonColor: Colors.white,
            radius: 50,
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Spacer(
                  flex: 3,
                ),
                Text('Continue'),
                Spacer(
                  flex: 2,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                )
              ],
            ),
            onPressed: onPressed));
  }
}
