//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'UpdateFood.dart';
//import 'Chef.dart';
class UpdateList extends StatefulWidget {
  String foodType;
  Chef chef;
  UpdateList(this.foodType,this.chef);

  @override
  UpdateListState createState() => UpdateListState();
}

class UpdateListState extends State<UpdateList> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  int food_no=0,indexOfFood=0;

  Resources r=new Resources();
  List<Main_menu> Main_list = List();
  List<Appti> appti_list = List();
  List<Sweet> sweet_list = List();
  List<dynamic> food_list = List();

  List<Package> pack;
  String main="asas",appti="",sweet="";
  List<String>  mainListStr,apptiListStr,sweetListStr;

  List<Chef> list = List();
  var isLoading = false;
  TextEditingController API_NO = new TextEditingController();
  String API_NO_Str="";
  String HT="http://";
  String ChefCRUD=":8000/food/chefs/";

  void  _getThingsOnStartup() async {
    _fetchData();
  }
  @override
  void initState() {
    //

    super.initState();
    //  set_number("0.102");
    _getThingsOnStartup();

  }

  Future navigateToSubPage(context) async {



    //  _fetchData();
//    _fetchData_2();
//    print(main+appti+sweet);
    //print(Main_list);

    r.packages(Main_list,appti_list,sweet_list);

    r.foodNames(mainListStr,apptiListStr,sweetListStr);
    //   print("above resources");
    //  print(chef_no);
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo(list[chef_no],main,appti,sweet)));
//    while(mainListStr==null && apptiListStr==null && sweetListStr==null)
//      await Future.delayed(Duration(seconds: 1));
//    print(food_list[indexOfFood].name);
    print("food_list[indexOfFood].name"+" : " + food_list[indexOfFood].name);
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateFood(widget.chef,food_list[indexOfFood])));
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


    var response =
    //await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(getUrlWithOutSerach("chefs"));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new   Chef.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed');

    }

    if(widget. foodType=="m")
    {
      response =
      //await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(geturl("Main_menuGet",widget.chef.id.toString()));
      //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
      //await http.get(url);

      if (response.statusCode == 200) {
        food_list = (json.decode(response.body) as List)
            .map((data) => new Main_menu.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;

        });
      } else {
        throw Exception('Failed');

      }
      print(food_list);
      print("food_list.length : "+food_list.length.toString());
print("update list  fetch data");
    }
    else if(widget. foodType=="a")
    {
      response =
      //await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(geturl("ApptiGet",widget.chef.id.toString()));
      //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
      //await http.get(url);

      if (response.statusCode == 200) {
        food_list = (json.decode(response.body) as List)
            .map((data) => new Appti.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;

        });
      } else {
        throw Exception('Failed');

      }

    }
    else if(widget.foodType=="s")
    {
      response =
      //await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(geturl("SweetGet",widget.chef.id.toString()));
      //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
      //await http.get(url);

      if (response.statusCode == 200) {
        food_list = (json.decode(response.body) as List)
            .map((data) => new Sweet.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;

        });
      } else {
        throw Exception('Failed');

      }

    }

  }


  _fetchData_2() async {

  //  print(chef_no.toString());
    var response =
    await http.get(geturl("PackageGet",food_no.toString()));
   // await http.get("http://192.168.0.104:8000/food/PackageGet/?search=2");
    //await http.get(url);

    if (response.statusCode == 200) {
      pack = (json.decode(response.body) as List)
          .map((data) => new Package.fromJson(data))
          .toList();
      setState(() {


      });

    }
    else {
      throw Exception('Failed to load photos');

    }
//    print("the chef number"+ chef_no.toString());

    if(widget. foodType=="m") {
      response =
//    await http.get(geturl("Main_menuGet",chef_no.toString()));
      await http.get(geturl("Main_menuGet", food_no.toString()));
      //await http.get(url);

      if (response.statusCode == 200) {
        Main_list = (json.decode(response.body) as List)
            .map((data) => new Main_menu.fromJson(data))
            .toList();
        setState(() {

        });
      }
      else {
        throw Exception('Failed to load photos');
      }
      print("fetch 2 below pack");
      print(Main_list);
    }
    if(widget. foodType=="m") {
      response =
      await http.get(geturl("ApptiGet", food_no.toString()));
      //await http.get(url);

      if (response.statusCode == 200) {
        appti_list = (json.decode(response.body) as List)
            .map((data) => new Appti.fromJson(data))
            .toList();
        setState(() {


        });
      }
      else {
        throw Exception('Failed to load photos');
      }
    }


    if(widget. foodType=="m") {
      response =
      await http.get(geturl("SweetGet", food_no.toString()));
      //await http.get(url);

      if (response.statusCode == 200) {
        sweet_list = (json.decode(response.body) as List)
            .map((data) => new Sweet.fromJson(data))
            .toList();
        setState(() {


        });
      }
      else {
        throw Exception('Failed to load photos');
      }
    }
    r.chef=list[food_no];
    r.packages(Main_list,appti_list,sweet_list);

    r.foodNames(mainListStr,apptiListStr,sweetListStr);
  }


  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: food_list.length,
      itemBuilder: (context, item) {


        //  return _buildRow(_randomWordPairs[index]);
        return _buildRow(food_list[item].name,item);
      },
    );
  }

  Widget _buildRow(String pair,int food_no) {

    return ListTile(
        title: Text(pair, style: TextStyle(fontSize: 18.0)),

        onTap: () {
          setState(() {
            print("list.length.toString() "+list.length.toString());
            print("food_no : " +food_no.toString());

//            this.food_no=list[ food_no].id;
            this.food_no=food_list[ food_no].id;

            indexOfFood=food_no;
            // print("in navigate "+ this.chef_no.toString());
            navigateToSubPage(context);
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
      });

      final List<Widget> divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Items with Package No.'),


        ),
        body: _buildList());
  }
}



