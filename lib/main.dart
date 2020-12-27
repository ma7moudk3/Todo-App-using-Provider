import 'package:flutter/material.dart';
import 'package:todo_statemanagment/provider/my_provider.dart';
import 'package:todo_statemanagment/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) {
      return MyProvider();
    },
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}
