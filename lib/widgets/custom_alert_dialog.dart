import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final dynamic content;

  const CustomAlertDialog({Key key, this.title, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () => SystemSettings.wireless(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
