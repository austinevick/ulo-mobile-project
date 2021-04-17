import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/availability_widget.dart';
import 'package:ulomobile_project/widgets/date_textfield.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';

import 'client_information_screen.dart';

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
  void initState() {
    super.initState();
    controller.text = DateFormat.yMMMd().format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pick a date and time'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  DateTextFieldWidget(
                      onChanged: (v) {
                        setState(() => controller.text = 'Date');
                      },
                      controller: controller,
                      onTap: () => pickDate()),
                  Column(
                    children: List.generate(
                        widget.therapists.defaultAvailability.length, (index) {
                      final availability =
                          widget.therapists.defaultAvailability[index];
                      return TherapistAvailabilityWidget(
                        selectedDate: selectedDate,
                        availability: availability,
                      );
                    }),
                  ),
                ],
              ),
            ),
            provider.availability == null
                ? SizedBox.shrink()
                : ReusableButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ClientInformationScreen(
                                date: controller.text,
                              )));
                    },
                  )
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
            controller.text = DateFormat.yMMMd().format(selectedDate);
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
        controller.text = DateFormat.yMMMd().format(selectedDate);
      }
    }
  }
}
