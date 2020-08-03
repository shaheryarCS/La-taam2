import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner build
//--delete-conflicting-outputs
part 'classes.g.dart';

@JsonSerializable()
class Chef{

  Chef(

      this.address,
      this.name,
      this.email,
      this.phoneNo,
      this.password,
      this.package_set
      );

  int id=0 ;
  final String address ;
  final String name ;
  final String email ;
  final int phoneNo ;
  final String password ;
  final List<Package> package_set ;





  factory Chef.fromJson(Map<String, dynamic> json) => _$ChefFromJson(json);

  Map<String, dynamic> toJson() => _$ChefToJson(this);
}



//-------------------------Customer-------------------

@JsonSerializable()
class Customer{

  Customer(
      this.address,
      this.name,
      this.email,
      this.phoneNo,
      this.password
      );

  int id=0 ;
  final String address ;
  final String name ;
  final String email ;
  final int phoneNo ;
  final String password ;




  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}





@JsonSerializable(explicitToJson: true)
class Package {
  int id=0;
  int price;
  int package_no;
  Chef chef;

//  List<Customer> customer;
//  Package._({this.price, this.chef,this.customer,this.package_no});
//  factory Package.fromJson(Map<String, dynamic> json) {
//    return new Package._(
//      price: json['price'],
//      chef: Post_Chef.fromJson(json), // json['chef'],
//      customer: parseCustomers(json), //json['customer'],
//      package_no: json['package_no'],
//    );
//  }


  Package(

      this.price,
      this.package_no,
      this.chef,
      );



  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);

}




@JsonSerializable()
class Main_menu{

  Main_menu(

      this.packages,
      this.name,
      this.chef,
      this.price,
      this.day
      );

  int id=0 ;
  int packages ;
  int chef ;
  final String name ;
  final int price ;
  int day;




  factory Main_menu.fromJson(Map<String, dynamic> json) => _$Main_menuFromJson(json);

  Map<String, dynamic> toJson() => _$Main_menuToJson(this);
}


@JsonSerializable()
class Sweet{

  Sweet(

      this.packages,
      this.name,
      this.chef,
      this.price,
      this.day
      );

  int id=0 ;
  int packages ;
  int chef ;
  final String name ;
  final int price ;
  int day;





  factory Sweet.fromJson(Map<String, dynamic> json) => _$SweetFromJson(json);

  Map<String, dynamic> toJson() => _$SweetToJson(this);
}



@JsonSerializable()
class Appti{

  Appti(

      this.packages,
      this.name,
      this.chef,
      this.price,
      this.day
      );

  int id=0 ;
  int packages ;
  int chef ;
  final String name ;
  final int price ;
  int day;





  factory Appti.fromJson(Map<String, dynamic> json) => _$ApptiFromJson(json);

  Map<String, dynamic> toJson() => _$ApptiToJson(this);
}



@JsonSerializable()
class Day_Apptiti{

  Day_Apptiti(

      this.appti,
      this.date_No,
      );

  int id=0 ;
  Appti appti ;
  final int date_No ;





  factory Day_Apptiti.fromJson(Map<String, dynamic> json) => _$Day_ApptitiFromJson(json);

  Map<String, dynamic> toJson() => _$Day_ApptitiToJson(this);
}


@JsonSerializable()
class Day_MainMenu{

  Day_MainMenu(

      this.main_menu,
      this.date_No,
      );

  int id=0 ;
  Main_menu main_menu ;
  final int date_No ;





  factory Day_MainMenu.fromJson(Map<String, dynamic> json) => _$Day_MainMenuFromJson(json);

  Map<String, dynamic> toJson() => _$Day_MainMenuToJson(this);
}




@JsonSerializable()
class Day_Sweet{

  Day_Sweet(

      this.sweet,
      this.date_No,
      );

  int id=0 ;
  Sweet sweet ;
  final int date_No ;





  factory Day_Sweet.fromJson(Map<String, dynamic> json) => _$Day_SweetFromJson(json);

  Map<String, dynamic> toJson() => _$Day_SweetToJson(this);
}



@JsonSerializable()
class Order{

  Order(
      this.packages,
      this.customer_ID,
      this.cost,
      this.chef,
      this.date,
      this.time
      );

  int id=0 ;
  int packages ;
  int customer_ID;
  int cost;
  int chef;
  var date;
  var time;





  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
