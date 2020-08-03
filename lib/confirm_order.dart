import 'package:flutter/material.dart';


class Conf_Order  extends StatefulWidget {
  String name;
  Conf_Order(this.name);


//  @override
  Conf_OrderState createState() => Conf_OrderState();


}





class Conf_OrderState  extends State<Conf_Order>  {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sub Page'),
          backgroundColor: Colors.redAccent,
        ),
        body:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Text("Menu"),
              new Text("Main Menu"),
//              new Text(main),
//              new Text("Apptizer"),
//              new Text(appti),
//              new Text("Sweet"),
//              new Text(sweet),
//
//              RaisedButton(
//                  textColor: Colors.white,
//                  color: Colors.redAccent,
//                  child: Text('Back to Main Page'),
//                  onPressed: () {
//                    setState(() {
//
//                      navigateToSubPage(context);
//                    });
//                  }),
//              RaisedButton(
//                  textColor: Colors.white,
//                  color: Colors.redAccent,
//                  child: Text('Back to Main Page'),
//                  onPressed: () {
//                    setState(() {
//
//                      navigateToSubPage(context);
//                    });
//                  }),
//              RaisedButton(
//                  textColor: Colors.white,
//                  color: Colors.redAccent,
//                  child: Text('Back to Main Page'),
//                  onPressed: () {
//                    setState(() {
//
//                      navigateToSubPage(context);
//                    });
//                  })


            ]
        )
    );


  }

}
