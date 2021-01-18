import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class LoginButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color buttonColor;
  final Function onPressed;
  final Widget child;

  const LoginButton(
      {Key key,
      this.radius,
      this.child,
      @required this.height,
      @required this.onPressed,
      @required this.width,
      @required this.buttonColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 1000),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(radius)),
        child: FlatButton(onPressed: onPressed, child: child),
      ),
    );
  }
}
