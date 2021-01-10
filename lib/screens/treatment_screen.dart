import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/constants.dart';
import 'package:ulomobile_project/providers/network_provider.dart';

import 'treatment_detail_screen.dart';

class TreatmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, treatment, child) => Scaffold(
            appBar: AppBar(
              title: Text('Pick a Treatments'),
            ),
            body: treatment.treatments.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: treatment.treatments.length,
                    itemBuilder: (context, index) {
                      final treatments = treatment.treatments[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(seconds: 1),
                              reverseTransitionDuration: Duration(seconds: 1),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                final curvedAnimation = CurvedAnimation(
                                    curve: Interval(0, 0.5), parent: animation);
                                return FadeTransition(
                                  opacity: curvedAnimation,
                                  child: TreatmentDetailScreen(
                                      animation: animation,
                                      treatments: treatments),
                                );
                              }));
                        },
                        child: Hero(
                          tag: treatments.id,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                alignment: Alignment.center,
                                height: 150,
                                child: Text(
                                  treatments.name,
                                  style: contentStyle,
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black54, BlendMode.darken),
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://images.ulomobilespa.com/treatments/' +
                                                treatments.image))),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )));
  }
}
