import 'dart:convert';
import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:ulomobile_project/internet_connectivity.dart';
import 'package:ulomobile_project/models/user.dart';

import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/landing_screen.dart';
import 'package:ulomobile_project/screens/payment_screen.dart';
import 'package:ulomobile_project/widgets/inputfield_widget.dart';

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
        home: StripePaymentScreen(),
      ),
    );
  }
}
