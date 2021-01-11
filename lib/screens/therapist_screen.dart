import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/constants.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/therapist_image_widget.dart';

import 'therapist_detail_screen.dart';

class TherapistsScreen extends StatelessWidget {
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
                  onTap: () => Navigator.of(context).push(PageRouteBuilder(
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
                      })),
                  child: ImageWidget(
                    therapists: therapists,
                  ),
                ),
              );
            },
          )),
    );
  }

  openDetailPage(Therapists therapists) {}
}
