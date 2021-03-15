import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/treatment_duration.dart';

import '../internet_connectivity.dart';

class TreatmentList extends StatelessWidget {
  final Treatments treatments;
  final Color color;
  final double offset;

  const TreatmentList({Key key, this.treatments, this.color, this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, provider, child) => FlatButton(
              onPressed: () {
                provider.setSelectedTreatment(treatments);
                NetworkConnectivityChecker.checkConnection(context, () {
                  showBarModalBottomSheet(
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      builder: (context) => TreatmentDuration(
                            treatments: treatments,
                          ),
                      context: context);
                });
              },
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 1,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ListView(
                    children: <Widget>[
                      Image.network(
                        'https://images.ulomobilespa.com/treatments/${treatments.image}',
                        height: MediaQuery.of(context).size.height / 3.8,
                        width: double.infinity,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 6),
                      Text(
                        treatments.name,
                        style: GoogleFonts.redressed(
                            fontSize: 25, color: Color(0xff053738)),
                      ),
                      Column(
                        children: treatments.desc
                            .map((t) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    t,
                                    style: GoogleFonts.redressed(
                                        fontSize: 19, color: Color(0xff053738)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
