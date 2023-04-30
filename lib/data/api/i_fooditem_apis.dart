import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodi_bizz/data/model/add_sold_item_model.dart';

abstract class IFoodItemProvider {
  Future<Response> getAllFoodItem();

  Future<Response> addFoodItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  });

  Future<Response> updateFoodItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String lastModifiedDateTime,
    required File? image,
  });

  Future<Response> deleteFoodItem({required int foodItemId});

  Future<Response> addOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  });

  Future<Response> addSoldItems({required AddSoldItemModel addSoldItemModel});

  Future<Response> getAllOrders();

  Future<Response> getSoldItemsById({required int orderId});
}
