//import 'dart:html';

import 'package:wordpair_generator/models/classes.dart';
import 'dart:convert';
 class  Resources {
  Chef chef;
  static Customer customer;
  Chef ChefSignIn ;
  bool chef_bool,Customer_bool;
  static String Custname,Custpassword;
  static int Custid;
  static void setCust(Customer c)
  {
    customer=c;
  }

  List<String> mainListStr, apptiListStr, sweetListStr;
  List<Main_menu> Main_list = List();
  List<Appti> appti_list = List();
  List<Sweet> sweet_list = List();

  List<Day_MainMenu> Main_list_day = List();
  List<Day_Apptiti> appti_list_day = List();
  List<Day_Sweet> sweet_list_day = List();

  void packages(List<Main_menu> Mlist, List<Appti> Alist, List<Sweet> Slist) {
  //  print("Resources => packages");
    this.Main_list = Mlist;
   // print(this.Main_list);
    appti_list = Alist;
   // print(this.appti_list);
    sweet_list = Slist;
  }

  void days(List<Day_MainMenu> Main_day, List<Day_Apptiti> appti_day,
      List<Day_Sweet> sweet_day) {
    Main_list_day = Main_day;
    appti_list_day = appti_day;
    sweet_list_day = sweet_day;
  }

  void foodNames(List<String> mainStr, List<String> apptiStr,
      List<String> sweetStr) {
    mainListStr = mainStr;
    apptiListStr = apptiStr;
    sweetListStr = sweetStr;
  }

  void makeCust(Customer c) {
    Map data = {
      "id": 2,
      "address": "SOME STRING",
      "name": "SOME STRING",
      "email": "SOME STRING",
      "phoneNo": 124,
      "password": "322"
    };
    customer = new Customer(
        "SOME STRING", "SOME STRING", "SOME STRING", 123, "SOME STRING");
    customer.id = 2;
    customer = Customer.fromJson(data);
  }
}