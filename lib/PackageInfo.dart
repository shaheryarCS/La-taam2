import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/Type_of_package/Appitizer/Appitizer.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Order.dart';
import './1st_CandC.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';




class PackageInfo  extends StatefulWidget {
  List<Main_menu> Main_list = List();
  List<Appti> appti_list = List();
  List<Sweet> sweet_list = List();

  List<String> main,appti,sweet;
  Resources r=new Resources();

  Chef chef;
  Customer cust;
  PackageInfo(this.cust,this.chef,this.main,this.appti,this.sweet,this.r);


//  @override
  //FoodTypeSate createState() => FoodTypeSate();
  PackageInfoState createState() => PackageInfoState();


}



class PackageInfoState  extends State<PackageInfo>  {
//  String name;
//  PackageInfo(this.name);
  List<Package> pack;

  _fetchData() async {
    print("widget.r.chef.id.toString() =  "+ widget.r.chef.id.toString());
    var response =
   // await http.get(getUrlWithOutSerach("Packagelist"));
    await http.get(geturl("PackageGet",widget.r.chef.id.toString()));
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
    print("pack =  "+ pack.toString());
    print(pack[2].price.toString());
//    print("The chef Id : "+ widget.r.chef.id.toString());
    print("The chef Id : "+widget. chef.id.toString());
  }


  /*_fetchData_2() async {

    print(chef_no.toString());
    var response =
    await http.get(geturl("Day_MainMenuGet",Main_list..toString()));
//    await http.get("http://192.168.0.104:8000/food/PackageGet/?search=2");
    //await http.get(url);

    if (response.statusCode == 200) {
      Main_list_day = (json.decode(response.body) as List)
          .map((data) => new Day_MainMenu.fromJson(data))
          .toList();
      setState(() {


      });

    }
    else {
      throw Exception('Failed to load photos');

    }
    print(pack);
    response =
//    await http.get(geturl("Main_menuGet",chef_no.toString()));
    await http.get(geturl("Main_menuGet",chef_no.toString()));
    //await http.get(url);

    if (response.statusCode == 200) {
      print(Main_list);

      appti_list_day = (json.decode(response.body) as List)
          .map((data) => new Day_Apptiti.fromJson(data))
          .toList();
      setState(() {

      });
//      for (var prop in Main_list) {
//        main=main+ prop.name;
//      }
//

      mainListStr=List(Main_list.length);

      for (int i=0;i< Main_list.length;i++) {
        mainListStr[i]= Main_list[i].name;
      }

    }
    else {
      throw Exception('Failed to load photos');

    }
    print("fetch 2 below pack");
    print( mainListStr.toString());

    response =
    await http.get(geturl("ApptiGet",chef_no.toString()));
    //await http.get(url);

    if (response.statusCode == 200) {
      sweet_list_day = (json.decode(response.body) as List)
          .map((data) => new Day_Sweet.fromJson(data))
          .toList();
      setState(() {


      });

      apptiListStr=List(appti_list.length);

      for (int i=0;i< appti_list.length;i++) {
        apptiListStr[i]= appti_list[i].name;
      }

    }
    else {
      throw Exception('Failed to load photos');

    }


    response =
    await http.get(geturl("SweetGet",chef_no.toString()));
    //await http.get(url);

    if (response.statusCode == 200) {
      sweet_list = (json.decode(response.body) as List)
          .map((data) => new Sweet.fromJson(data))
          .toList();
      setState(() {


      });



      sweetListStr=List(sweet_list.length);

      for (int i=0;i< sweet_list.length;i++) {
        sweetListStr[i]= sweet_list[i].name;
      }
    }
    else {
      throw Exception('Failed to load photos');

    }
  }*/

  void  _getThingsOnStartup() async {
    _fetchData();
//  SearchService.searchDjangoApi("", list );
//  setState(() {
//
//
//  });
  }

  Future navigateToSubPage(context,Package p) async {
//    print(widget.r.customer.toJson());
//    _fetchData();
    print(" widget.r.Main_list = ");
    print(widget.r.Main_list);
    print(widget.r.sweet_list);
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreenPage(widget.cust, p,widget.r,widget.chef)));
  }


  @override
  void initState() {
    //
    super.initState();
    widget.r.chef=widget.chef;
   // set_number("0.100");
    _getThingsOnStartup();
//  if(list.length==0)
//    print("empty");
    print("packageInfo => init()");
print("the main list str :"+ widget. main.toString());

  }
  var readLines = ['Test1', 'Test2', 'Test3'];
  String getNewLineString() {
    StringBuffer sb = new StringBuffer();
    for (String line in readLines) {
      sb.write(line + "\n");
    }
    return sb.toString();
  }
  Widget MainHeading(String s)
  {
    return new Text(
        s,
        style: TextStyle(
            color: Colors.grey[800],
            backgroundColor: Colors.brown[300],
            letterSpacing: 1,
            decorationColor: Colors.amber[800],
            wordSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 40));
  }

  Widget MainHeading2(String s)
  {
    return new Text(
        s,
        style: TextStyle(
            color: Colors.grey[800],
            backgroundColor: Colors.green[300],
            fontWeight: FontWeight.bold,
            fontSize: 20));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Packages Info & chef ID :  '+widget.chef.id.toString()),
        backgroundColor: Colors.redAccent,
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

//          new Text("Menu"),
        MainHeading("       Packages        "),
////          new Text("Main Menu"),
//          MainHeading2("Main Menu"),
//          new Text(widget.main.toString()),
//          new Text("Apptizer"),
//          new Text(widget.appti.toString()),
//          new Text("Sweet"),
//          new Text(widget.sweet.toString()),

          RaisedButton(
            textColor: Colors.white,
            color: Colors.redAccent,
            child: Text('Package 1 ',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: () {
                setState(() {
                  print("In pack[0] "+ pack[0].id.toString());
                  navigateToSubPage(context,pack[0]);
                });
              }),
          RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Package 2',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: () {
                setState(() {
                  print("In pack[1] "+ pack[1].id.toString());
                  navigateToSubPage(context,pack[1]);
                });
              }),
          RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Package 3 ',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: () {
                setState(() {

                  navigateToSubPage(context,pack[2]);
                });
              })


        ]
      )
    );


  }

}


//class PackageInfo  extends StatelessWidget {
//  String name;
//  PackageInfo(this.name);
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        title: Text('Sub Page'),
//        backgroundColor: Colors.redAccent,
//      ),
//      body:
//         Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//
//           new Text("Menu"),
//            new Text("Menu"),
//
//
//
//          ],
//        ),
//
//    );
//  }
//
//}