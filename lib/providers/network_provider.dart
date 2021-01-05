import 'package:flutter/cupertino.dart';
import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/network%20request/get_request.dart';

class NetworkProvider extends ChangeNotifier {
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

//Cities
  getCities() {
    Future<List<Cities>> cities = NetWorkRequest.getCities();
    cities.then((value) {
      this.cities = value;
      notifyListeners();
    });
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
