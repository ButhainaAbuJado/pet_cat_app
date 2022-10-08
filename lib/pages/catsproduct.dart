// ignore_for_file: prefer_const_constructors

import 'package:pet_cats_app/pages/details_catp.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/ProductsData.dart';

class Catsproduct extends StatelessWidget {
  const Catsproduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 3),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 31),
              itemCount: ProductsData.catsProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(product: ProductsData.catsProducts[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    // ignore: sort_child_properties_last
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -1,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(ProductsData.catsProducts[index].imgPath)),
                      ),
                    ]),
                    footer: GridTileBar(
                      trailing: IconButton(
                          color: Colors.purple,
                          onPressed: () {
                            carttt.add(ProductsData.catsProducts[index]);
                          },
                          icon: Icon(Icons.add)),
                      title: Text(""),
                      leading: Text("      "),
                    ),
                  ),
                );
              }),
        ),
        appBar: AppBar(
          actions: [
            ProductsAndPrice(),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            )
          ],
          backgroundColor: Colors.purple,
          title: Text("Cats Product"),
        ));
  }
}
