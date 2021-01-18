import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/client_information_screen.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';

class AvailabilityScreen extends StatelessWidget {
  final Therapists therapists;

  const AvailabilityScreen({Key key, this.therapists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Pick a time',
          ),
          actions: [
            provider.availability == null
                ? SizedBox.shrink()
                : FlatButton(
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          reverseTransitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            final curvedAnimation = CurvedAnimation(
                                curve: Interval(0, 0.5), parent: animation);
                            return FadeTransition(
                              opacity: curvedAnimation,
                              child: ClientInformationScreen(),
                            );
                          }));
                    },
                  )
          ],
        ),
        body: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                children: List.generate(therapists.defaultAvailability.length,
                    (index) {
                  final availability = therapists.defaultAvailability[index];
                  return GestureDetector(
                    onTap: () {
                      print(availability);
                      provider.setAvailability(availability);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    availability.displayValue,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: provider.availability == availability
                                        ? CustomCheckBox(
                                            color: Colors.green,
                                          )
                                        : CustomCheckBox())
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
