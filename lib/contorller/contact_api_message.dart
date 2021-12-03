import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:saman_project/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:saman_project/utils/constans.dart';

class ContactApiMessage {
  Future<bool> sendContactMessage(
      {required String name,
      required String email,
      required String message,
      required String countryCode,
      required String mobile,
      required String countryName}) async {
    var url = Uri.parse(ApiSettings.CONTACTS);
    print(url);
    var response = await http.post(url, headers: {
      "Accept": "application/json",

    }, body: {
      "name": name,
      "email": email,
      "mobile": mobile,
      "countryCode": countryCode,
      "countryName": countryName,
      "message": message,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.snackbar("تمت العملية بنجاح", jsonDecode(response.body)["message"],
          backgroundColor: kPrimaryColor);
      return true;
    }
    print("Error ${jsonDecode(response.body)["message"]}");
    Get.snackbar("خطأ", jsonDecode(response.body)['message']);
    return false;
  }
}
