import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';
import 'package:wordpair_generator/Chef_Pages/ChefCRUD.dart';


//import 'Chef.dart';
class SuccessSignin extends StatefulWidget {
  Resources r=new Resources();
  String message;
  SuccessSignin(this.message);
  @override
  SuccessSigninState createState() => SuccessSigninState();
}

class SuccessSigninState extends State<SuccessSignin> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  List<Chef> chef ;
  List<Customer> customer ;
  Chef c;
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
  TextEditingController nameControler = new TextEditingController();
  TextEditingController addressControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();
  TextEditingController phoneControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();

  int chef_no=0;


  var isLoading = false;


  void  _getThingsOnStartup() async {
//    _fetchData();
  }


  _fetchData(String name,String password) async {
    setState(() {
      isLoading = true;
    });



    final response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(geturl(name,password));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);
    if(widget.r.chef_bool) {
      if (response.statusCode == 200) {
        chef = (json.decode(response.body) as List)
            .map((data) => new Chef.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed');
      }
    }
    else
    {
      if (response.statusCode == 200) {
        customer = (json.decode(response.body) as List)
            .map((data) => new Customer.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed ');
      }
    }
//    while(chef==null|| customer==null)
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  void initState() {
    //

    super.initState();

  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rresponse'),


        ),
        body: Center(
          child:  Column(
            children: <Widget>[
              new Text(widget.message),


            ],
          ),
        )
    );
  }

}
