class CartItem {
  final String imageUrl;
  final double price;
  final String location;
  final String name;
  int quantity = 1;

  double get totalPrice => price * quantity ;

  CartItem(
      {required this.imageUrl,
        required this.name,
        required this.price,
        this.location = "cats shop"});

  factory CartItem.empty(){
    return CartItem(imageUrl: "", name: "", price: 0);
  }

  bool isEmpty() => imageUrl.isEmpty && name.isEmpty ;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          name == other.name ;

  @override
  int get hashCode =>
      imageUrl.hashCode ^
      price.hashCode ^
      location.hashCode ^
      name.hashCode ^
      quantity.hashCode;
}

