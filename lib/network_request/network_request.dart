import 'dart:convert';

import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/gifts.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/widgets/url.dart';
import 'package:http/http.dart' as http;

class NetWorkRequest {
  // Get list of treatments
  static Future<List<Treatments>> fetchTreatmentList() async {
    final treatmentUrl = 'https://api.ulomobilespa.com/treatments';
    List<Treatments> treatments = [];
    final response = await http.get(treatmentUrl);
    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> data = result;
        data.forEach((map) => treatments.add(Treatments.fromMap(map)));
        print(data);
      } else
        throw Exception('Unable to fetch data');
    } catch (e) {
      print(e);
    }
    return treatments;
  }

//////////////////////////////////////////////////////////////////////////////////////////
  // Get list of cities
  static Future<List<Cities>> getCities() async {
    List<Cities> cities = [];
    final response = await http.get(citiesUrl);
    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> data = result;
        data.forEach((map) => cities.add(Cities.fromMap(map)));
        print(data);
      } else {
        throw Exception('Unable to fetch data');
      }
    } catch (e) {
      print(e);
    }
    return cities;
  }

  //////////////////////////////////////////////////////////////////////////////////////////
// Get list of Gift Types
  static Future<List<Gifts>> getGiftTypes() async {
    List<Gifts> giftTypes = [];

    final String giftTypeUrl = 'https://api.ulomobilespa.com/giftTypes';
    final response = await http.get(giftTypeUrl);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final data = result;
      //  print(data);

      data.forEach((map) => giftTypes.add(Gifts.fromMap(map)));
      return giftTypes;
    }
    throw Exception('Unable to fetch data');
  }

//////////////////////////////////////////////////////////////////////////////////////////
// Get list of therapist
  static Future<List<Therapists>> getTherapists() async {
    List<Therapists> therapists = [];

    final String therapistUrl = 'https://api.ulomobilespa.com/therapists';

    //send the request to the server and get the response
    final response = await http.get(therapistUrl);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final data = result;
      //  print(data);

      data.forEach((map) => therapists.add(Therapists.fromJson(map)));
      return therapists;
      // return data.map((map) => Therapists.fromMap(map)).toList();
    }
    throw Exception('Unable to fetch data');
  }
}
