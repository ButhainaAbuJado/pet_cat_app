import 'package:cloud_firestore/cloud_firestore.dart';

class Cat {
  String id;
  String imageUrl;
  double price;
  String? location;
  String description;
  String name;

  Future<double> getRating() async {
    int oneStar = 0,
        twoStars = 0,
        threeStars = 0,
        fourStars = 0,
        fiveStars = 0;
    double counter = 0 ;
    final ratingSnapshots = await FirebaseFirestore.instance
        .collection('cats')
        .doc(id)
        .collection('rating')
        .get()
        .then((value) => value.docs);
    for (var snapshot in ratingSnapshots) {
      int rating = snapshot.get('rating');
      switch (rating) {
        case 1:oneStar++;break;
        case 2:twoStars++;break;
        case 3:threeStars++;break;
        case 4:fourStars++;break;
        case 5:fiveStars++;break;
        default:break;
      }
      counter++;
    }
    int scoreTotal = (5 * fiveStars) + (4 * fourStars) + (3 * threeStars) + (2 * twoStars) + (oneStar);
    return (scoreTotal / counter);
  }

  Cat({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    this.location,
  });

  factory Cat.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    return Cat(
      id: snapshot.get('id'),
      imageUrl: snapshot.get('imageUrl'),
      name: snapshot.get('name'),
      price: double.parse(snapshot.get('price')),
      description: snapshot.get('description'),
      location: snapshot.get('location'),
    );
  }

  @override
  String toString() {
    return 'Cat{id: $id, imageUrl: $imageUrl, price: $price, location: $location, description: $description, name: $name}';
  }
}
