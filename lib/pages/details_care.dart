// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:pet_cats_app/model/care.dart';
import 'package:pet_cats_app/pages/ccare.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';

class Ddetail extends StatefulWidget {
  care product;
  Ddetail({required this.product});

  @override
  State<Ddetail> createState() => _DdetailState();
}

class _DdetailState extends State<Ddetail> {
  // const Details({Key? key}) : super(key: key);
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [ProductsAndPrice()],
          backgroundColor: Colors.purple,
          title: Text("Details screen"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(widget.product.cimgPath),
                SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 66,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 21),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Details : ",
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  (widget.product.description),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  maxLines: isShowMore ? 3 : null,
                  overflow: TextOverflow.fade,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isShowMore = !isShowMore;
                      });
                    },
                    child: Text(
                      isShowMore ? "Show more" : "Show less",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
