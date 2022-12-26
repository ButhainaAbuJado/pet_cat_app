import 'cart_item_model.dart';

class OrderModel {
  List<CartItem> items;
  String mobileNumber;
  String dateAndTime;
  String location;
  String username;

  OrderModel({
    required this.items,
    required this.mobileNumber,
    required this.dateAndTime,
    required this.location,
    required this.username,
  });
}
