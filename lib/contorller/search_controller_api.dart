import 'dart:convert';

import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/models/cars.dart';
import 'package:saman_project/models/colors.dart';
import 'package:http/http.dart' as http;
import 'package:saman_project/models/models.dart';

class SearchControllerApi {
  Future<List<ColorsCars>> indexColors() async {
    var url = Uri.parse(ApiSettings.GETCOLORS);

    var response = await http.get(url);
    print("Colors Code :  ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Blog Code 1:  ${response.statusCode}");
      print("json : ${jsonDecode(response.body)}");
      print("json Type : ${jsonDecode(response.body).runtimeType}");
      var jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse.runtimeType);
      return jsonResponse.map((e) => ColorsCars.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<ModelsCars>> indexModels() async {
    var url = Uri.parse(ApiSettings.GETMODELS);

    var response = await http.get(url);
    print("Colors Code :  ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Blog Code 1:  ${response.statusCode}");
      print("json : ${jsonDecode(response.body)}");
      print("json Type : ${jsonDecode(response.body).runtimeType}");
      var jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse.runtimeType);
      return jsonResponse.map((e) => ModelsCars.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Cars>> indexSearch({
    required String model,
    required String type,
    required String price_from,
    required String price_to,
    required String isOld,
    required String color,
  }) async {
    var url = Uri.parse(ApiSettings.CARS +
        "?model=$model&search=$type&price_from=$price_from&price_to=$price_to&is_old=$isOld&color=$color");

    var response = await http.get(url);
    print("Colors Code :  ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Blog Code 1:  ${response.statusCode}");
      print("json : ${jsonDecode(response.body)}");
      print("json Type : ${jsonDecode(response.body).runtimeType}");
      var jsonResponse = jsonDecode(response.body)["data"]["data"] as List;
      print(jsonResponse.runtimeType);
      return jsonResponse.map((e) => Cars.fromJson(e)).toList();
    }
    return [];
  }
}
