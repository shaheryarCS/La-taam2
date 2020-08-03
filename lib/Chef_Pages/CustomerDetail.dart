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
class CustomerDetail extends StatefulWidget {

  Order order;
  Customer cust;
  Package pack;
  CustomerDetail(this.order,this.cust,this.pack);
  Resources r;

  @override
  CustomerDetailState createState() => CustomerDetailState();
}

class CustomerDetailState extends State<CustomerDetail> {
  List<Package> pack;


  TextEditingController dayControler = new TextEditingController();
  TextEditingController packageTypeControler = new TextEditingController();
  TextEditingController nameControler = new TextEditingController();
  TextEditingController addressControler = new TextEditingController();
  TextEditingController typeControler = new TextEditingController();
  TextEditingController priceControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();

  int chef_no=0;


  var isLoading = false;


  @override
  void initState() {
    //

    super.initState();
    //  _getThingsOnStartup();

  }

//  Future navigateToSubPage(context) async {
//    _fetchData();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
//  }



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),


        ),
        body: Center(
          child:  Column(
            children: <Widget>[

              new Text(
              "Name : "+widget.cust.name),

              new Text(
                  "Address : "+  widget.cust.address ),

              new Text(
                  "Phone number : "+widget.cust.phoneNo.toString()),


              new Text(
                  "Package No : "+widget.pack.package_no.toString()),

              new Text(
                  "Date : "+widget.order.date),


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