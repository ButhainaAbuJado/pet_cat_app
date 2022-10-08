// ignore_for_file: prefer_const_constructors

import 'package:pet_cats_app/pages/home.dart';
import 'package:pet_cats_app/pages/welcome.dart';
import 'package:pet_cats_app/pages/login.dart';
import 'package:pet_cats_app/pages/signup.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const Welcome(),
          "/login": (context) => const Login(),
          "/signup": (context) => const Signup(),
          "/Home": (context) => const Home(),
        },
      ),
    );
  }
}
