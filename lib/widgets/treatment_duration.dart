import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/booking_screen2.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';

import '../internet_connectivity.dart';
import 'custom_check_box.dart';

class TreatmentDuration extends StatelessWidget {
  final Treatments treatments;

  const TreatmentDuration({Key key, this.treatments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, durations, child) => Container(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    color: Colors.indigo,
                    child: Text(
                      'Pick a Duration',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: durations.treatments.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            children: List.generate(treatments.duration.length,
                                (index) {
                            final selectedDuration = treatments.duration[index];
                            return GestureDetector(
                              onTap: () => durations
                                  .setSelectedDuration(selectedDuration),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Material(
                                        // elevation: 2,
                                        //borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                      decoration: BoxDecoration(
                                          color: durations.selectedDuration ==
                                                  selectedDuration
                                              ? Colors.green[100]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              selectedDuration.length,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              '\$' +
                                                  selectedDuration.price
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Spacer(),
                                            AnimatedSwitcher(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                child: durations
                                                            .selectedDuration ==
                                                        selectedDuration
                                                    ? CustomCheckBox(
                                                        color: Colors.green,
                                                      )
                                                    : CustomCheckBox(
                                                        color: Colors.white60,
                                                      )),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Divider(
                                      height: 1,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                  ),
                  durations.selectedDuration == null
                      ? SizedBox.shrink()
                      : ReusableButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => BookingScreen2(
                                      isMultiSelection:
                                          durations.selectedTreatment.id == 1
                                              ? true
                                              : false,
                                      treatments: durations.selectedTreatment,
                                    )));
                          },
                        )
                ],
              ),
            ));
  }
}
