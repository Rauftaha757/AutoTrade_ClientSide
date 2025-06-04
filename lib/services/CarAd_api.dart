import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:provider/provider.dart';
class CarAd_apiservice {
  static final baseurl =  "http://192.168.18.62:3000";

  static Future<void> publishad(BuildContext context,CarAd_model CarAd_model)async {
    final url =Uri.parse("${baseurl}/api/publishAd");
  try  {
      final response = await http.post(
          url, headers: {'Content-Type': 'application/json'},
          body: jsonEncode(CarAd_model.tojson()));
      if(response.statusCode==200 ){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Ad published successfully!")));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("FAiled to Publish ad ${response.body }" )));
        }
      }
    catch(err){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }
  // get data

  static Future<List<CarAd_model>> getads(BuildContext context) async {
    final url = Uri.parse("${baseurl}/api/getallcarad");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final dataList = jsonData['data']; // ✅ access the "data" array

        final List<CarAd_model> ads = List<CarAd_model>.from(
          dataList.map((item) => CarAd_model.fromjson(item)),
        );

        return ads;
      } else {
        print("Error in fetching ads: ${response.statusCode}");
        return [];
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${err.toString()}')),
      );
      return [];
    }
  }

  // CarAd_api.dart
  static Future<List<CarAd_model>> getcarbysearch({
    String? name,
    String? company,
    String? city,
    String? enginecapacity,
    required BuildContext context,
  }) async {
    final url = Uri.parse("$baseurl/api/getcarbysearch");

    final Map<String, String?> body = {
      'name': name,
      'company': company,
      'city': city,
      'enginecapacity': enginecapacity,
    }..removeWhere((key, value) => value == null || value.isEmpty); // removes empty filters

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsondata = jsonDecode(response.body);
        final data = jsondata['data'];

        return List<CarAd_model>.from(
          data.map((item) => CarAd_model.fromjson(item)),
        );
      } else {
        print("Error in fetching ads: ${response.statusCode}");
        return [];
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
      return [];
    }
  }







}
