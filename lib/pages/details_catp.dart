// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_cats_app/model/cat_product_model.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final CatProduct product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isShowMore = true;
  double rating = 0;

  @override
  void initState() {
    getRating();
    super.initState();
  }

  void getRating() async {
    rating = await widget.product.getRating();
    setState(() {});
  }
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
          child: Column(
            children: [
              Image.network(widget.product.imageUrl),
              SizedBox(
                height: 11,
              ),
              Text(
                "  ${widget.product.price} JOD",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "New",
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    ignoreGestures: true,
                    itemSize: 25,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    width: 66,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit_location,
                        size: 26,
                        color: Colors.purple,
                        // color: Color.fromARGB(255, 186, 30, 30),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.product.location!,
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  )
                ],
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
        ));
  }
}
