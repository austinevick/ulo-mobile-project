import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
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
              ? Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'We are coming soon to your location',
                        style: GoogleFonts.aladin(fontSize: 35),
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    actions: [
                      treatment.selectedDuration == null
                          ? SizedBox.shrink()
                          : IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                size: 32,
                              ),
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => BookingScreen2(
                                            showDetailScreen: false,
                                          ))),
                            )
                    ],
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
                    ],
                  ),
                ),
    );
  }
}
