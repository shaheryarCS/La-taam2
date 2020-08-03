import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wordpair_generator/Chef.dart';
import 'package:wordpair_generator/models/Appitizer.dart';

class SearchService {
  static List<Appitizer> getListAppi(List<Appitizer> l)
  {
    return l;}
  static  searchDjangoApi(String query,
      List<Appitizer> list ) async {
    String API_NO_Str="";
    String HT="http://";
    String ChefCRUD=":8000/food/chefs/";
  //  API_NO_Str=API_NO.text;
  //  var url ='$HT$API_NO$ChefCRUD';


    final response =
    await http.get("http://192.168.0.102:8000/food/chefs/");
   // await http.get("http://192.168.0.102:8000/food/chefDetail/");
    //await http.get(url);

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Appitizer.fromJson(data))
          .toList();
//      if(list.isEmpty)
//        print("yes it is empty");
      getListAppi(list);

    } else {
      throw Exception('Failed to load photos');

    }

  }

  static Future<String> packageDetail(String query) async {
    // String url = 'http://192.168.43.129:8000/api/questions/?search=$query';
    String url = 'http://192.168.0.102:8000/food/Main_menuCRUD/?search=$query';
    http.Response response = await http.get(Uri.encodeFull(url));

    print("search_service.dart: searchDjangoApi: ${response.body}");

    return response.body;
  }


}
