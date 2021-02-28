import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';
import 'package:ulomobile_project/widgets/treatments_list.dart';

import 'booking_screen2.dart';

class BookingScreen1 extends StatefulWidget {
  final Cities cities;
  BookingScreen1({Key key, this.cities}) : super(key: key);

  @override
  _BookingScreen1State createState() => _BookingScreen1State();
}

class _BookingScreen1State extends State<BookingScreen1> {
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.purple,
    Colors.green
  ];

  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false)
        .getTreatments(widget.cities.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, treatment, child) =>
          widget.cities.id == 2 || widget.cities.id == 3
              ? Scaffold(body: buildErrorPage())
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Pick a treatment'),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      treatment.treatments.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: treatment.treatments.length,
                                itemBuilder: (ctx, index) {
                                  final MaterialColor color =
                                      _colors[index % _colors.length];
                                  final treatments =
                                      treatment.treatments[index];
                                  return TreatmentList(
                                    treatments: treatments,
                                    color: color,
                                  );
                                },
                              ),
                            ),
                      treatment.selectedDuration == null
                          ? SizedBox.shrink()
                          : buildButton(treatment)
                    ],
                  ),
                ),
    );
  }

  buildErrorPage() => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.pink])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We are coming soon to your location',
                style: GoogleFonts.aladin(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              LoginButton(
                child: Text(
                  'Send us feedback',
                  style: TextStyle(color: Colors.black),
                ),
                buttonColor: Colors.white,
                radius: 50,
                height: 50,
                width: double.infinity,
              )
            ],
          ),
        ),
      );

  buildButton(treatment) => ReusableButton(
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Text('Continue'),
            Spacer(
              flex: 2,
            ),
            Icon(
              Icons.keyboard_arrow_right,
            )
          ],
        ),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => BookingScreen2(
                  isMultiSelection:
                      treatment.selectedTreatment.id == 1 ? true : false,
                  treatments: treatment.selectedTreatment,
                ))),
      );
}
