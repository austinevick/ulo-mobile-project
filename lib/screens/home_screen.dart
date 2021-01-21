import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ulomobile_project/constants.dart';
import '../internet_connectivity.dart';
import '../widgets/login_button.dart';
import '../widgets/drawer_widget.dart';
import 'pick_location.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add,
              size: 28,
            ),
            onPressed: () {},
          )
        ],
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              'Book an appointment with us today\nour team offers the best service',
              style: contentStyle,
            ),
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/image5.jpg'))),
          ),
          Spacer(),
          LoginButton(
              buttonColor: Colors.yellow,
              height: 65,
              radius: 0,
              width: double.infinity,
              child: Text(
                'Get a massage',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onPressed: () =>
                  NetworkConnectivityChecker.checkConnection(context, () {
                    showBarModalBottomSheet(
                        builder: (context) => PickLocationScreen(),
                        context: context);
                  }))
        ],
      ),
    );
  }
}
