
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'CustomerDetail.dart';
//import 'Chef.dart';
class CustomerList extends StatefulWidget {
  List<Order> list ;
  CustomerList(this.list);
  @override
  CustomerListState createState() => CustomerListState();
}

class CustomerListState extends State<CustomerList> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  int chef_no=0,indexOfChef=0;

  Resources r=new Resources();
  Order order;
  Customer cust;
  Package package;

  List<Customer> customerList ;
  List<Package> pack;


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
//    _getThingsOnStartup();

  }

  Future navigateToSubPage(context) async {



    //  _fetchData();
    _fetchData_2();
    while(customerList==null && pack==null)
      await Future.delayed(Duration(seconds: 1));
    print("customerList[0]==null = ");
    print(customerList[0]==null);
//    print("customerList[0] = "+customerList[0].toJson().toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerDetail(widget. list[indexOfChef],customerList[0],pack[0])));
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    API_NO_Str=API_NO.text;
    var url ='$HT$API_NO$ChefCRUD';


    var response =
    //await http.get("http://192.168.0.102:8000/food/chefs/");
//    await http.get(getUrlWithOutSerach("chefs"));
    await http.get(getUrlWithOutSerach("orderlist"));
//    await http.get(geturl("orderGet",widget.c));

    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
      widget. list = (json.decode(response.body) as List)
          .map((data) => new Order.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed to load photos');

    }


//      await Future.delayed(Duration(seconds: 1));




  }


  _fetchData_2() async {

    //  print(chef_no.toString());
    var response =
    await http.get(geturl("PackageGetById",widget. list[indexOfChef].packages.toString()));
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
    print("pack==null = ");
    print(pack==null);
    print(pack[0].id.toString());
    response =
    await http.get(geturl("CustomerGetByID",widget. list[indexOfChef].customer_ID.toString()));
    // await http.get("http://192.168.0.104:8000/food/PackageGet/?search=2");
    //await http.get(url);

    if (response.statusCode == 200) {
      customerList = (json.decode(response.body) as List)
          .map((data) => new Customer.fromJson(data))
          .toList();
      setState(() {


      });

    }
    else {
      throw Exception('Failed to load photos');

    }
    print("customerList==null = ");
    print(customerList==null);
    print(customerList[0].id.toString());
    print("the chef number"+ chef_no.toString());
    print("widget. list[indexOfChef].customer_ID = "+ widget. list[indexOfChef].customer_ID.toString());
//    order=widget.list[chef_no];

    order=widget.list[indexOfChef];

  }


  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.list.length,
      itemBuilder: (context, item) {

print(widget.list);
        //  return _buildRow(_randomWordPairs[index]);
        return _buildRow(widget.list[item].id.toString(),item);
      },
    );
  }

  Widget _buildRow(String pair,int chef_no) {

    return ListTile(
        title: Text(pair, style: TextStyle(fontSize: 18.0)),

        onTap: () {
          setState(() {
            this.chef_no=widget.list[ chef_no].id;
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
          appBar: AppBar(title: Text('')),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order List'),


        ),
        body: _buildList());
  }
}

