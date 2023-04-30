import 'dart:convert';

class AddOrderModel {
  final String invNum;
  final int id;
  final int noOfItems;
  final int gst;
  final String billingDate;
  final int discount;
  final int grandTotal;
  AddOrderModel({
    required this.invNum,
    required this.id,
    required this.noOfItems,
    required this.gst,
    required this.billingDate,
    required this.discount,
    required this.grandTotal,
  });

  AddOrderModel copyWith({
    String? invNum,
    int? id,
    int? noOfItems,
    int? gst,
    String? billingDate,
    int? discount,
    int? grandTotal,
  }) {
    return AddOrderModel(
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

  factory AddOrderModel.fromMap(Map<String, dynamic> map) {
    return AddOrderModel(
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

  factory AddOrderModel.fromJson(String source) =>
      AddOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddOrderModel(invNum: $invNum, id: $id, noOfItems: $noOfItems, gst: $gst, billingDate: $billingDate, discount: $discount, grandTotal: $grandTotal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddOrderModel &&
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
