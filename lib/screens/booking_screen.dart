import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';
import 'package:ulomobile_project/widgets/treatments_list.dart';

import 'booking_screen2.dart';

class BookingScreen1 extends StatefulWidget {
  final Cities cities;
  BookingScreen1({Key key, this.cities}) : super(key: key);

  @override
  _BookingScreen1State createState() => _BookingScreen1State();
}

class _BookingScreen1State extends State<BookingScreen1> {
  PageController pageController;
  double pageOffset = 0;
  final List _colors = [
    Color(0xffb7a5ca),
    Color(0xfff1b1a6),
    Color(0xff45101e),
    Color(0xff61534e),
  ];

  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false)
        .getTreatments(widget.cities.id);
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, treatment, child) =>
          widget.cities.id == 2 || widget.cities.id == 3
              ? SafeArea(child: Scaffold(body: buildErrorPage()))
              : SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Pick a treatment'),
                    ),
                    body: treatment.treatments.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: treatment.treatments.length,
                                itemBuilder: (ctx, index) {
                                  final Color color =
                                      _colors[index % _colors.length];
                                  final treatments =
                                      treatment.treatments[index];
                                  return TreatmentList(
                                    treatments: treatments,
                                    color: color,
                                    offset: pageOffset,
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ),
    );
  }

  buildErrorPage() => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.pink])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We are coming soon to your location',
                style: GoogleFonts.aladin(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              LoginButton(
                child: Text(
                  'Send us feedback',
                  style: TextStyle(color: Colors.black),
                ),
                buttonColor: Colors.white,
                radius: 50,
                height: 50,
                width: double.infinity,
              )
            ],
          ),
        ),
      );
}
