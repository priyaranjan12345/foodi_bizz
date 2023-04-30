import 'dart:convert';

import 'package:flutter/foundation.dart';

class FoodItemModel {
  final List<FoodItem> foodItems;
  FoodItemModel({
    required this.foodItems,
  });

  FoodItemModel copyWith({
    List<FoodItem>? foodItems,
  }) {
    return FoodItemModel(
      foodItems: foodItems ?? this.foodItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodItems': foodItems.map((x) => x.toMap()).toList(),
    };
  }

  factory FoodItemModel.fromMap(Map<String, dynamic> map) {
    return FoodItemModel(
      foodItems: List<FoodItem>.from(
          map['foodItems']?.map((x) => FoodItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodItemModel.fromJson(String source) =>
      FoodItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'FoodItemModel(foodItems: $foodItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodItemModel && listEquals(other.foodItems, foodItems);
  }

  @override
  int get hashCode => foodItems.hashCode;
}

class FoodItem {
  final int id;
  final String desc;
  final double price;
  final String creationDate;
  final String image;
  final String name;
  final String lastModifiedDate;
  FoodItem({
    required this.id,
    required this.desc,
    required this.price,
    required this.creationDate,
    required this.image,
    required this.name,
    required this.lastModifiedDate,
  });

  FoodItem copyWith({
    int? id,
    String? desc,
    double? price,
    String? creationDate,
    String? image,
    String? name,
    String? lastModifiedDate,
  }) {
    return FoodItem(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      creationDate: creationDate ?? this.creationDate,
      image: image ?? this.image,
      name: name ?? this.name,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'price': price,
      'creationDate': creationDate,
      'image': image,
      'name': name,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id']?.toInt() ?? 0,
      desc: map['desc'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      creationDate: map['creationDate'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      lastModifiedDate: map['lastModifiedDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodItem.fromJson(String source) =>
      FoodItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodItem(id: $id, desc: $desc, price: $price, creationDate: $creationDate, image: $image, name: $name, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodItem &&
        other.id == id &&
        other.desc == desc &&
        other.price == price &&
        other.creationDate == creationDate &&
        other.image == image &&
        other.name == name &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        creationDate.hashCode ^
        image.hashCode ^
        name.hashCode ^
        lastModifiedDate.hashCode;
  }
}
