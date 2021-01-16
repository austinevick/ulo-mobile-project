import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    Provider.of<NetworkProvider>(context, listen: false).getTherapists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, therapist, child) => Scaffold(
          appBar: AppBar(
            title: Text('Therapists'),
          ),
          body: ListView(
              children: List.generate(
                  therapist.therapists.length,
                  (i) => Column(
                        children: [
                          ListTile(
                            title: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(therapist.therapists[i].avatar),
                            ),
                          ),
                          Column(
                            children:
                                List.generate(therapist.therapists.length, (i) {
                              return Text(therapist.therapists[i].credentials);
                            }),
                          )
                        ],
                      )))

          /* GridView.builder(
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
          )*/
          ),
    );
  }
}
