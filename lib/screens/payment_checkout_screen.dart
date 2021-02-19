import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentCheckOutScreen extends StatefulWidget {
  @override
  _PaymentCheckOutScreenState createState() => _PaymentCheckOutScreenState();
}

class _PaymentCheckOutScreenState extends State<PaymentCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(),
    );
  }
}
