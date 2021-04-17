import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/gifts.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/network_request/network_request.dart';
import 'package:ulomobile_project/screens/booking_screen2.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkProvider() {
    getCities();
    getGiftTypes();
  }
  List<Gifts> giftTypes = [];

  List<Treatments> treatments = [];
  List<Cities> cities = [];
  List<Therapists> therapists = [];

  Gifts selectedGift;
  setselectedGift(Gifts gifts) {
    selectedGift = gifts;
    notifyListeners();
  }

  getGiftTypes() {
    Future<List<Gifts>> giftTypes = NetWorkRequest.getGiftTypes();
    giftTypes.then((giftType) {
      this.giftTypes = giftType;
      notifyListeners();
    });
  }

//treatment
  getTreatments(int id) {
    Future<List<Treatments>> treatmentList =
        NetWorkRequest.fetchTreatmentList(id);
    treatmentList.then((value) {
      treatments = value;
      notifyListeners();
    });
  }

  Treatments selectedTreatment;
  setSelectedTreatment(Treatments treatments) {
    selectedTreatment = treatments;
    selectedTreatment.isSelected = !selectedTreatment.isSelected;
    notifyListeners();
  }

// set selected duration
  Durations selectedDuration;
  setSelectedDuration(Durations duration) {
    selectedDuration = duration;
    selectedDuration.isSelected = !selectedDuration.isSelected;
    notifyListeners();
  }

  List<Therapists> selectedTherapists = [];
  Therapists singleTherapist;
  Therapists singletherapists;
  selectedTherapist(
      bool isMultiSelection, Therapists therapists, BuildContext context) {
    if (isMultiSelection) {
      final isSelected = selectedTherapists.contains(therapists);
      isSelected
          ? selectedTherapists.remove(therapists)
          : selectedTherapists.add(therapists);
      notifyListeners();
    } else if (therapists.defaultAvailability.isEmpty) {
      buildSnackBar(context);
      return;
    } else {
      singleTherapist = therapists;
      navigateToAvailabilityScreen(context, therapists);
      notifyListeners();
    }
    therapists.isSelected = !therapists.isSelected;
    notifyListeners();
  }

//Cities
  getCities() {
    Future<List<Cities>> cities = NetWorkRequest.getCities();
    cities.then((value) {
      this.cities = value;
      notifyListeners();
    });
  }

  // set selected city
  Cities selectedCity;
  setSelectedCity(Cities city) {
    selectedCity = city;
    notifyListeners();
  }

//Therapists
  getTherapists(int id) {
    Future<List<Therapists>> therapists = NetWorkRequest.getTherapists(id);
    therapists.then((therapist) {
      this.therapists = therapist;
      notifyListeners();
    });
  }

  //Set selected availability
  DefaultAvailability availability;
  setAvailability(DefaultAvailability availability) {
    this.availability = availability;
    notifyListeners();
  }
}
