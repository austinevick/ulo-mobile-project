import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/network_request/get_request.dart';
import 'package:ulomobile_project/providers/network_provider.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'ULO MOBILE SPA',
        theme: ThemeData.light(),
        home: TestingPage(),
      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  final String therapistUrl =
      'https://api.ulomobilespa.com/treatments/2/therapists';
  fetchData() async {
    final res = await get(therapistUrl);
    final result = jsonDecode(res.body);
    final list = result;
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: FutureBuilder<List<Therapists>>(
        future: NetWorkRequest.getTherapists(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LinearProgressIndicator(),
            );
          } else {
            return ListView(
              children: List.generate(snapshot.data.length, (i) {
                final t = snapshot.data[i];
                return Column(
                  children: [
                    Text(t.credentials ?? ''),
                    Column(
                      children: t.description.map((m) => Text(m)).toList(),
                    )
                  ],
                );
              }),
            );
          }
        },
      ),
    );
  }
}
