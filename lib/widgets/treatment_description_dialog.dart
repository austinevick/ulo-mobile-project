import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/treatment.dart';

class TreatmentDescriptionDialog extends StatelessWidget {
  final Treatments treatments;

  const TreatmentDescriptionDialog({Key key, this.treatments})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                treatments.name,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: treatments.desc
                      .map((map) => Text(
                            map,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ))
                      .toList(),
                )),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Text(
                  'CLOSE',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
