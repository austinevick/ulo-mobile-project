import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/therapists.dart';

class TherapistDetailScreen extends StatelessWidget {
  final Therapists therapists;
  final Animation animation;

  const TherapistDetailScreen({Key key, this.animation, this.therapists})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(therapists.name),
      ),
      body: Column(
        children: [
          Container(
            child: Hero(
              tag: therapists.id,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'http://images.ulomobilespa.com/therapists/' +
                        therapists.avatar),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(therapists.emailAddress),
                  Text(therapists.credentials),
                  Column(
                      children:
                          therapists.desc.map((map) => Text(map)).toList())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
