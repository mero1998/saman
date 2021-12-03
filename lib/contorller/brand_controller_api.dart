import 'dart:convert';
import 'dart:io';

import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/models/brands.dart';
import 'package:http/http.dart' as http;
import 'package:saman_project/preference/user_prefernce.dart';


class BrandControllerApi{

  Future<List<Brands>> indexBrands({required int perPage, required int current_page}) async{
    var url = Uri.parse(ApiSettings.BRANDS+ "?page=$current_page&per_page=$perPage");
    var response = await http.get(url, headers: {
      // HttpHeaders.authorizationHeader : UserPreferences().getApiKey(),
      HttpHeaders.authorizationHeader : UserPreferences().getToken(),
    });
    print("Brand Code : ${response.statusCode}");
    if(response.statusCode == 200){
      print("Brand Code : ${response.statusCode}");
      var jsonResponse = jsonDecode(response.body)['success']['data'] as List;
      // current_page++;
      // print(current_page);
      print("Brands : $jsonResponse");
      List<Brands> brands = jsonResponse.map((e) => Brands.fromJson(e)).toList();
      return brands;
    }

    return [];
  }

}