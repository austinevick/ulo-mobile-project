import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/internet_connectivity.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/booking_screen.dart';
import 'package:ulomobile_project/screens/treatment_screen.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class PickLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, cities, child) => Container(
        height: MediaQuery.of(context).size.height / 2.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Pick a location',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Divider(
                thickness: 4,
              ),
            ),
            Expanded(
              child: cities.cities.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: List.generate(cities.cities.length, (index) {
                      final city = cities.cities[index];
                      return GestureDetector(
                        onTap: () => cities.setSelectedCity(city),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          city.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      AnimatedSwitcher(
                                          duration: Duration(milliseconds: 300),
                                          child: cities.selectedCity ==
                                                  cities.cities[index]
                                              ? CustomCheckBox(
                                                  color: Colors.green,
                                                )
                                              : CustomCheckBox(
                                                  color: Colors.white,
                                                )),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      );
                    })),
            ),
            cities.selectedCity == null
                ? SizedBox.shrink()
                : LoginButton(
                    radius: 0,
                    buttonColor: Colors.yellow,
                    onPressed: () =>
                        NetworkConnectivityChecker.checkConnection(context, () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => BookingScreen1(
                                cities: cities.selectedCity,
                              )));
                    }),
                    height: 65,
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
