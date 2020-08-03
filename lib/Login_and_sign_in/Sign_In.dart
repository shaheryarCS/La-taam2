import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wordpair_generator/PackageInfo.dart';
import 'package:wordpair_generator/models/classes.dart';
import 'package:wordpair_generator/API/API_ROUTES.dart';
import 'package:wordpair_generator/Resources_of_App/objects_of_App.dart';
import 'package:wordpair_generator/random_words.dart';
import 'package:wordpair_generator/Chef_Pages/ChefCRUD.dart';
import 'SuccessfulSignIn.dart';

//import 'Chef.dart';
class Signin extends StatefulWidget {
  Resources r=new Resources();
  Signin(this.r);
  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  List<Chef> chef ;
  List<Customer> customer ;
  Chef c;
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
  TextEditingController nameControler = new TextEditingController();
  TextEditingController addressControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();
  TextEditingController phoneControler = new TextEditingController();
  TextEditingController pwControler = new TextEditingController();

  int chef_no=0;


  var isLoading = false;


  void  _getThingsOnStartup() async {
//    _fetchData();
  }


  _fetchData(String name,String password) async {
    setState(() {
      isLoading = true;
    });



    final response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
    await http.get(geturl(name,password));
    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);
    if(widget.r.chef_bool) {
      if (response.statusCode == 200) {
        chef = (json.decode(response.body) as List)
            .map((data) => new Chef.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed');
      }
    }
    else
    {
      if (response.statusCode == 200) {
        customer = (json.decode(response.body) as List)
            .map((data) => new Customer.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed ');
      }
    }
//    while(chef==null|| customer==null)
    await Future.delayed(Duration(seconds: 5));
  }



  _fetchData2() async {
    setState(() {
      isLoading = true;
    });

print("Sign in ");

    var response ;
//    await http.get("http://192.168.0.102:8000/food/chefs/");

    //await http.get("http://192.168.0.102:8000/food/chefDetail/1/");
    //await http.get(url);
    if(widget.r.chef_bool) {
      response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(getUrlWithOutSerach("chefs"));
      if (response.statusCode == 200) {
        chef = (json.decode(response.body) as List)
            .map((data) => new Chef.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed');
      }
      while(chef==null)
        await Future.delayed(Duration(seconds: 1));

    }
    print(widget.r.Customer_bool);
    if(widget.r.Customer_bool)
    {
      response =
//    await http.get("http://192.168.0.102:8000/food/chefs/");
      await http.get(getUrlWithOutSerach("Customerlist"));
      if (response.statusCode == 200) {

        customer = (json.decode(response.body) as List)
            .map((data) => new Customer.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed ');
      }
      while(customer==null)
        await Future.delayed(Duration(seconds: 1));

    }

  }

  Future makeID(Map data, String name) async
  {

    String p = json.encode(data);
    print("posting");
    http.Response response= await http.post(

      getUrlWithOutSerach(name),
      // 'http://127.0.0.1:8000/food/chef_Pack_CRUD/',
      headers: {"Content-Type": "application/json"},
      body: p,
    );


    if(widget.r.chef_bool) {
    //  c = Chef.fromJson(json.decode(response.body));
//      Map<String, dynamic> user = jsonDecode(response.body);
//      c=new (${user['address']},${user['name']},${user['email']},${user['phoneNo']},${user['password']},${null});
      print("In makeID"+ response.body);
      while (c == null)
        await Future.delayed(Duration(seconds: 1));
    }
    return response;
  }
  void checkPassword(String name,String password) async
  {
    _fetchData(name,password);
    if(widget.r.Customer_bool)
      print(customer.toString());
      if(customer.length==null)
       {
         Map data = {
           'address': addressControler.text,
           'name':nameControler.text,
           'email':  emailControler.text,
           'phoneNo': phoneControler.text,
           'password':  pwControler.text,

         };
         makeID(data,"customerCRUD");

       }
    if(widget.r.chef_bool)
      if(chef==null)
        {
          Chef newPost = new Chef(
              addressControler.text,
              nameControler.text,
              emailControler.text,
              int.parse( phoneControler.text),
              pwControler.text,
              null
          );

          Map data = {
            'address': addressControler.text,
            'name':nameControler.text,
            'email':  emailControler.text,
            'phoneNo': phoneControler.text,
            'password':  pwControler.text,
            'package_set':{},
          };
          data = {
            'address': addressControler.text,
            'name': nameControler.text,
            'email': emailControler.text,
            'phoneNo':  phoneControler.text,
            'password':  pwControler.text,
            'package_set':[
              {

                "price": 1500,
                "package_no": 1,
                "chef": {
                  'address': addressControler.text,
                  'name': nameControler.text,
                  'email': emailControler.text,
                  'phoneNo':  phoneControler.text,
                  'password':  pwControler.text,
                }
              },

            ],

          };



          String p = json.encode(data);
          print("posting");
          http.Response response= await http.post(

            getUrlWithOutSerach("chef_Pack_CRUD"),
            // 'http://127.0.0.1:8000/food/chef_Pack_CRUD/',
            headers: {"Content-Type": "application/json"},
            body: p,
          );
//          Navigator.push(
//
//              context, MaterialPageRoute(builder: (context) => RandomWords()));
//
//        }
    print(response.body.toString());
  }}


  void checkPassword2() async
  {
    _fetchData2();
    bool IsUser_Exist=false;
    if(widget.r.Customer_bool) {
        print(customer.toString());

        for (int i = 0; i < customer.length; i++) {
          if (customer[i].name == nameControler.text) {
            IsUser_Exist = true;
            print("name already exist");
            Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSignin("name already exist")));

          }
        }
        if (!IsUser_Exist) {
          Map data = {
            'address': addressControler.text,
            'name': nameControler.text,
            'email': emailControler.text,
            'phoneNo': phoneControler.text,
            'password': pwControler.text+nameControler.text,
            'package_set': {},
          };
          String p = json.encode(data);
          print("posting");
          makeID(data, "customerCRUD");

          Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSignin("You sign in successfully  ")));

//          Navigator.push(context, MaterialPageRoute(builder: (context) => RandomWords()));
        }
    }
    if(widget.r.chef_bool)
      {
        for (int i = 0; i < chef.length; i++) {
          if (chef[i].name == nameControler.text) {
            IsUser_Exist = true;
            print("name already exist");

          Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSignin("name already exist")));

          }
        }
        if (!IsUser_Exist) {

          Map data = {
            'address': addressControler.text,
            'name':nameControler.text,
            'email':  emailControler.text,
            'phoneNo': phoneControler.text,
            'password':  pwControler.text+nameControler.text,
            'package_set':{},
          };
          data = {
            'address': addressControler.text,
            'name': nameControler.text,
            'email': emailControler.text,
            'phoneNo':  phoneControler.text,
            'password':  pwControler.text+nameControler.text,
            'package_set':[
              {

                "price": 0,
                "package_no": 1,
                "chef": {
                  'address': addressControler.text,
                  'name': nameControler.text,
                  'email': emailControler.text,
                  'phoneNo':  phoneControler.text,
                  'password':  pwControler.text+nameControler.text,
                }
              },
              {

                "price": 0,
                "package_no": 2,
                "chef": {
                  'address': addressControler.text,
                  'name': nameControler.text,
                  'email': emailControler.text,
                  'phoneNo':  phoneControler.text,
                  'password':  pwControler.text+nameControler.text,
                }
              },
              {

                "price": 0,
                "package_no": 3,
                "chef": {
                  'address': addressControler.text,
                  'name': nameControler.text,
                  'email': emailControler.text,
                  'phoneNo':  phoneControler.text,
                  'password':  pwControler.text+nameControler.text,
                }
              },

            ],

          };
          String p = json.encode(data);
          print("posting");
          makeID(data, "chef_Pack_CRUD");

          Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSignin("You sign in successfully  ")));

//          print(c.id);
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ChefCRUD(c)));
        }
      }
//          Navigator.push(
//
//              context, MaterialPageRoute(builder: (context) => RandomWords()));
//
//        }

      }

  @override
  void initState() {
    //

    super.initState();
    _fetchData2();

//    _getThingsOnStartup();

  }

//  Future navigateToSubPage(context) async {
//    _fetchData();
//    Navigator.push(context, MaterialPageRoute(builder: (context) => PackageInfo("list[0].name")));
//  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),


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
                controller: addressControler,
                decoration: InputDecoration(
                    hintText: "address....", labelText: 'Address'),
              ),
              new TextField(
                controller: emailControler,
                decoration: InputDecoration(
                    hintText: "email....", labelText: 'Email'),
              ),
              new TextField(
                controller: phoneControler,
                decoration: InputDecoration(
                    hintText: "phone....", labelText: 'Phone Number'),
              ),
              new TextField(
                controller: pwControler,
                decoration: InputDecoration(
                    hintText: "password....", labelText: 'Password'),
              ),




              new RaisedButton(
                onPressed: () async {
//
                  checkPassword2();
               },
                child: const Text("Create Account"),
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
