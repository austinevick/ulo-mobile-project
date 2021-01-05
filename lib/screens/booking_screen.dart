import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/network%20request/get_request.dart';
import 'package:ulomobile_project/providers/network_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false).getTherapists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetWorkRequest.getTherapists();
    return Scaffold(
      body: Consumer<NetworkProvider>(
        builder: (c, t, ch) => ListView.builder(
          itemCount: t.therapists.length,
          itemBuilder: (context, i) => Column(
              children: t.therapists[i].defaultAvailability
                  .map((map) => Text(map.displayValue))
                  .toList()),
        ),
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book here'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
