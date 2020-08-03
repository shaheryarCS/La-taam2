import 'package:flutter/material.dart';
import './random_words.dart';
import './1st_CandC.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: ChefList(),
    );
  }
}
