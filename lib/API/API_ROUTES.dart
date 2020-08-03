import 'package:wordpair_generator/models/classes.dart';

 Customer c;
const String chefbaseURL = "http://127.0.0.1:8000/simple/cheflist";
 String s= "http://192.168.0.102:8000/food/chefs/?search=1";
String num;

void  set_number(String n){
  num=n;
}

 String geturl(String type,String serach){
  s="http://192.168."+num+":8000/food/"+type+"/?search="+serach;
  return s;
}

String getUrlWithOutSerach(String type){
  s="http://192.168."+num+":8000/food/"+type+"/";
  return s;
}

String geturlWithUpdate(String type,String serach){
  s="http://192.168."+num+":8000/food/"+type+"/"+serach;
  return s;
}
