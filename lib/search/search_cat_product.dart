import 'package:flutter/material.dart';
import 'package:pet_cats_app/model/cat_product_model.dart';
import 'package:provider/provider.dart';

import '../model/cart_item_model.dart';
import '../pages/details_catp.dart';
import '../provider/cart.dart';

class SearchCatProduct extends SearchDelegate<CatProduct> {
  SearchCatProduct({required this.catProducts});

  final List<CatProduct> catProducts;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, catProducts[0]);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final List<CatProduct> allCatProducts = catProducts
        .where((catProduct) => catProduct.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 31),
        itemCount: allCatProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetails(product: allCatProducts[index]),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                trailing: IconButton(
                    color: Colors.purple,
                    onPressed: () {
                      cart.add(CartItem(
                        id: allCatProducts[index].id,
                        imageUrl: allCatProducts[index].imageUrl,
                        name: allCatProducts[index].name,
                        price: allCatProducts[index].price,
                        collection: 'catProducts',
                        location: allCatProducts[index].location!,
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
                          duration: const Duration(
                            seconds: 2,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_circle_outline)),
                title: const Text(""),
                leading:
                Text("    ${allCatProducts[index].price}  JOD     "),
              ),
              child: Stack(children: [
                Positioned(
                  top: -3,
                  bottom: -1,
                  right: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: Image.network(allCatProducts[index].imageUrl),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final List<CatProduct> allCatProducts = catProducts
        .where((catProduct) => catProduct.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 31),
        itemCount: allCatProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetails(product: allCatProducts[index]),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                trailing: IconButton(
                    color: Colors.purple,
                    onPressed: () {
                      cart.add(CartItem(
                        id: allCatProducts[index].id,
                        imageUrl: allCatProducts[index].imageUrl,
                        name: allCatProducts[index].name,
                        price: allCatProducts[index].price,
                        collection: 'catProducts',
                        location: allCatProducts[index].location!,
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
                          duration: const Duration(
                            seconds: 2,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_circle_outline)),
                title: const Text(""),
                leading:
                Text("    ${allCatProducts[index].price}  JOD     "),
              ),
              child: Stack(children: [
                Positioned(
                  top: -3,
                  bottom: -1,
                  right: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: Image.network(allCatProducts[index].imageUrl),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.purple[100]),
      ),
      backgroundColor: Colors.purple[100],

      inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
    );
  }
}
