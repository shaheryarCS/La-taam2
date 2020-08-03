import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:wordpair_generator/Chef_Pages/UpdateList.dart';
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';
import 'Enter_Items.dart';
import 'Update.dart';
import 'CustomerList.dart';
import 'Customer_Order_Day.dart';




class ChefCRUD extends StatefulWidget {
  static Customer cust;
  Chef chef;
  ChefCRUD(this.chef);

  @override
  ChefCRUDState createState() => ChefCRUDState();
}

class ChefCRUDState extends State<ChefCRUD> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  List<Order> list ;

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


    var response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(getUrlWithOutSerach("orderlist"));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Order.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed to load photos');

    }


    response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(getUrlWithOutSerach("orderlist"));
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
          title: Text(''),


        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Enter Items'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Enter_Item(widget.chef)));
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Upadate Items'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Update(widget.chef)));
                },

              ),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.redAccent,
            child: Text('Custmer Lists'),
            onPressed: () {
              // TODO
              //  Navigator.pushNamed(context, "write your route");
              Navigator.push(context, MaterialPageRoute(builder: (context) => Customer_Order_Day(widget.chef)));
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