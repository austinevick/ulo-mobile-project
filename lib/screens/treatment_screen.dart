import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/constants.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';

class TreatmentScreen extends StatefulWidget {
  @override
  _TreatmentScreenState createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false).getTreatments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
        builder: (context, treatment, child) => Scaffold(
            appBar: AppBar(
              title: Text('Treatments'),
            ),
            body: ListView.builder(
              itemCount: treatment.treatments.length,
              itemBuilder: (context, index) {
                final treatments = treatment.treatments[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        reverseTransitionDuration: Duration(seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          final curvedAnimation = CurvedAnimation(
                              curve: Interval(0, 0.5), parent: animation);
                          return FadeTransition(
                            opacity: curvedAnimation,
                            child: TreatmentDetailScreen(
                                animation: animation, treatments: treatments),
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

class TreatmentDetailScreen extends StatelessWidget {
  final Treatments treatments;
  final Animation animation;

  const TreatmentDetailScreen({Key key, this.animation, this.treatments})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: height / 2.5,
            child: Container(
                height: height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.ulomobilespa.com/treatments/' +
                              treatments.image,
                        )))),
          ),
          Positioned(
            left: 0,
            top: 25,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: height / 1.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        treatments.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
