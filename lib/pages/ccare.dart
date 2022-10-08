// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:pet_cats_app/model/care.dart';

import 'package:pet_cats_app/pages/details_care.dart';

import 'package:flutter/material.dart';

class Ccare extends StatelessWidget {
  const Ccare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 3),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 4),
              itemCount: cares.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ddetail(product: cares[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -1,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            child: Image.asset(cares[index].cimgPath)),
                      ),
                    ]),
                    footer: GridTileBar(
                      trailing: Text(cares[index].title),
                      title: Text(""),
                      leading: Text(""),
                    ),
                  ),
                );
              }),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("care"),
        ));
  }
}
