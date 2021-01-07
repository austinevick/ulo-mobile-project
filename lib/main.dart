import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/booking_screen.dart';
import 'package:ulomobile_project/screens/therapist_screen.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NetworkProvider(),
      child: MaterialApp(
        title: 'ULO MOBILE SPA',
        theme: ThemeData.light(),
        home: TherapistsScreen(),
      ),
    );
  }
}
