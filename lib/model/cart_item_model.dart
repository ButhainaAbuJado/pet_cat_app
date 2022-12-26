import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String imageUrl;
  final double price;
  final String location;
  final String name;
  final String? collection;
  int quantity = 1;

  double get totalPrice => price * quantity;

  CartItem(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      this.collection,
      this.location = "cats shop"});

  factory CartItem.empty() {
    return CartItem(id: "", imageUrl: "", name: "", price: 0);
  }

  factory CartItem.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    return CartItem(
      id: snapshot.get('id'),
      imageUrl: snapshot.get('imageUrl'),
      name: snapshot.get('name'),
      price: 0,
      collection: snapshot.get('collection'),
    );
  }

  bool isEmpty() => imageUrl.isEmpty && name.isEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      price.hashCode ^
      location.hashCode ^
      name.hashCode ^
      quantity.hashCode;
}
