import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NetworkProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ULO MOBILE SPA',
        theme: ThemeData(
            accentColor: Colors.indigo,
            appBarTheme: AppBarTheme(color: Colors.indigo)),
        home: LandingScreen(),
      ),
    );
  }
}
