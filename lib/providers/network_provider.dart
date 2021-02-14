import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/network_request/get_request.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkProvider() {
    getCities();
  }

  List<Treatments> treatments = [];
  List<Cities> cities = [];
  List<Therapists> therapists = [];

//treatment
  getTreatments(int id) {
    Future<List<Treatments>> treatmentList =
        NetWorkRequest.fetchTreatmentList(id);
    treatmentList.then((value) {
      treatments = value;
      notifyListeners();
    });
  }

  Treatments treatment;
  setSelectedTreatment(Treatments treatments) {
    treatment = treatments;
    treatment.isSelected = !treatment.isSelected;
    notifyListeners();
  }

// set selected duration
  Durations selectedDuration;
  setSelectedDuration(Durations duration) {
    selectedDuration = duration;
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

  Therapists selectedtherapist;
  setselectedtherapist(Therapists therapists) {
    selectedtherapist = therapists;
    therapists.isSelected = !therapists.isSelected;
    notifyListeners();
  }

  //Set selected availability
  DefaultAvailability availability;
  setAvailability(DefaultAvailability availability) {
    this.availability = availability;
    notifyListeners();
  }
}
