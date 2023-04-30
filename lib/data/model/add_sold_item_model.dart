import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddSoldItemModel {
  final List<SoldItemModel> soldItemModels;
  AddSoldItemModel({
    required this.soldItemModels,
  });

  AddSoldItemModel copyWith({
    List<SoldItemModel>? soldItemModels,
  }) {
    return AddSoldItemModel(
      soldItemModels: soldItemModels ?? this.soldItemModels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'soldItemModels': soldItemModels.map((x) => x.toMap()).toList(),
    };
  }

  factory AddSoldItemModel.fromMap(Map<String, dynamic> map) {
    return AddSoldItemModel(
      soldItemModels: List<SoldItemModel>.from(map['soldItemModels']?.map((x) => SoldItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddSoldItemModel.fromJson(String source) => AddSoldItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'AddSoldItemModel(soldItemModels: $soldItemModels)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddSoldItemModel &&
      listEquals(other.soldItemModels, soldItemModels);
  }

  @override
  int get hashCode => soldItemModels.hashCode;
}

class SoldItemModel {
  final int id;
  final int itemQty;
  final int orderId;
  final int itemId;
  final double itemUnitPrice;
  SoldItemModel({
    required this.id,
    required this.itemQty,
    required this.orderId,
    required this.itemId,
    required this.itemUnitPrice,
  });

  SoldItemModel copyWith({
    int? id,
    int? itemQty,
    int? orderId,
    int? itemId,
    double? itemUnitPrice,
  }) {
    return SoldItemModel(
      id: id ?? this.id,
      itemQty: itemQty ?? this.itemQty,
      orderId: orderId ?? this.orderId,
      itemId: itemId ?? this.itemId,
      itemUnitPrice: itemUnitPrice ?? this.itemUnitPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemQty': itemQty,
      'orderId': orderId,
      'itemId': itemId,
      'itemUnitPrice': itemUnitPrice,
    };
  }

  factory SoldItemModel.fromMap(Map<String, dynamic> map) {
    return SoldItemModel(
      id: map['id']?.toInt() ?? 0,
      itemQty: map['itemQty']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      itemId: map['itemId']?.toInt() ?? 0,
      itemUnitPrice: map['itemUnitPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoldItemModel.fromJson(String source) => SoldItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SoldItemModel(id: $id, itemQty: $itemQty, orderId: $orderId, itemId: $itemId, itemUnitPrice: $itemUnitPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SoldItemModel &&
      other.id == id &&
      other.itemQty == itemQty &&
      other.orderId == orderId &&
      other.itemId == itemId &&
      other.itemUnitPrice == itemUnitPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      itemQty.hashCode ^
      orderId.hashCode ^
      itemId.hashCode ^
      itemUnitPrice.hashCode;
  }
}