import 'package:flutter/material.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/ReceivedOrder.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
//class OrderScreen extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: OrderScreenPage(),
//    );
//  }
//}

class OrderScreenPage extends StatefulWidget {
//  OrderScreenPage({Key key, this.title}) : super(key: key);
  Package pack;
  Customer cust;
  Resources r;
  Chef chef;
  int total_price=0;
//  OrderScreenPage(this.cust,this.pack);
    OrderScreenPage(this.cust, this.pack,this.r,this.chef);
  //OrderScreenPage();

 // final String title;
   List<String> main_menuList=List(5),apptiList=List(5),sweetList=List(5);
   List<int> main_menuList_price=List(5),apptiList_price=List(5),sweetList_price=List(5);
  @override
  OrderScreenPageState createState() => OrderScreenPageState();
}

class OrderScreenPageState extends State<OrderScreenPage> {
  int _counter = 0;

  void  _getThingsOnStartup() async {
    _fetchData();
  print(widget.main_menuList[0]);
  }



  @override
  void initState() {
    //
    super.initState();

//    print("<widget.r.Main_list"+widget.r.Main_list.toString());
      for (int j=0;j< 5;j++) {
//print(widget.r. Main_list);
//28 july
        for(int i=0;i<widget.r.Main_list.length;i++)
        {
          print("widget.pack.id  :  "+widget.pack.id.toString());

          print("widget.r.Main_list[i].packages.toString()  :  "+widget.r.Main_list[i].packages.toString());

          if (widget.pack.id== widget.r.Main_list[i].packages)
            {
              print("widget.r.Main_list[i].name  :  "+widget.r.Main_list[i].name);
              if(widget.r.Main_list[i].day==j+1)
                {
                  widget.main_menuList[j]=widget.r.Main_list[i].name;
                  widget.main_menuList[j]=widget.main_menuList[j].substring(5,widget.main_menuList[j].length);
                  widget.main_menuList_price[j]=widget.r.Main_list[i].price;
                  widget.total_price=widget.r.Main_list[i].price+widget.total_price;
                }
            }

        }

        if(widget.main_menuList[j]==null) {
          widget.main_menuList[j] = "-----";
          widget.main_menuList_price[j]=0;
        }
      }
    print("widget.r.Main_list.toString()  :  "+widget.r.Main_list.toString());
    print("widget.main_menuList.toString()"+widget.main_menuList.toString());
//print(widget.r.appti_list[0].packages);
    for (int j=0;j< 5;j++) {

      for(int i=0;i<widget.r.appti_list.length;i++)
      {
        if(widget.pack.id ==widget.r.appti_list[i].packages)
        {print("*");
          if(widget.r.appti_list[i].day==j+1)
          {
              widget.apptiList[j]=widget.r.appti_list[i].name;
              widget.apptiList[j]=widget.apptiList[j].substring(5,widget.apptiList[j].length);
              widget.apptiList_price[j]=widget.r.appti_list[i].price;
              widget.total_price=widget.r.appti_list[i].price+widget.total_price;
          }
        }

      }
      if(widget.apptiList[j]==null) {
        widget.apptiList[j] = "-----";
        widget.apptiList_price[j]=0;
      }
    }
    print(widget.sweetList);

    for (int j=0;j< 5;j++) {

      for(int i=0;i<widget.r.sweet_list.length;i++)
      {
        if(widget.pack.id ==widget.r.sweet_list[i].packages)
        {
          if(widget.r.sweet_list[i].day==j+1)
          {
            widget.sweetList[j]=widget.r.sweet_list[i].name;
            widget.sweetList[j]=widget.sweetList[j].substring(5,widget.sweetList[j].length);
            widget.sweetList_price[j]=widget.r.sweet_list[i].price;
            widget.total_price=widget.r.sweet_list[i].price+widget.total_price;
          }
        }

      }

      if(widget.sweetList[j]==null) {
        widget.sweetList[j] = "-----";
        widget.sweetList_price[j]=0;
      }


    }

    //widget.pack.
   // set_number("0.100");
//    _getThingsOnStartup();
//  if(list.length==0)
//    print("empty");
//print(list[0].title);

  }
  _fetchData() async {

    Map data = {
      "Cost": widget.pack.price,
      "customer_ID": widget.cust.id,
      "packages": widget.pack.id,
      "chef": widget.chef.id,
    };
//
//    data = {
//
//    "Cost": 95,
//    "customer_ID": 1,
//    "packages": 2,
//      "chef": 2,
//    };

//    data = {
//
//    "Cost": 95,
//
//    "customer_ID": 1,
//    "packages": 2
//    };

    String body = json.encode(data);

    http.Response response= await http.post(
      getUrlWithOutSerach("orderCRUD"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

  }
    Future navigateToSubPage() async {
     _fetchData();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceivedPage()));
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Package : "+ widget.pack.package_no.toString()),
      ),
      body:/* Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Day 1 : '+widget.nameList[0],
            ),
            Text(
              'Day 2 : '+widget.nameList[1],
            ),
            Text(
              'Day 3 : '+widget.nameList[2],
            ),
            Text(
              'Day 4 : '+widget.nameList[3],
            ),
            Text(
              'Day 5 : '+widget.nameList[4],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text('Back to Main Page'),
                onPressed: () {
                  setState(() {

                    navigateToSubPage(context);
                  });
                }),
          ],
        ),
      ),*/

      ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[900],
            child:  Center(child: Text('Total Price : '+widget.total_price.toString())),
//            child:  Center(child: Text('Day 1 : '),
          ),
          Container(
            height: 50,
            color: Colors.green[300],
            child:  Center(child: Text('Main Menu  ')),
//            child:  Center(child: Text('Day 1 : '),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 1 : '+widget.main_menuList[0]+", Rs. "+widget.main_menuList_price[0].toString())),
//            child:  Center(child: Text('Day 1 : '),
            ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 2 : '+widget.main_menuList[1]+", Rs. "+widget.main_menuList_price[1].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 3 : '+widget.main_menuList[2]+", Rs. "+widget.main_menuList_price[2].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 4 : '+widget.main_menuList[3]+", Rs. "+widget.main_menuList_price[3].toString())),
          ),

          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 5 : '+widget.main_menuList[4]+", Rs. "+widget.main_menuList_price[4].toString())),
          ),
          Container(
            height: 50,
            color: Colors.green[300],
            child:  Center(child: Text('Apptitizer  ')),
//            child:  Center(child: Text('Day 1 : '),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 1 : '+widget.apptiList[0]+", Rs. "+widget.apptiList_price[0].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 2 : '+widget.apptiList[1]+", Rs. "+widget.apptiList_price[1].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 3 : '+widget.apptiList[2]+", Rs. "+widget.apptiList_price[2].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 4 : '+widget.apptiList[3]+", Rs. "+widget.apptiList_price[3].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 5 : '+widget.apptiList[4]+", Rs. "+widget.apptiList_price[4].toString())),
          ),
          Container(
            height: 50,
            color: Colors.green[300],
            child:  Center(child: Text('Sweets  ')),
//            child:  Center(child: Text('Day 1 : '),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 1 : '+widget.sweetList[0]+", Rs. "+widget.sweetList_price[0].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 2 : '+widget.sweetList[1]+", Rs. "+widget.sweetList_price[1].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 3 : '+widget.sweetList[2]+", Rs. "+widget.sweetList_price[2].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 4 : '+widget.sweetList[3]+", Rs. "+widget.sweetList_price[3].toString())),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child:  Center(child: Text('Day 5 : '+widget.sweetList[4]+", Rs. "+widget.sweetList_price[4].toString())
            ),
          ),
//          RaisedButton(
//              textColor: Colors.white,
//              color: Colors.redAccent,
//              child: Text('Package 3'),
//              onPressed: () {
//                setState(() {
//
//                  navigateToSubPage();
//                });
//              })


        ],
 // This trailing comma makes auto-formatting nicer for build methods.


    ),
        floatingActionButton: FloatingActionButton(
//        onPressed: navigateToSubPage(),
          onPressed: () {navigateToSubPage();},
          child: Text("Order now"),//Icon(Icons.add),

    ),
    );
  }
}

