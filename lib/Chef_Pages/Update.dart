import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';
import 'Enter_Items.dart';
import 'UpdateList.dart';



class Update extends StatefulWidget {

  Chef chef;
  Update(this.chef);

  @override
  UpdateState createState() => UpdateState();
}

class UpdateState extends State<Update> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();


  TextEditingController nameControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();
  int chef_no=0;


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
    //set_number("0.101");
    _getThingsOnStartup();

  }

//  Future navigateToSubPage(context) async {
//    _fetchData();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
//  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


    final response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(getUrlWithOutSerach("chefs"));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
//      list = (json.decode(response.body) as List)
//          .map((data) => new Chef.fromJson(data))
//          .toList();
//      setState(() {
//        isLoading = false;
//
//      });
    } else {
      throw Exception('Failed ');

    }

  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),


        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Main Menu'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateList("m",widget.chef)));
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Appti'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateList("a",widget.chef)));
                },

              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Sweet'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateList("s",widget.chef)));
                },

                /*  GestureDetector(
                  onTap: () {
//                    Navigator.pushNamed(context, "write your route");
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
                  },
                  child: new Text("Chef")
              ),*/

              )
            ],
          ),
        )
    );
  }
}