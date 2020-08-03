
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';


//import 'Chef.dart';
class RandomWords extends StatefulWidget {
  Resources r;
  Customer c;
  RandomWords(this.r,this.c);
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  int chef_no=0,indexOfChef=0;

  void setResource(Resources r)
  {
    widget.r=r;
  }
  Resources r=new Resources();
  List<Main_menu> Main_list = List();
  List<Appti> appti_list = List();
  List<Sweet> sweet_list = List();
  List<Package> pack;
  String main="asas",appti="",sweet="";
  List<String>  mainListStr,apptiListStr,sweetListStr;
  final List<String> items = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten'
  ];
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
    print(widget.r.chef);
    print("this is randoms"+ Resources.customer.toString());

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
    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo(widget.c, list[indexOfChef],mainListStr,apptiListStr,sweetListStr,r)));
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
          .map((data) => new Chef.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed to load photos');

    }






  }


  _fetchData_2() async {

    //  print(chef_no.toString());
    var response =
    await http.get(geturl("PackageGet",chef_no.toString()));
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
    response =
//    await http.get(geturl("Main_menuGet",chef_no.toString()));
    await http.get(geturl("Main_menuGet",chef_no.toString()));
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
    await http.get(geturl("ApptiGet",chef_no.toString()));
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
//    r.chef=list[chef_no];
    r.chef=list[indexOfChef];
    print(Main_list.toString());
    r.packages(Main_list,appti_list,sweet_list);

    r.foodNames(mainListStr,apptiListStr,sweetListStr);
  }


  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: list.length,
      itemBuilder: (context, item) {


        //  return _buildRow(_randomWordPairs[index]);
        return _buildRow(list[item].name,item);
      },
    );
  }

  Widget _buildRow(String pair,int chef_no) {

    return ListTile(
        title: Text(pair, style: TextStyle(fontSize: 18.0)),

        onTap: () {
          setState(() {
            this.chef_no=list[ chef_no].id;
            indexOfChef=chef_no;
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
          title: Text('Chef name List'),


        ),
        body: _buildList());
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
