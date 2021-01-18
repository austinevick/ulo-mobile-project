import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';
import 'package:ulomobile_project/widgets/therapist_image_widget.dart';

import 'therapist_availability_screen.dart';
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
          body: therapist.therapists.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: therapist.therapists.length,
                  itemBuilder: (context, index) {
                    final therapists = therapist.therapists[index];
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: therapists.defaultAvailability.isEmpty
                            ? () => showGeneralDialog(
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                        opacity: a1.value,
                                        child: Dialog(
                                          child: Container(
                                            height: 100,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'There is no specified time for selected therapist',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 400),
                                barrierDismissible: true,
                                barrierLabel: '',
                                context: context,
                                pageBuilder:
                                    (context, animation1, animation2) {})
                            : () => showBarModalBottomSheet(
                                context: context,
                                bounce: false,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                builder: (context) => AvailabilityScreen(
                                      therapists: therapists,
                                    )),
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
