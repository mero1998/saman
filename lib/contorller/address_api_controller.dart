import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:saman_project/preference/user_prefernce.dart';
import 'package:saman_project/utils/constans.dart';
class AddressApiController {


  Future<Address?> addNewAddress(
      {required String firstName, required String lastName, required String postalCode, required String city, required String area, required String street}) async {
    var url = Uri.parse(ApiSettings.ADDRESS);
    print(url);
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: UserPreferences().getToken(),
        },
        body: {
          "title": firstName + lastName,
          "address": city + area,
          "pincode": postalCode,
          "street": street,
          "appartment": "appartment",
          "city": city,
          "area": area,
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var addressResponse = jsonDecode(response.body)['success'];

      Get.snackbar(
          "نجاح", "تم اضافة العنوان بنجاح", backgroundColor: kPrimaryColor);

      return Address.fromJson(addressResponse);
    } else {
      Get.snackbar("فشل", jsonDecode(response.body)['message'],
          backgroundColor: Colors.red);

      return null;
    }
  }


  Future<Address?> indexAddress() async {
    var url = Uri.parse(ApiSettings.ADDRESS);

    var response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader: UserPreferences().getToken(),

        });
    if (response.statusCode == 200) {
      print("json : ${jsonDecode(response.body)}");
      var jsonResponse = jsonDecode(response.body)['success'];
      print(jsonResponse.runtimeType);
      return jsonResponse.map((e) => Address.fromJson(e));
    } else {
      return null;
    }
  }
}