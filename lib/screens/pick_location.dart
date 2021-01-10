import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/treatment_screen.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class PickLocationScreen extends StatelessWidget {
  final int selectedValue = 0;
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
              child: cities.cities.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: List.generate(
                          cities.cities.length,
                          (index) => Card(
                                child: ListTile(
                                  onTap: () {},
                                  trailing: Radio(
                                    value: cities.cities[index],
                                    groupValue: cities.selectedCity,
                                    onChanged: (value) {
                                      cities.setSelectedCity(value);
                                      print(value);
                                    },
                                  ),
                                  title: Text(cities.cities[index].name),
                                ),
                              ))),
            ),
            LoginButton(
              buttonColor: Colors.yellow,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => TreatmentScreen()));
              },
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
