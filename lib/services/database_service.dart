import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_cats_app/model/cart_item_model.dart';
import 'package:pet_cats_app/model/cat_product_model.dart';
import 'package:pet_cats_app/model/order_model.dart';
import 'package:pet_cats_app/model/user_model.dart';

import '../model/cat_model.dart';

class Database {
  static final Database _instance = Database._private();

  Database._private();

  factory Database() {
    return _instance;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _getCatsResponse() async {
    return await FirebaseFirestore.instance
        .collection('cats')
        .get()
        .then((value) => value.docs);
  }

  Future<List<Cat>> getCats() async {
    final catSnapshots = await _getCatsResponse();
    List<Cat> cats = [];
    for (var catSnapshot in catSnapshots) {
      cats.add(Cat.fromSnapshot(catSnapshot));
    }
    return cats;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _getCatProductsResponse() async {
    return await FirebaseFirestore.instance
        .collection('catProducts')
        .get()
        .then((value) => value.docs);
  }

  Future<List<CatProduct>> getCatProducts() async {
    final catProductSnapshots = await _getCatProductsResponse();
    List<CatProduct> catProducts = [];
    for (var catProductSnapshot in catProductSnapshots) {
      catProducts.add(CatProduct.fromSnapshot(catProductSnapshot));
    }
    return catProducts;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _getOrderItemsResponse() async {
    return await FirebaseFirestore.instance
        .collection('orders')
        .doc(UserModel.shared.userId)
        .collection('items')
        .get()
        .then((value) => value.docs);
  }

  Future<List<CartItem>> getOrderItems() async {
    final orderItemSnapshots = await _getOrderItemsResponse();
    List<CartItem> orderItems = [];
    for (var orderItemSnapshot in orderItemSnapshots) {
      orderItems.add(CartItem.fromSnapshot(orderItemSnapshot));
    }
    return orderItems;
  }

  Future<void> placeOrder({required OrderModel order}) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(UserModel.shared.userId)
        .set({
      'dateAndTime': order.dateAndTime,
      'username': order.username,
      'mobileNumber': order.mobileNumber,
      'location': order.location,
      'isDelivered': false,
    });
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(UserModel.shared.userId)
        .collection('items')
        .get()
        .then((value) => value.docs.forEach((element) async {
              await element.reference.delete();
            }));
    for (var item in order.items) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(UserModel.shared.userId)
          .collection('items').doc("${item.quantity} X ${item.name}")
          .set({
        'id': item.id,
        'imageUrl': item.imageUrl,
        'name': item.name,
        'quantity': item.quantity,
        'collection': item.collection
      });
    }
  }
}
