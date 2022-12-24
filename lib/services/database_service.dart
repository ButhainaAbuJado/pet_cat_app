import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_cats_app/model/cat_product_model.dart';

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

}


