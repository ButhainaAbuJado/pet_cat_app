import 'package:pet_cats_app/model/cart_item_model.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<CartItem> selectedProducts = [];

  int get price => totalPrice().round();

  double totalPrice() {
    if (selectedProducts.isEmpty) return 0;

    double totalPrice = 0;
    for (var product in selectedProducts) {
      totalPrice += product.totalPrice;
    }
    return totalPrice;
  }

  add(CartItem item) {
    final existProduct = selectedProducts.firstWhere(
        (product) => product == item,
        orElse: () => CartItem.empty());
    if (existProduct.isEmpty()) {
      selectedProducts.add(item);
      notifyListeners();
      return;
    }
    increment(existProduct);
  }

  increment(CartItem item) {
    int maximumQuantity = 15;
    if(item.quantity < maximumQuantity) {
      item.quantity++;
      notifyListeners();
    }
  }

  decrement(CartItem item) {
    if (item.quantity == 1) {
      delete(item);
      return;
    }
    item.quantity--;
    notifyListeners();
  }

  delete(CartItem item) {
    selectedProducts.remove(item);

    notifyListeners();
  }

  get itemCount {
    return selectedProducts.length;
  }
}
