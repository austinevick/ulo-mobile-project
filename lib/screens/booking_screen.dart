import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/treatments_list.dart';

import 'booking_screen2.dart';

class BookingScreen1 extends StatelessWidget {
  final Cities cities;
  BookingScreen1({Key key, this.cities}) : super(key: key);
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.purple,
    Colors.green
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, treatment, child) => Scaffold(
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
                        final treatments = treatment.treatments[index];
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
