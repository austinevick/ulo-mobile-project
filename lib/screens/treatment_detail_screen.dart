import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/screens/therapist_screen.dart';
import 'package:ulomobile_project/widgets/custom_check_box.dart';
import 'package:ulomobile_project/widgets/login_button.dart';
import 'package:ulomobile_project/widgets/treatment_description_dialog.dart';

class TreatmentDetailScreen extends StatelessWidget {
  final Treatments treatments;
  final Animation animation;

  const TreatmentDetailScreen({Key key, this.animation, this.treatments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<NetworkProvider>(
      builder: (context, treatmentsDuration, child) => Container(
        child: Column(
          children: [
            Container(
                height: height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.ulomobilespa.com/treatments/' +
                              treatments.image,
                        )))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(flex: 2),
                  Text(
                    treatments.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      size: 32,
                    ),
                    onPressed: () {
                      showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionBuilder: (context, a1, a2, widget) {
                            return Transform.scale(
                                scale: a1.value,
                                child: Opacity(
                                  opacity: a1.value,
                                  child: TreatmentDescriptionDialog(
                                    treatments: treatments,
                                  ),
                                ));
                          },
                          transitionDuration: Duration(milliseconds: 400),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    },
                  )
                ],
              ),
            ),
            Text('Duration',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                )),
            Column(
                children: List.generate(treatments.duration.length, (index) {
              final duration = treatments.duration[index];
              return GestureDetector(
                onTap: () {
                  print(duration);
                  treatmentsDuration.setSelectedDuration(duration);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              duration.length,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            '\$' + duration.price.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: treatmentsDuration.selectedDuration ==
                                      duration
                                  ? CustomCheckBox(
                                      color: Colors.green,
                                    )
                                  : CustomCheckBox(
                                      color: Colors.white,
                                    ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
            Spacer(),
            treatmentsDuration.selectedDuration == null
                ? Container()
                : LoginButton(
                    radius: 0,
                    buttonColor: Colors.yellow,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              TherapistsScreen(treatments: treatments)));
                    },
                    height: 65,
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 20),
                    ),
                    width: double.infinity,
                  ),
          ],
        ),
      ),
    );
  }
}

/*Scaffold(
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
                    Row(
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          widget.treatments.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          iconSize: 32,
                          icon: isExpanded
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                )
                              : Icon(Icons.keyboard_arrow_up),
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        )
                      ],
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
                        children: List.generate(
                            widget.treatments.duration.length, (index) {
                      final duration = widget.treatments.duration[index];
                      return GestureDetector(
                        onTap: () {
                          print(duration);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      duration.length,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$' + duration.price.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: LoginButton(
              radius: 0,
              buttonColor: Colors.yellow,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => null));
              },
              height: 65,
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20),
              ),
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  
*/
