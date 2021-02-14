import 'dart:convert';

import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/widgets/url.dart';
import 'package:http/http.dart' as http;

class NetWorkRequest {
  // Get list of treatments
  static Future<List<Treatments>> fetchTreatmentList(int id) async {
    final treatmentUrl = 'https://api.ulomobilespa.com/cities/$id/treatments';
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
// Get list of therapist
  static Future<List<Therapists>> getTherapists(int id) async {
    List<Therapists> therapists = [];

    final String therapistUrl =
        'https://api.ulomobilespa.com/treatments/$id/therapists?name=sheyi&password=123456';

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

  void bookTherapists(name, address, postalCode, cityID, treatmentID) async {
    final String url =
        'https://api.ulomobilespa.com/treatments/therapists?name=sheyi&password=123456';

    var params = Map();

    params['token'] = "1234567890";
    params['paymentData']['cityID'] = cityID;
    params['paymentData']['treatmentId'] = treatmentID;
    params['name'] = name;
    params['address'] = address;
    params['postal-code'] = postalCode;
    var mapData = json.encode(params);

    //send the request to the server and get the response
    var response = await http.post(url, body: mapData);
  }
}
