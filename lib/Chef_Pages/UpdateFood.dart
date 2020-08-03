import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';

//import 'Chef.dart';
class UpdateFood extends StatefulWidget {

  Chef chef;
  UpdateFood(this.chef,this.food);
  Resources r;
  dynamic food;

  @override
  UpdateFoodState createState() => UpdateFoodState();
}

class UpdateFoodState extends State<UpdateFood> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  Main_menu main_Menu;
  Appti apptizer;
  Sweet sweet;
  int pack_no=0;
  List<Package> pack;
  static String CREATE_POST_URL = 'http://192.168.0.102:8000/simple/chefCRUD/';
  String API_NO="";
  String HT="http://192.168.0.";
  String ChefCRUD=":8000/food/registerChef/";

  TextEditingController dayControler = new TextEditingController();
  TextEditingController packageTypeControler = new TextEditingController();
  TextEditingController nameControler = new TextEditingController();
  TextEditingController addressControler = new TextEditingController();
  TextEditingController typeControler = new TextEditingController();
  TextEditingController priceControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();

  int chef_no=0;


  var isLoading = false;


  void  _getThingsOnStartup() async {
    _fetchData();
  }
  @override
  void initState() {
    //

    super.initState();
//    print(widget.chef.id);
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
    //  API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


    final response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(geturl("PackageGet",widget.chef.id.toString()));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
      pack = (json.decode(response.body) as List)
          .map((data) => new Package.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed');

    }
    print(pack[0].package_no.toString());
    while(pack==null )
      await Future.delayed(Duration(seconds: 1));
    pack_no=widget.food.packages;

    for(int i=0;i<3;i++)
    {
//            print(pack[i].toJson());
      if(pack[i].id==widget.food.packages) {
        pack_no=pack[i].package_no;
      }
    }
    print(pack_no.toString());
  }


  Package setPackageNo()
  {   Package p;
      for(int i=0;i<3;i++)
          {
//            print(pack[i].toJson());
            if(pack[i].package_no==int.parse( packageTypeControler.text)) {
              p = pack[i];
              print(p.toJson());
            }
          }
//  print(p.toJson());
      return p;
  }
  void setfood(String name) async
  {
    print(priceControler.text);
    Map data={

      "name": "PK" + packageTypeControler.text+", " +nameControler.text,
      "price": int.parse( priceControler.text),
      "day":int.parse(dayControler.text),
      "packages":setPackageNo().id,
      "chef": widget.chef.id,
    };
    print(data);
    print(widget.food.price.toString());


    String p = json.encode(data);
    print(widget.chef.toJson().toString());
    print(widget.food.toJson().toString());
    http.Response response= await http.put(

      geturlWithUpdate(name,widget.food.id.toString()),
      // 'http://127.0.0.1:8000/food/chef_Pack_CRUD/',
      headers: {"Content-Type": "application/json"},
      body: p,
    );
  }

  void setFoodType(String type) async
  {
    var a;
    if(type=='m')
    {
      main_Menu=new Main_menu(0, nameControler.text, widget.chef.id, int.parse( priceControler.text),int.parse( dayControler.text));

      setfood("mainMenuUpdate");
    }
    else if(type=='a')
    {
      setfood("appitiUpdate");
    }
    else if(type=='s')
    {
      setfood("sweetUpdate");

    }

  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update the Food'),


        ),
        body: Center(
          child:  Column(
            children: <Widget>[

              new TextField(
                controller: nameControler,
                decoration: InputDecoration(
                    hintText: "name....", labelText: widget.food.name.substring(5,widget.food.name.length)),
              ),

              new TextField(
                controller: priceControler,
                decoration: InputDecoration(
                    hintText: "price....", labelText: widget.food.price.toString()),
              ),
              new TextField(
                controller: dayControler,
                decoration: InputDecoration(
                    hintText: "1 or 2 or 3 or 4 or 5....", labelText: widget.food.day.toString()+" , Day"),
              ),
              new TextField(
                controller: typeControler,
                decoration: InputDecoration(
                    hintText: "m or a or s....", labelText: " Type"),
              ),
              new TextField(
                controller: packageTypeControler,
                decoration: InputDecoration(

                    hintText: "1 or 2 or 3....", labelText: "pack"),//pack[pack_no].package_no.toString()),
//                  hintText: "1 or 2 or 3....", labelText: pack[pack_no].package_no.toString()),
              ),




              new RaisedButton(
                onPressed: () async {
                  // API_NO=titleControler.text;
                  var url ='$HT$API_NO$ChefCRUD';
//                  Chef newPost = new Chef(
//                      addressControler.text,
//                      nameControler.text,
//                      emailControler.text,
//                        int.parse( priceControler.text),
//                      pwControler.text,
//                      null
//                  );
//                  Chef p = await createPost(url,
//                      body: newPost.toJson());
//                  //print(p.title);

//                  Map data = {
//                    'address': widget.r.chef.address,
//                    'name': widget.r.chef.name,
//                    'email':  widget.r.chef.email,
//                    'phoneNo': widget.r.chef.phoneNo.toString(),
//                    'password': widget.r.chef.password,
//                    'package_set':[
//                      {
//
//                        "price": 1500,
//                        "package_no": 1,
//                        "chef": {
//                          'address': widget.r.chef.address,
//                          'name': widget.r.chef.name,
//                          'email':  widget.r.chef.email,
//                          'phoneNo': widget.r.chef.phoneNo.toString(),
//                          'password': widget.r.chef.password,
//                        }
//                      },
//
//                      {
//
//                        "price": 1500,
//                        "package_no": 2,
//                        "chef": {
//                          'address': widget.r.chef.address,
//                          'name': widget.r.chef.name,
//                          'email':  widget.r.chef.email,
//                          'phoneNo': widget.r.chef.phoneNo.toString(),
//                          'password': widget.r.chef.password,
//                        }
//                      },
//
//                      {
//
//                        "price": 1500,
//                        "package_no": 3,
//                        "chef": {
//                          'address': widget.r.chef.address,
//                          'name': widget.r.chef.name,
//                          'email':  widget.r.chef.email,
//                          'phoneNo': widget.r.chef.phoneNo.toString(),
//                          'password': widget.r.chef.password,
//                        }
//                      }
//                    ],
//
//                  };

                  setFoodType(typeControler.text);


                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords()));
                },
                child: const Text("Update Item"),
              ),

            ],
          ),
        )
    );
  }
}

Future<Chef> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Chef.fromJson(json.decode(response.body));
  });
}


Future<dynamic> typePost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return null;//Main_menu.fromJson(json.decode(response.body));
  });
}