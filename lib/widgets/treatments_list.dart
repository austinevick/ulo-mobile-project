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
        builder: (context, provider, child) => TextButton(
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
                decoration: BoxDecoration(
                    color: treatments == provider.selectedTreatment
                        ? Colors.green[100]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                height: MediaQuery.of(context).size.height / 1.4,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: treatments.image.isEmpty
                          ? Image.asset('images/placeholder-image.png',
                              height: MediaQuery.of(context).size.height / 3.8,
                              width: double.infinity,
                              alignment: Alignment.center,
                              fit: BoxFit.cover)
                          : Image.network(
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
                        style:
                            TextStyle(fontSize: 22, color: Color(0xff053738)),
                      ),
                    ),
                    Column(
                      children: treatments.desc
                          .map((t) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff053738)),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ));
  }
}
