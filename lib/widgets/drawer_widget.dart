import 'package:flutter/material.dart';
import 'package:ulomobile_project/screens/treatment_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Colors.purple,
            height: 160,
          ),
          ListTile(
            title: Text('Login'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => TreatmentScreen()));
            },
            title: Text('Treatments'),
          ),
          ListTile(
            title: Text('Therapists'),
          ),
          ListTile(
            title: Text('Prices'),
          ),
          ListTile(
            title: Text('Gifts'),
          ),
          ListTile(
            title: Text('Our blogs'),
          ),
          ListTile(
            title: Text('Join our team'),
          ),
          Divider(
            thickness: 2.1,
          ),
          ListTile(
            title: Text('Share'),
          ),
          ListTile(
            title: Text('Rate us'),
          ),
          ListTile(
            title: Text('Contact us'),
          ),
        ],
      ),
    );
  }
}
