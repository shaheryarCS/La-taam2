import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';
import 'package:wordpair_generator/Login_and_sign_in/SuccessfulSignIn.dart';
import 'ListOfFoods.dart';
//import 'Chef.dart';
class Enter_Item extends StatefulWidget {

  Chef chef;
  Enter_Item(this.chef);
  Resources r;

  @override
  Enter_ItemsState createState() => Enter_ItemsState();
}

class Enter_ItemsState extends State<Enter_Item> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  Main_menu main_Menu;
  Appti apptizer;
  Sweet sweet;
  List<Main_menu> Main_list = List();
  List<Appti> appti_list = List();
  List<Sweet> sweet_list = List();
  List<Package> pack2;
//  String main="asas",appti="",sweet="";
  List<String>  mainListStr,apptiListStr,sweetListStr;
  List<Package> pack;
  static String CREATE_POST_URL = 'http://192.168.0.102:8000/simple/chefCRUD/';
  String API_NO="";
  String HT="http://192.168.0.";
  String ChefCRUD=":8000/food/registerChef/";
  Resources r=new Resources();
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
print(widget.chef.id);
    _getThingsOnStartup();

  }

//  Future navigateToSubPage(context) async {
//    _fetchData();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
//  }
  _fetchData_2() async {

    //  print(chef_no.toString());
    var response =
    await http.get(geturl("PackageGet",widget.chef.id.toString()));
    // await http.get("http://192.168.0.104:8000/food/PackageGet/?search=2");
    //await http.get(url);

    if (response.statusCode == 200) {
      pack2 = (json.decode(response.body) as List)
          .map((data) => new Package.fromJson(data))
          .toList();
      setState(() {


      });

    }
    else {
      throw Exception('Failed to load photos');

    }
//    print("the chef number"+ chef_no.toString());
    response =
//    await http.get(geturl("Main_menuGet",chef_no.toString()));
    await http.get(geturl("Main_menuGet",widget.chef.id.toString()));
    //await http.get(url);

    if (response.statusCode == 200) {


      Main_list = (json.decode(response.body) as List)
          .map((data) => new Main_menu.fromJson(data))
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
    print( Main_list);

    response =
    await http.get(geturl("ApptiGet",widget.chef.id.toString()));
    //await http.get(url);

    if (response.statusCode == 200) {
      appti_list = (json.decode(response.body) as List)
          .map((data) => new Appti.fromJson(data))
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
    await http.get(geturl("SweetGet",widget.chef.id.toString()));
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
//    r.chef=list[chef_no];
    r.chef=widget.chef;
    print(Main_list.toString());
    r.packages(Main_list,appti_list,sweet_list);

    r.foodNames(mainListStr,apptiListStr,sweetListStr);

  }

  Future navigateToSubPage(context) async {



    //  _fetchData();
    _fetchData_2();
//    print(main+appti+sweet);
    //print(Main_list);

    r.packages(Main_list,appti_list,sweet_list);

    r.foodNames(mainListStr,apptiListStr,sweetListStr);
    //   print("above resources");
    //  print(chef_no);
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo(list[chef_no],main,appti,sweet)));
    while(mainListStr==null && apptiListStr==null && sweetListStr==null)
      await Future.delayed(Duration(seconds: 1));
//    Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfFoods(pack2[0],r,widget.chef)));
    Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSignin("Your order successfully entered  ")));
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    //  API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


    var response;
    response =
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

  }

  Package setPackageNo()
  {   Package p;
  for(int i=0;i<3;i++)
  {
    if(pack[i].package_no==int.parse( packageTypeControler.text))
      p=pack[i];
  }
  return p;
  }
  void setfood(String name) async
  {
    Map data={

      "name": "PK" + packageTypeControler.text+", " + nameControler.text,
      "price":int.parse(priceControler.text) ,
      "packages":setPackageNo().id,
      "chef": widget.chef.id,
      "day":int.parse(dayControler.text)
    };



    String p = json.encode(data);
    print("posting");
    http.Response response= await http.post(

      getUrlWithOutSerach(name),
      // 'http://127.0.0.1:8000/food/chef_Pack_CRUD/',
      headers: {"Content-Type": "application/json"},
      body: p,
    );
    print(response.body);
    navigateToSubPage(context);
  }

  void setFoodType(String type) async
  {
    var a;
    _getThingsOnStartup();
    if(type=='m')
      {
        main_Menu=new Main_menu(0, nameControler.text, widget.chef.id, int.parse( priceControler.text),int.parse( dayControler.text));
//         a=await typePost(getUrlWithOutSerach("mainMenuCRUD"),body: main_Menu.toJson());
//


//            {
//
//          "name": "daal",
//  "price": 0,
//  "packages": 2,
//  "chef": 2
//  }
        setfood("mainMenuCRUD");
//        print("mai");
      }
    else if(type=='a')
    {
      setfood("appitiCRUD");
    }
    else if(type=='s')
    {
      setfood("sweetCRUD");

    }

  } 

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter the Item'),


        ),
        body: Center(
          child:  Column(
            children: <Widget>[

              new TextField(
                controller: nameControler,
                decoration: InputDecoration(
                    hintText: "name....", labelText: 'Name'),
              ),

              new TextField(
                controller: priceControler,
                decoration: InputDecoration(
                    hintText: "price....", labelText: 'Price '),
              ),
              new TextField(
                controller: typeControler,
                decoration: InputDecoration(
                    hintText: "m or a or s....", labelText: 'm or a or s '),
              ),
              new TextField(
                controller: packageTypeControler,
                decoration: InputDecoration(
                    hintText: "1 or 2 or 3 ....", labelText: 'Packages'),
              ),
              new TextField(
                controller: dayControler,
                decoration: InputDecoration(
                    hintText: "1 or 2 or 3 or 4 or 5....", labelText: 'Days'),
              ),




              new RaisedButton(
                onPressed: () async {
                 // API_NO=titleControler.text;
                  var url ='$HT$API_NO$ChefCRUD';

                  setFoodType(typeControler.text);


              //    Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords()));
                },
                child: const Text("Enter Item"),
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