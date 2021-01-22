import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/client_information_screen.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';

class AvailabilityScreen extends StatefulWidget {
  final Therapists therapists;

  const AvailabilityScreen({Key key, this.therapists}) : super(key: key);

  @override
  _AvailabilityScreenState createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  final controller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Pick a date and time',
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: controller,
                  readOnly: true,
                  onTap: () {
                    pickDate();
                  },
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Column(
              children: List.generate(
                  widget.therapists.defaultAvailability.length, (index) {
                final availability =
                    widget.therapists.defaultAvailability[index];
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
    );
  }

  pickDate() async {
    if (Platform.isIOS) {
      return CupertinoDatePicker(
        onDateTimeChanged: (DateTime date) {
          if (date != null) {
            selectedDate = date;
          }
        },
        initialDateTime: selectedDate,
      );
    } else if (Platform.isAndroid) {
      final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: selectedDate,
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  onPrimary: Colors.black,
                  surface: Colors.yellow,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            );
          });

      if (date != null) {
        selectedDate = date;
        controller..text = DateFormat.yMMMd().format(selectedDate);
      }
    }
  }
}
