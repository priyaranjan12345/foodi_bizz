import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetAllOrdersModel {
  final List<Order> allOrders;
  GetAllOrdersModel({
    required this.allOrders,
  });

  GetAllOrdersModel copyWith({
    List<Order>? allOrders,
  }) {
    return GetAllOrdersModel(
      allOrders: allOrders ?? this.allOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allOrders': allOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAllOrdersModel.fromMap(Map<String, dynamic> map) {
    return GetAllOrdersModel(
      allOrders: List<Order>.from(
          map['allOrders']?.map((x) => Order.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllOrdersModel.fromJson(String source) =>
      GetAllOrdersModel.fromMap(json.decode(source));

  @override
  String toString() => 'GetAllOrdersModel(allOrders: $allOrders)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetAllOrdersModel && listEquals(other.allOrders, allOrders);
  }

  @override
  int get hashCode => allOrders.hashCode;
}

class Order {
  final String invNum;
  final int id;
  final int noOfItems;
  final int gst;
  final String billingDate;
  final int discount;
  final int grandTotal;
  Order({
    required this.invNum,
    required this.id,
    required this.noOfItems,
    required this.gst,
    required this.billingDate,
    required this.discount,
    required this.grandTotal,
  });

  Order copyWith({
    String? invNum,
    int? id,
    int? noOfItems,
    int? gst,
    String? billingDate,
    int? discount,
    int? grandTotal,
  }) {
    return Order(
      invNum: invNum ?? this.invNum,
      id: id ?? this.id,
      noOfItems: noOfItems ?? this.noOfItems,
      gst: gst ?? this.gst,
      billingDate: billingDate ?? this.billingDate,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invNum': invNum,
      'id': id,
      'noOfItems': noOfItems,
      'gst': gst,
      'billingDate': billingDate,
      'discount': discount,
      'grandTotal': grandTotal,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      invNum: map['invNum'] ?? '',
      id: map['id']?.toInt() ?? 0,
      noOfItems: map['noOfItems']?.toInt() ?? 0,
      gst: map['gst']?.toInt() ?? 0,
      billingDate: map['billingDate'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
      grandTotal: map['grandTotal']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(invNum: $invNum, id: $id, noOfItems: $noOfItems, gst: $gst, billingDate: $billingDate, discount: $discount, grandTotal: $grandTotal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.invNum == invNum &&
        other.id == id &&
        other.noOfItems == noOfItems &&
        other.gst == gst &&
        other.billingDate == billingDate &&
        other.discount == discount &&
        other.grandTotal == grandTotal;
  }

  @override
  int get hashCode {
    return invNum.hashCode ^
        id.hashCode ^
        noOfItems.hashCode ^
        gst.hashCode ^
        billingDate.hashCode ^
        discount.hashCode ^
        grandTotal.hashCode;
  }
}
