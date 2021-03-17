import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/internet_connectivity.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/booking_screen.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';

class PickLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, cities, child) => Container(
        height: MediaQuery.of(context).size.height / 2.2,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: Colors.indigo,
              child: Text(
                'SELECT YOUR CITY',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: cities.cities.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: List.generate(cities.cities.length, (index) {
                      final city = cities.cities[index];
                      return GestureDetector(
                        onTap: () => cities.setSelectedCity(city),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: cities.selectedCity ==
                                            cities.cities[index]
                                        ? Colors.green[100]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          city.name,
                                          style: TextStyle(
                                              fontSize: 16,
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
                                                  color: Colors.grey[200],
                                                )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    })),
            ),
            cities.selectedCity == null
                ? SizedBox.shrink()
                : ReusableButton(
                    onPressed: () {
                      NetworkConnectivityChecker.checkConnection(context, () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => BookingScreen1(
                                  cities: cities.selectedCity,
                                )));
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}
