import 'dart:convert';

import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/models/blog.dart';

import 'package:http/http.dart' as http;
import 'package:saman_project/models/page.dart';
class PageControllerApi{


  Future<List<PageSetting>> indexPages() async{

    var url = Uri.parse(ApiSettings.PAGES);

    var response = await http.get(url);
    print("Pages Code :  ${response.statusCode}");

    if(response.statusCode == 200){
      print("Pages Code 1:  ${response.statusCode}");
      print( "json : ${jsonDecode(response.body)}");
      print( "json Type : ${jsonDecode(response.body).runtimeType}");
       var jsonResponse = jsonDecode(response.body)['success']['data'] as List;
    print(jsonResponse.runtimeType);
    return jsonResponse.map((e) => PageSetting.fromJson(e)).toList();

    }
    return [];
  }



}