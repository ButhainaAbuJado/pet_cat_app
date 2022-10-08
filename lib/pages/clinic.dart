import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
class Clinic extends StatefulWidget {
  @override
  State<Clinic> createState() => _Clinic();
}

class _Clinic extends State<Clinic> {
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("veterinary clinic"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Alnwaeer pet care ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey[900],
                    fontFamily: "myfont",
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                CircleAvatar(
                  radius: 86.0,
                  backgroundImage: AssetImage('assets/images/cli.jpg'),
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Free online veterinary clinic',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  'Alnwaeer : blog site specialized in animal health and diseases .The blog created by : Dr. Muhammad Saeed Al-Khaled / veterinarian . ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'For more information, contact them at :                          ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 11,
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
                      Icons.facebook,
                      color: Colors.purple,
                    ),
                    title: Text(
                      'Alnwaeer',
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
                      Icons.telegram,
                      color: Colors.purple,
                    ),
                    title: Text(
                      'Alnwaeer pet care',
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
                      Icons.attachment,
                      color: Colors.purple,
                    ),
                    title: Text(
                      'https://www.alnwaeer.com',
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
      ),
    ));
  }
}
