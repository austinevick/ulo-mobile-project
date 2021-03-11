import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/providers/network_provider.dart';
import 'package:ulomobile_project/widgets/reusable_button.dart';
import 'package:ulomobile_project/widgets/therapist_image_widget.dart';
import '../internet_connectivity.dart';
import 'therapist_availability_screen.dart';
import 'therapist_detail_screen.dart';

class BookingScreen2 extends StatefulWidget {
  final Treatments treatments;
  final bool isMultiSelection;
  const BookingScreen2({
    Key key,
    this.isMultiSelection,
    this.treatments,
  }) : super(key: key);

  @override
  _BookingScreen2State createState() => _BookingScreen2State();
}

class _BookingScreen2State extends State<BookingScreen2> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String appBarTitle() =>
      widget.isMultiSelection ? 'Pick two therapist' : 'Pick a Therapist';

  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false)
        .getTherapists(widget.treatments.id);
    super.initState();
  }

  List<Therapists> selectedTherapists = [];
  selectedTherapist(Therapists therapists) {
    if (widget.isMultiSelection) {
      final isSelected = selectedTherapists.contains(therapists);
      setState(() => isSelected
          ? selectedTherapists.remove(therapists)
          : selectedTherapists.add(therapists));
    } else {
      navigateToAvailabilityScreen(context, therapists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, therapist, child) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(appBarTitle()),
          ),
          body: therapist.therapists.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: therapist.therapists.length,
                        itemBuilder: (context, index) {
                          final therapists = therapist.therapists[index];

                          return GestureDetector(
                            onTap: () {
                              selectedTherapist(therapists);
                              print('${therapists.name}');
                            },
                            child: ImageWidget(
                              therapists: therapists,
                              isSelected: therapists.isSelected,
                            ),
                          );
                        },
                      ),
                    ),
                    selectedTherapists.length == 2 ? buildButton() : Container()
                  ],
                )),
    );
  }

  buildSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.warning),
          ),
          Spacer(
            flex: 2,
          ),
          Text('Cannot pick more than two therapists',
              style: TextStyle(fontSize: 16)),
          Spacer(
            flex: 3,
          )
        ],
      ),
    ));
  }

  buildButton() => ReusableButton(onPressed: () {
        showBarModalBottomSheet(
            context: context,
            bounce: false,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            builder: (context) => AvailabilityScreen());
      });

  navigateToAvailabilityScreen(BuildContext context, Therapists therapists) {
    NetworkConnectivityChecker.checkConnection(context, () {
      showBarModalBottomSheet(
          context: context,
          bounce: false,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          builder: (context) => AvailabilityScreen(
                therapists: therapists,
              ));
    });
  }

  navigateToDetailScreen(BuildContext context, Therapists therapists) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation =
              CurvedAnimation(curve: Interval(0, 0.5), parent: animation);
          return FadeTransition(
            opacity: curvedAnimation,
            child: TherapistDetailScreen(
              therapists: therapists,
            ),
          );
        }));
  }
}
