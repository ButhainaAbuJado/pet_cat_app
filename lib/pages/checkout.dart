// ignore_for_file: prefer_const_constructors

import 'package:pet_cats_app/provider/cart.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:pet_cats_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("checkout screen"),
        actions: const [ProductsAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: carttt.selectedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(carttt.selectedProducts[index].name),
                        subtitle: Text(
                            "${carttt.selectedProducts[index].price} - ${carttt.selectedProducts[index].location}"),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              carttt.selectedProducts[index].imageUrl),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if(carttt.selectedProducts[index].quantity == 1){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Item deleted Successfully!",
                                            style: TextStyle(
                                                color: Colors.purple),
                                          ),
                                        ),
                                        backgroundColor: Colors.purple[100],
                                        duration: Duration(
                                          seconds: 2,
                                        ),
                                      ),
                                    );
                                  }
                                  carttt.decrement(carttt.selectedProducts[index]);
                                },
                                icon: Icon(Icons.remove_circle_outline)),
                            Text(carttt.selectedProducts[index].quantity.toString()),
                            IconButton(
                                onPressed: () {
                                  carttt.increment(carttt.selectedProducts[index]);
                                },
                                icon: Icon(Icons.add_circle_outline)),
                          ],
                        ),
                      ),

                    );
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonPink),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "Pay ${carttt.price} JOD",
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ),
    );
  }
}
