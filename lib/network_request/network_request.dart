import 'dart:convert';

import 'package:ulomobile_project/models/cities.dart';
import 'package:ulomobile_project/models/gifts.dart';
import 'package:ulomobile_project/models/therapists.dart';
import 'package:ulomobile_project/models/treatment.dart';
import 'package:ulomobile_project/widgets/url.dart';
import 'package:http/http.dart' as http;

class NetWorkRequest {
  static bookAppointment(
      {token,
      cityId,
      treatmentId,
      therapistIds,
      Durations duration,
      date,
      DefaultAvailability time,
      fname,
      lname,
      postalCode,
      street,
      emailAddress,
      phoneNumber,
      specialInstructions,
      buildingType,
      source,
      city,
      province,
      discountCode}) async {
    final String url = 'https://api.ulomobilespa.com/stripePayment';
    var params = Map();

    params['token'] = "1234567890";
    params['paymentData']['cityID'] = cityId;
    params['paymentData']['treatmentId'] = treatmentId;
    params['paymentData']['therapistIds'] = therapistIds;
    params['paymentData']['duration']['id'] = duration.id;
    params['paymentData']['duration']['length'] = duration.length;
    params['paymentData']['duration']['price'] = duration.price;
    params['paymentData'] = date;
    params['paymentData']['key'] = time.key;
    params['paymentData']['displayValue'] = time.displayValue;
    params['client']['firstName'] = fname;
    params['client']['lastName'] = lname;
    params['client']['street'] = street;
    params['client']['postalCode'] = postalCode;
    params['client']['emailAddress'] = emailAddress;
    params['client']['phoneNumber'] = phoneNumber;
    params['client']['specialInstructions'] = specialInstructions;
    params['client']['buildingType'] = buildingType;
    params['client']['source'] = source;
    params['client']['city'] = city;
    params['client']['province'] = province;

    var mapData = json.encode(params);

    //send the request to the server and get the response
    var response = await http.post(url, body: mapData);
    if (response.statusCode == 201) {
      print(response);
    } else {
      throw Exception('Failed to load data');
    }
  }

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
