// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:pet_cats_app/pages/forgot_password.dart';
import 'package:pet_cats_app/pages/home.dart';
import 'package:pet_cats_app/pages/welcome.dart';
import 'package:pet_cats_app/pages/login.dart';
import 'package:pet_cats_app/pages/signup.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          "/": (context) => Welcome(),
          "/login": (context) => const Login(),
          "/signup": (context) => const Signup(),
          "/Home": (context) => const Home(),
          "/forgotPassword": (context) => const ForgotPassword(),
        },
      ),
    );
  }
}


//todo add loading class and exit dialog to login screen
