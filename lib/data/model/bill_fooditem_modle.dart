class BillFoodItemModel {
  final int id;
  final String desc;
  final double price;
  final String image;
  final String name;
  final int quantity;

  BillFoodItemModel({
    required this.id,
    required this.desc,
    required this.price,
    required this.image,
    required this.name,
    required this.quantity,
  });

  BillFoodItemModel copyWith({
    int? id,
    String? desc,
    double? price,
    String? image,
    String? name,
    int? quantity,
  }) {
    return BillFoodItemModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      image: image ?? this.image,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
