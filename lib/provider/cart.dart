import 'package:pet_cats_app/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List selectedProducts = [];
  int price = 0;

  add(Item cat) {
    selectedProducts.add(cat);
    price += cat.price.round();
    notifyListeners();
  }

  delete(Item cat) {
    selectedProducts.remove(cat);
    price -= cat.price.round();

    notifyListeners();
  }

  get itemCount {
    return selectedProducts.length;
  }

 



  get itemCountp {
    return selectedProducts.length;
  }
}
