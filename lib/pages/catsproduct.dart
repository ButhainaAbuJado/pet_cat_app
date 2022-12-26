// ignore_for_file: prefer_const_constructors

import 'package:pet_cats_app/model/cart_item_model.dart';
import 'package:pet_cats_app/pages/details_catp.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:pet_cats_app/search/search_cat_product.dart';
import 'package:pet_cats_app/services/database_service.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cat_product_model.dart';

class CatsProduct extends StatefulWidget {
  const CatsProduct({Key? key}) : super(key: key);

  @override
  State<CatsProduct> createState() => _CatsProductState();
}

class _CatsProductState extends State<CatsProduct> {
  List<CatProduct>? products;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() async {
    products = await Database().getCatProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: products == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.purple[100]),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 3),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 31),
                    itemCount: products!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(product: products![index]),
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
                                  child:
                                      Image.network(products![index].imageUrl)),
                            ),
                          ]),
                          footer: GridTileBar(
                            trailing: IconButton(
                                color: Colors.purple,
                                onPressed: () {
                                  cart.add(CartItem(
                                    id: products![index].id,
                                    imageUrl: products![index].imageUrl,
                                    name: products![index].name,
                                    price: products![index].price,
                                    collection: 'catProducts',
                                    location: products![index].location!,
                                  ));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Item added Successfully!",
                                          style: TextStyle(
                                              color: Colors.purple[100]),
                                        ),
                                      ),
                                      backgroundColor: Colors.purple,
                                      duration: Duration(
                                        seconds: 2,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add_circle_outline)),
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
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: SearchCatProduct(catProducts: products!),
                    );
                  },
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
