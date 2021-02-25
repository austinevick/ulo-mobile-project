import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.indigo)),
        home: LandingScreen(),
      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  void bookTherapists(name, address, postalCode, cityID, treatmentID) async {
    final String url = 'https://api.ulomobilespa.com/';

    var params = Map();

    params['token'] = "1234567890";
    params['paymentData']['cityID'] = cityID;
    params['paymentData']['treatmentId'] = treatmentID;
    params['name'] = name;
    params['address'] = address;
    params['postal-code'] = postalCode;
    var mapData = json.encode(params);

    //send the request to the server and get the response
    var response = await http.post(url, body: mapData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Testing'),
        ),
        body: Container(
          child: ListView(),
        ));
  }
}
