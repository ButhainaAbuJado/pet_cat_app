// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
class About extends StatefulWidget {
  @override
  State<About> createState() => _About();
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white ,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(" About"),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "About us",
                      style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/t2.jpg'),
                      ),
                    ),
                    Text(
                      "We are a team striving to preserve the kind creature who lives with us every day, in this application we have worked to enable you to get your cat and its accessories at the right price, specifications to suit your taste, and to give you instructions for dealing with this cute friend",
                      style: TextStyle(fontSize: 17,  color: Colors.grey[900]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
