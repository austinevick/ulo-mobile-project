import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget icon;
  final int maxLine;

  const TextFieldWidget(
      {Key key, this.maxLine, this.icon, this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(suffixIcon: icon, hintText: hintText),
    );
  }
}
