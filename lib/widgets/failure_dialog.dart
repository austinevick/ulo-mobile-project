import 'package:flutter/material.dart';

import 'login_button.dart';

class FailureDialog extends StatelessWidget {
  final String respond;

  const FailureDialog({Key key, this.respond}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.8,
        width: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.clear,
                      size: 32,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                respond,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginButton(
                onPressed: () => Navigator.of(context).pop(),
                buttonColor: Colors.red,
                radius: 50,
                width: 200,
                height: 50,
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
