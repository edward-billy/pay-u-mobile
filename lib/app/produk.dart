class Item {
  final String name;
  final String cat;
  final int price;
  final String image;

  Item(
      {required this.name,
      required this.cat,
      required this.price,
      required this.image});

  Map toJson() {
    return {
      'nama': name,
      'kategoriId': cat,
      'harga': price,
      'image': image,
    };
  }
}
