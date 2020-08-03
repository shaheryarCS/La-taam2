import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import './random_words.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/Login_and_sign_in/Log_In.dart';
//import 'Chef.dart';
class ChefList extends StatefulWidget {
  static Customer cust;

  @override
  ChefListState createState() => ChefListState();
}

class ChefListState extends State<ChefList> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  TextEditingController api_Controler = new TextEditingController();
  int chef_no=0;
  Resources r=new Resources();

  var isLoading = false;
  TextEditingController API_NO = new TextEditingController();
  String API_NO_Str="";
  String HT="http://";
  String ChefCRUD=":8000/food/chefs/";
 Customer c;
  void  _getThingsOnStartup() async {
    _fetchData();
  }
  @override
  void initState() {
    //

    super.initState();
//    set_number("0.101");
    set_number(api_Controler.text);
  //  _getThingsOnStartup();

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
      throw Exception('Failed to load photos');

    }

  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("La Ta'am"),


        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
              onTap: () {
                    Navigator.pushNamed(context, "write your route");
                    r.Customer_bool=true;
                    r.chef_bool=false;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords(r,c)));
                   },
                  child: new Text("")
                 ),
              new TextField(
                controller: api_Controler,
                decoration: InputDecoration(
                    hintText: "0.101", labelText: 'IP'),

              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('As a customer'),
                onPressed: () {
                  set_number(api_Controler.text);
                  String i=api_Controler.text;
                  print(num);
                  // TODO
                //  Navigator.pushNamed(context, "write your route");
                  r.Customer_bool=true;
                  r.chef_bool=false;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(r)));
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('As a chef '),
                onPressed: () {
                  set_number(api_Controler.text);
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  r.Customer_bool=false;
                  r.chef_bool=true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(r)));
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


class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}
