import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _Contact();
}

class _Contact extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Contact"),
        ),
        body: SafeArea(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 35,
              ),
              Text(
                "Contact us",
                style: TextStyle(
                  fontSize: 33,
                  color: Colors.grey[900],
                  fontFamily: "myfont",
                ),
              ),
              SizedBox(
                height: 35,
              ),
              CircleAvatar(
                radius: 86.0,
                backgroundImage: AssetImage('assets/images/c2.jpg'),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Contact us to buy from our app',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 200.0,
                height: 27.0,
                child: Divider(
                  height: 100.0,
                ),
              ),
              Card(
                color: Colors.purple[100],
                margin: EdgeInsets.all(17.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.purple,
                  ),
                  title: Text(
                    '0798465225',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.purple[100],
                margin: EdgeInsets.all(17.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'catsShop@gmail.com',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
