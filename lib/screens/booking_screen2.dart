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
  String appBarTitle() =>
      widget.treatments.id == 1 ? 'Pick two therapist' : 'Pick a Therapist';

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
          appBar: AppBar(
            title: Text(appBarTitle() + ' ${widget.treatments.id}'),
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
                          final isSelected =
                              selectedTherapists.contains(therapists);
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: GestureDetector(
                              onTap: () {
                                selectedTherapist(therapists);
                                print(therapists.therapistId);
                              },
                              child: ImageWidget(
                                therapists: therapists,
                                isSelected: isSelected,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    widget.isMultiSelection
                        ? ReusableButton(child: Text('kkdkd'), onPressed: () {})
                        : Container()
                  ],
                )),
    );
  }

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
