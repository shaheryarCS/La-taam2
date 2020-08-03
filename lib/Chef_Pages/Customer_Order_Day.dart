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


class Customer_Order_Day extends StatefulWidget {
  static Customer cust;
  Chef chef;
  Customer_Order_Day(this.chef);

  @override
  Customer_Order_DayState createState() => Customer_Order_DayState();
}

class Customer_Order_DayState extends State<Customer_Order_Day> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  List<Order> order;
  List<Order> order2;

  TextEditingController dayControler = new TextEditingController();
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

    print( widget.chef.id.toString());
    final response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
//    await http.get(getUrlWithOutSerach("orderlist"));

    await http.get(geturl("orderGet",widget.chef.id.toString()));

    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);

    if (response.statusCode == 200) {
      order = (json.decode(response.body) as List)
          .map((data) => new Order.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;

      });
    } else {
      throw Exception('Failed');

    }
    print("below order get");
    while(order==null )
      await Future.delayed(Duration(seconds: 1));
    print(order[1].toJson());

//    selectFromOrder();
  }

  void selectFromOrder()
  {
    int j=0;
    print(order.length);
    for(int i=0;i<order.length;i++)
      {
        if(order[i].date==dayControler.text)
          {
            j++;
          }

      }
    order2=List(j);
    j=0;
//    print(order[3].date);
//    print(dayControler.text);
//    print(order[3].date==dayControler.text);
    for(int i=0;i<order.length;i++)
    {
      if(order[i].date==dayControler.text)
      {
        print("selectFromOrder() ");
        order2[j]=order[i];
        j++;
      }

    }
//    print(order2[0].toJson());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select orders from list'),


        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                controller: dayControler,
                decoration: InputDecoration(
                    hintText: "Saturday or Sunday ,YYYY-MM-DD", labelText: 'Saturday or Sunday'),
              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Customer List'),
                onPressed: () {
                  // TODO
                  //  Navigator.pushNamed(context, "write your route");
                 // _fetchData();
                  print(dayControler.text);
                //  print(order.length);

                  selectFromOrder();
                  print(order2);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList(order2)));
                },
              ),

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