import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/widgets/login_button.dart';

class TreatmentDetailScreen extends StatefulWidget {
  final Treatments treatments;
  final Animation animation;

  const TreatmentDetailScreen({Key key, this.animation, this.treatments})
      : super(key: key);

  @override
  _TreatmentDetailScreenState createState() => _TreatmentDetailScreenState();
}

class _TreatmentDetailScreenState extends State<TreatmentDetailScreen> {
  bool isExpanded = false;
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
                              widget.treatments.image,
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
            height: isExpanded ? height / 1.1 : height / 1.5,
            child: AnimatedContainer(
              curve: Curves.slowMiddle,
              duration: Duration(seconds: 3),
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
                      padding: isExpanded
                          ? const EdgeInsets.only(top: 25)
                          : const EdgeInsets.all(16),
                      child: Text(
                        widget.treatments.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: widget.treatments.desc
                              .map((map) => Text(
                                    map,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ))
                              .toList(),
                        )),
                    Text('Pick a duration',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Column(
                      children: widget.treatments.duration
                          .map((map) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(map.length),
                                        ),
                                        Spacer(),
                                        Text('\$' + map.price.toString()),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    LoginButton(
                      buttonColor: Colors.yellow,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) => null));
                      },
                      height: 50,
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 20),
                      ),
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 0,
              top: isExpanded ? 12 : 250,
              child: IconButton(
                iconSize: 32,
                icon: isExpanded
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    : Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              )),
        ],
      ),
    );
  }
}
