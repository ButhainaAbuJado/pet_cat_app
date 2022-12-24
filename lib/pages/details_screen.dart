import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';

import '../model/cat_model.dart';

class Details extends StatefulWidget {
  final Cat product;

  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
          actions: const [ProductsAndPrice()],
          backgroundColor: Colors.purple,
          title: const Text("Details screen"),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.network(widget.product.imageUrl),
              const SizedBox(
                height: 11,
              ),
              Text(
                "  ${widget.product.price}  JOD",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "New",
                        style: TextStyle(fontSize: 15),
                      )),
                  const SizedBox(
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
                  const SizedBox(
                    width: 66,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_location,
                        size: 26,
                        color: Colors.purple,
                        // color: Color.fromARGB(255, 186, 30, 30),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.product.location!,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                (widget.product.description),
                style: const TextStyle(
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
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
        ));
  }
}
