class Item {
  String imgPath;
 
  double price;
  String location;
  String description;
  String name;

  Item(
      {required this.imgPath,      
      required this.name,
      required this.price,
      required this.description,
      this.location = "cats shop"});
}

