import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Widget icon;

  const TextFieldWidget({Key key, this.icon, this.labelText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(suffixIcon: icon, labelText: labelText),
    );
  }
}
