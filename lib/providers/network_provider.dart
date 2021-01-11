import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/network_request/get_request.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkProvider() {
    getTreatments();
    getCities();
    getTherapists();
  }

  List<Treatments> treatments = [];
  List<Cities> cities = [];
  List<Therapists> therapists = [];

//treatment
  getTreatments() {
    Future<List<Treatments>> treatmentList =
        NetWorkRequest.fetchTreatmentList();
    treatmentList.then((value) {
      treatments = value;
      notifyListeners();
    });
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
  getTherapists() {
    Future<List<Therapists>> therapists = NetWorkRequest.getTherapists();
    therapists.then((therapist) {
      this.therapists = therapist;
      notifyListeners();
    });
  }
}
