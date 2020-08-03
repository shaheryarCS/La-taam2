import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/random_words.dart';
import 'package:wordpair_generator/Chef_Pages/ChefCRUD.dart';
import 'Sign_In.dart';
//import 'Chef.dart';
class Login extends StatefulWidget {
  static Customer cust;
  Resources r=new Resources();
  Login(this.r);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  List<Chef> chef ;
  List<Customer> customer ;

  TextEditingController nameControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();
  int chef_no=0;


  var isLoading = false;
  TextEditingController API_NO = new TextEditingController();
  String API_NO_Str="";
  String HT="http://";
  String Chefaddress=":8000/food/chefs/";

  void  _getThingsOnStartup() async {
    //_fetchData();
  }
  @override
  void initState() {
    //

    super.initState();
  //  set_number("0.101");
    _getThingsOnStartup();

  }

//  Future navigateToSubPage(context) async {
//    _fetchData();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
//  }

  _fetchData(String name,String password) async {
    setState(() {
      isLoading = true;
    });
    API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


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
        throw Exception('Failed ');
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
//    print(chef.length);

    while(chef==null|| customer==null)
      await Future.delayed(Duration(seconds: 1));

  }
//
//  void goto()
//  {
//    if(widget.r.chef_bool)
//      Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords()));
//    else
//      Navigator.push(context, MaterialPageRoute(builder: (context) => ChefCRUD()));
//  }

  _fetchData2() async {
    setState(() {
      isLoading = true;
    });

    print("Sign in ");

    var response ;
//    await http.get("http://192.168.0.102:8000/food/chefs/");

    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);
    if(widget.r.chef_bool) {
      response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(getUrlWithOutSerach("chefs"));
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

    if(widget.r.Customer_bool)
    {
      response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(getUrlWithOutSerach("Customerlist"));
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
    while(chef==null|| customer==null)
      await Future.delayed(Duration(seconds: 1));
    Resources.customer=customer[0];
    c=customer[0];
    Resources.Custid=customer[0].id;
    Resources.setCust(customer[0]);

  }

//  void checkPassword2() async
//  {
//    bool IsUser_Exist=false;
//    if(widget.r.Customer_bool) {
//      print(customer.toString());
//
//      for (int i = 0; i < customer.length; i++) {
//        if (customer[i].name == nameControler.text) {
//          IsUser_Exist = true;
//
//          print("name already exist");
//          break;
//        }
//      }
//      if (IsUser_Exist) {
//
//
//          Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords(widget.r)));
//      }
//    }
//    if(widget.r.chef_bool)
//    {
//      int i = 0;
//      for (; i < chef.length; i++) {
//        if (chef[i].name == nameControler.text) {
//          IsUser_Exist = true;
//          print("name already exist");
//          break;
//        }
//      }
//      if (IsUser_Exist) {
//
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ChefCRUD(chef[i])));
//      }
//    }
////          Navigator.push(
////
////              context, MaterialPageRoute(builder: (context) => RandomWords()));
////
////        }
//
//  }

  void checkPassword(String name,String password)
  {
    _fetchData(name,password);

    if(widget.r.Customer_bool)
      if(customer.length!=null)
        if(customer[0].password==pwControler.text+nameControler.text)

          Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords(widget.r,customer[0])));
    if(widget.r.chef_bool)
      if(chef.length!=null)
        if(chef[0].password==pwControler.text+nameControler.text)
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChefCRUD(chef[0])));
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
              new TextField(
                controller: nameControler,
                decoration: InputDecoration(
                    hintText: "name....", labelText: 'Name'),
              ),
              new TextField(
                controller: pwControler,
                decoration: InputDecoration(
                    hintText: "password....", labelText: 'Password'),
              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Log In'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords()));

                  if(widget.r.chef_bool)
                    checkPassword("ChefGet",pwControler.text+nameControler.text);
                  if(widget.r.Customer_bool)
                    checkPassword("CustomerGet",pwControler.text+nameControler.text);

//                  checkPassword2();
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Sign In'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Signin(widget.r)));
                },
              )
              /*  GestureDetector(
                  onTap: () {
//                    Navigator.pushNamed(context, "write your route");
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
                  },
                  child: new Text("Chef")
              ),*/

            ],
          ),
        )
    );
  }
}