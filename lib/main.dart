import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:ulomobile_project/models/user.dart';

import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/landing_screen.dart';
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
        home: LandingScreen(),
      ),
    );
  }
}

List<TherapistModel> therapistModelFromJson(String str) =>
    List<TherapistModel>.from(
        json.decode(str).map((x) => TherapistModel.fromJson(x)));

String therapistModelToJson(List<TherapistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TherapistModel {
  TherapistModel({
    this.dailyAvailability,
  });

  Map<String, List<Availability>> dailyAvailability;

  factory TherapistModel.fromJson(Map<String, dynamic> json) {
    return TherapistModel(
      dailyAvailability: Map.from(json["dailyAvailability"]).map((k, v) =>
          MapEntry<String, List<Availability>>(k,
              List<Availability>.from(v.map((x) => Availability.fromJson(x))))),
    );
  }

  Map<String, dynamic> toJson() => {
        "dailyAvailability": Map.from(dailyAvailability).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Availability {
  Availability({
    this.key,
    this.displayValue,
  });

  int key;
  String displayValue;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        key: json["key"],
        displayValue: json["displayValue"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "displayValue": displayValue,
      };
}

class TestAPI extends StatefulWidget {
  @override
  _TestAPIState createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  bool isloading = false;
  Future fetchData(User user) async {
    setState(() => isloading = true);
    final response = await http.post('https://api.ulomobilespa.com/auth/signUp',
        body: user.toMap());
    if (response.statusCode == 201) {
      setState(() => isloading = false);
      final data = jsonEncode(response.body);
      print(data);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextInputField(),
            TextInputField(),
            TextInputField(),
            TextInputField(),
          ],
        ));
  }
}
