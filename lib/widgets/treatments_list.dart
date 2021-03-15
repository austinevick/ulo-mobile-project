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
              shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)),
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
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Card(
                  elevation: 2,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          'https://images.ulomobilespa.com/treatments/${treatments.image}',
                          height: MediaQuery.of(context).size.height / 3.8,
                          width: double.infinity,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          treatments.name,
                          style: GoogleFonts.redressed(
                              fontSize: 25, color: Color(0xff053738)),
                        ),
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
