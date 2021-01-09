import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class PickLocationScreen extends StatefulWidget {
  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false).getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, cities, child) => Container(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pick a location',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                  children: List.generate(
                      cities.cities.length,
                      (index) => Card(
                            child: ListTile(
                              trailing: Radio(
                                value: 1,
                                groupValue: 0,
                                onChanged: (value) {},
                              ),
                              title: Text(cities.cities[index].name),
                            ),
                          ))),
            ),
            LoginButton(
              buttonColor: Colors.yellow,
              onPressed: () {},
              height: 50,
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20),
              ),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
