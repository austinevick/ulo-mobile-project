import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        home: WelcomeScreen(),
      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  List<User> users = [
    User(fname: 'John', lname: 'Petr', id: 1),
    User(fname: 'John', lname: 'Petr', id: 2),
    User(fname: 'John', lname: 'Petr', id: 3),
  ];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Testing'),
        ),
        body: Container(
          child: ListView(
            children: List.generate(
                users.length,
                (i) => CheckboxListTile(
                      title: Text(users[i].fname),
                      subtitle: Text(users[i].lname),
                      onChanged: (v) {},
                      value: users[i].id != null ? true : false,
                    )),
          ),
        ));
  }
}

class User {
  int id;
  final String fname;
  final String lname;

  User({this.fname, this.id, this.lname});
}
