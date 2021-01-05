import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Color buttonColor;
  final Function onPressed;
  final Widget child;

  const LoginButton(
      {Key key,
      this.image,
      this.child,
      @required this.height,
      @required this.onPressed,
      @required this.width,
      @required this.buttonColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(50)),
        child: FlatButton(onPressed: onPressed, child: child),
      ),
    );
  }
}
