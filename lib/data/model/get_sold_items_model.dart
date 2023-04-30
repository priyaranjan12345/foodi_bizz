import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetSoldItemsModel {
  final List<SoldItem> allSoldItems;
  GetSoldItemsModel({
    required this.allSoldItems,
  });

  GetSoldItemsModel copyWith({
    List<SoldItem>? allSoldItems,
  }) {
    return GetSoldItemsModel(
      allSoldItems: allSoldItems ?? this.allSoldItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allSoldItems': allSoldItems.map((x) => x.toMap()).toList(),
    };
  }

  factory GetSoldItemsModel.fromMap(Map<String, dynamic> map) {
    return GetSoldItemsModel(
      allSoldItems: List<SoldItem>.from(
          map['allSoldItems']?.map((x) => SoldItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetSoldItemsModel.fromJson(String source) =>
      GetSoldItemsModel.fromMap(json.decode(source));

  @override
  String toString() => 'GetSoldItemsModel(allSoldItems: $allSoldItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetSoldItemsModel &&
        listEquals(other.allSoldItems, allSoldItems);
  }

  @override
  int get hashCode => allSoldItems.hashCode;
}

class SoldItem {
  final String name;
  final String image;
  final int orderId;
  final int itemId;
  final int itemQty;
  final int price;
  final int totalAmount;
  SoldItem({
    required this.name,
    required this.image,
    required this.orderId,
    required this.itemId,
    required this.itemQty,
    required this.price,
    required this.totalAmount,
  });

  SoldItem copyWith({
    String? name,
    String? image,
    int? orderId,
    int? itemId,
    int? itemQty,
    int? price,
    int? totalAmount,
  }) {
    return SoldItem(
      name: name ?? this.name,
      image: image ?? this.image,
      orderId: orderId ?? this.orderId,
      itemId: itemId ?? this.itemId,
      itemQty: itemQty ?? this.itemQty,
      price: price ?? this.price,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'orderId': orderId,
      'itemId': itemId,
      'itemQty': itemQty,
      'price': price,
      'totalAmount': totalAmount,
    };
  }

  factory SoldItem.fromMap(Map<String, dynamic> map) {
    return SoldItem(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      orderId: map['orderId']?.toInt() ?? 0,
      itemId: map['itemId']?.toInt() ?? 0,
      itemQty: map['itemQty']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      totalAmount: map['totalAmount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoldItem.fromJson(String source) =>
      SoldItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SoldItem(name: $name, image: $image, orderId: $orderId, itemId: $itemId, itemQty: $itemQty, price: $price, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SoldItem &&
        other.name == name &&
        other.image == image &&
        other.orderId == orderId &&
        other.itemId == itemId &&
        other.itemQty == itemQty &&
        other.price == price &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        orderId.hashCode ^
        itemId.hashCode ^
        itemQty.hashCode ^
        price.hashCode ^
        totalAmount.hashCode;
  }
}
