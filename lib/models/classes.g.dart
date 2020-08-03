// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chef _$ChefFromJson(Map<String, dynamic> json) {
  return Chef(
    json['address'] as String,
    json['name'] as String,
    json['email'] as String,
    json['phoneNo'] as int,
    json['password'] as String,
    (json['package_set'] as List)
        ?.map((e) =>
            e == null ? null : Package.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..id = json['id'] as int;
}

Map<String, dynamic> _$ChefToJson(Chef instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'name': instance.name,
      'email': instance.email,
      'phoneNo': instance.phoneNo,
      'password': instance.password,
      'package_set': instance.package_set,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['address'] as String,
    json['name'] as String,
    json['email'] as String,
    json['phoneNo'] as int,
    json['password'] as String,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'name': instance.name,
      'email': instance.email,
      'phoneNo': instance.phoneNo,
      'password': instance.password,
    };

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    json['price'] as int,
    json['package_no'] as int,
    json['chef'] == null
        ? null
        : Chef.fromJson(json['chef'] as Map<String, dynamic>),
  )..id = json['id'] as int;
}

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'package_no': instance.package_no,
      'chef': instance.chef?.toJson(),
    };

Main_menu _$Main_menuFromJson(Map<String, dynamic> json) {
  return Main_menu(
    json['packages'] as int,
    json['name'] as String,
    json['chef'] as int,
    json['price'] as int,
    json['day'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$Main_menuToJson(Main_menu instance) => <String, dynamic>{
      'id': instance.id,
      'packages': instance.packages,
      'chef': instance.chef,
      'name': instance.name,
      'price': instance.price,
      'day': instance.day,
    };

Sweet _$SweetFromJson(Map<String, dynamic> json) {
  return Sweet(
    json['packages'] as int,
    json['name'] as String,
    json['chef'] as int,
    json['price'] as int,
    json['day'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$SweetToJson(Sweet instance) => <String, dynamic>{
      'id': instance.id,
      'packages': instance.packages,
      'chef': instance.chef,
      'name': instance.name,
      'price': instance.price,
      'day': instance.day,
    };

Appti _$ApptiFromJson(Map<String, dynamic> json) {
  return Appti(
    json['packages'] as int,
    json['name'] as String,
    json['chef'] as int,
    json['price'] as int,
    json['day'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$ApptiToJson(Appti instance) => <String, dynamic>{
      'id': instance.id,
      'packages': instance.packages,
      'chef': instance.chef,
      'name': instance.name,
      'price': instance.price,
      'day': instance.day,
    };

Day_Apptiti _$Day_ApptitiFromJson(Map<String, dynamic> json) {
  return Day_Apptiti(
    json['appti'] == null
        ? null
        : Appti.fromJson(json['appti'] as Map<String, dynamic>),
    json['date_No'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$Day_ApptitiToJson(Day_Apptiti instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appti': instance.appti,
      'date_No': instance.date_No,
    };

Day_MainMenu _$Day_MainMenuFromJson(Map<String, dynamic> json) {
  return Day_MainMenu(
    json['main_menu'] == null
        ? null
        : Main_menu.fromJson(json['main_menu'] as Map<String, dynamic>),
    json['date_No'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$Day_MainMenuToJson(Day_MainMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main_menu': instance.main_menu,
      'date_No': instance.date_No,
    };

Day_Sweet _$Day_SweetFromJson(Map<String, dynamic> json) {
  return Day_Sweet(
    json['sweet'] == null
        ? null
        : Sweet.fromJson(json['sweet'] as Map<String, dynamic>),
    json['date_No'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$Day_SweetToJson(Day_Sweet instance) => <String, dynamic>{
      'id': instance.id,
      'sweet': instance.sweet,
      'date_No': instance.date_No,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['packages'] as int,
    json['customer_ID'] as int,
    json['cost'] as int,
    json['chef'] as int,
    json['date'],
    json['time'],
  )..id = json['id'] as int;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'packages': instance.packages,
      'customer_ID': instance.customer_ID,
      'cost': instance.cost,
      'chef': instance.chef,
      'date': instance.date,
      'time': instance.time,
    };
