import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/providers/network_provider.dart';

class TherapistDetailScreen extends StatelessWidget {
  final Therapists therapists;
  final Animation animation;
  TherapistDetailScreen({Key key, this.animation, this.therapists})
      : super(key: key);
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, therapist, child) => Scaffold(
        appBar: ScrollAppBar(
          controller: controller,
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
          title: Text(therapists.name),
        ),
        body: ListView(
          controller: controller,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                    width: double.infinity,
                    height: 150,
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 100.0)))),
                Hero(
                  tag: therapists.id,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://images.ulomobilespa.com/therapists/' +
                              therapists.avatar),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    therapists.emailAddress,
                  ),
                  Text(
                    therapists.credentials,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                      children: therapists.description
                          .map((map) => Text(
                                map,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ))
                          .toList()),
                  Column(
                    children: List.generate(
                        therapists.defaultAvailability.length, (index) {
                      final availability =
                          therapists.defaultAvailability[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.white,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    availability.displayValue,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
