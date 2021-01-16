import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/therapist_image_widget.dart';

import 'therapist_detail_screen.dart';

class TherapistsScreen extends StatefulWidget {
  final Treatments treatments;

  const TherapistsScreen({Key key, this.treatments}) : super(key: key);

  @override
  _TherapistsScreenState createState() => _TherapistsScreenState();
}

class _TherapistsScreenState extends State<TherapistsScreen> {
  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false)
        .getTherapists(widget.treatments.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, therapist, child) => Scaffold(
          appBar: AppBar(
            title: Text('Therapists'),
          ),
          body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: therapist.therapists.length,
            itemBuilder: (context, index) {
              final therapists = therapist.therapists[index];
              return Padding(
                padding: const EdgeInsets.all(2),
                child: GestureDetector(
                  onTap: () => showBarModalBottomSheet(
                      context: context,
                      bounce: false,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      builder: (context) => AvailabilityScreen(
                            therapists: therapists,
                          )),

                  /*Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      reverseTransitionDuration: Duration(seconds: 1),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        final curvedAnimation = CurvedAnimation(
                            curve: Interval(0, 0.5), parent: animation);
                        return FadeTransition(
                          opacity: curvedAnimation,
                          child: TherapistDetailScreen(
                            animation: animation,
                            therapists: therapists,
                          ),
                        );
                      })),*/
                  child: ImageWidget(
                    therapists: therapists,
                  ),
                ),
              );
            },
          )),
    );
  }
}

class AvailabilityScreen extends StatelessWidget {
  final Therapists therapists;

  const AvailabilityScreen({Key key, this.therapists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, provider, child) => Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Pick a time',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Column(
              children:
                  List.generate(therapists.defaultAvailability.length, (index) {
                final availability = therapists.defaultAvailability[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      child: CheckboxListTile(
                        onChanged: (value) {},
                        value: false,
                        title: Text(
                          availability.displayValue,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
