import 'package:cloud_firestore/cloud_firestore.dart';

class CatProduct {
  String imageUrl;

  double price;
  String? location;
  String description;
  String name;

  CatProduct(
      {required this.imageUrl,
        required this.name,
        required this.price,
        required this.description,
        this.location});

  factory CatProduct.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    return CatProduct(
      imageUrl: snapshot.get('imageUrl'),
      name: snapshot.get('name'),
      price: double.parse(snapshot.get('price')),
      description: snapshot.get('description'),
      location: snapshot.get('location'),
    );
  }

  @override
  String toString() {
    return 'CatProduct{imageUrl: $imageUrl, price: $price, location: $location, description: $description, name: $name}';
  }
}