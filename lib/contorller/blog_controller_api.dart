import 'dart:convert';

import 'package:saman_project/api/api_settings.dart';
import 'package:saman_project/models/blog.dart';

import 'package:http/http.dart' as http;
class BlogControllerApi{


  Future<List<Blog>> indexBlog({required int perPage, required int current_page}) async{

    var url = Uri.parse(ApiSettings.BLOG + "?page=$current_page&per_page=$perPage");

    var response = await http.get(url);
    print("Blog Code :  ${response.statusCode}");

    if(response.statusCode == 200){
      print("Blog Code 1:  ${response.statusCode}");
      print( "json : ${jsonDecode(response.body)}");
      print( "json Type : ${jsonDecode(response.body).runtimeType}");
       var jsonResponse = jsonDecode(response.body)['success']['data'] as List;
    print(jsonResponse.runtimeType);
    return jsonResponse.map((e) => Blog.fromJson(e)).toList();

    }
    return [];
  }



}