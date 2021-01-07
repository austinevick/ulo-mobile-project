import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/therapists.dart';

import '../constants.dart';

class ImageWidget extends StatelessWidget {
  final Therapists therapists;

  const ImageWidget({Key key, this.therapists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Hero(
            tag: therapists.id,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'http://images.ulomobilespa.com/therapists/' +
                      therapists.avatar),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              therapists.name,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
