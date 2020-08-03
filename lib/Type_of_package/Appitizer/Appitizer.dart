
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/Services/search_services.dart';
import 'package:wordpair_generator/models/Appitizer.dart';
import 'package:wordpair_generator/Chef.dart';
import 'package:wordpair_generator/models/classes.dart';

class FoodType  extends StatefulWidget {
  final String name;
  FoodType(this.name);
  List<Main_menu> Main_list = List();


//  @override
  FoodTypeSate createState() => FoodTypeSate();


}


class FoodTypeSate extends State<FoodType> {
//String name="aaa";
String info;
List<Appitizer> list;



void  _getThingsOnStartup() async {
  _fetchData();
//  SearchService.searchDjangoApi("", list );
//  setState(() {
//
//
//  });
}
@override
void initState() {
  //
  super.initState();

  _getThingsOnStartup();
//  if(list.length==0)
//    print("empty");
//print(list[0].title);

}


_fetchData() async {

  final response =
  await http.get("http://192.168.0.102:8000/food/chefs/");
  //await http.get(url);

  if (response.statusCode == 200) {
    list = (json.decode(response.body) as List)
        .map((data) => new Appitizer.fromJson(data))
        .toList();
    setState(() {


    });

  } else {
    throw Exception('Failed to load photos');

  }

}
@override
Widget build(BuildContext context) {
  return Container(
    child: new Row(
      children: <Widget>[
//        new Container(
//          child: new Text(name),
//        ),
        new Container(
          //child: new Text(list[0].title),
          child: new Text(widget.name),
        ),
        //  middleSection,
        // rightSection
      ],
    ),
  );
  return new Text(list[0].title);
// child: new Text("list[0]"),
  //);
}
}