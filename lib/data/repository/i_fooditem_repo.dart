import 'dart:io';

import 'package:foodi_bizz/data/model/add_order_model.dart';
import 'package:foodi_bizz/data/model/get_all_orders_model.dart';
import 'package:foodi_bizz/data/model/get_sold_items_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/add_sold_item_model.dart';
import '../model/fooditem_model.dart';

abstract class IFoodItemRepository {
  Future<Result<Exception, FoodItemModel>> getAllFoodItems();

  Future<Result<Exception, FoodItem>> addFoodItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  });

  Future<Result<Exception, FoodItem>> updateFoodItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String lastModifiedDateTime,
    required File? image,
  });

  Future<Result<Exception, String>> deleteFoodItem({required int foodItemId});

  Future<Result<Exception, AddOrderModel>> addOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  });

  Future<Result<Exception, AddSoldItemModel>> addSoldItems({
    required AddSoldItemModel addSoldItemModel,
  });

    Future<Result<Exception, GetAllOrdersModel>> getAllOrders();

  Future<Result<Exception, GetSoldItemsModel>> getSoldItemsById({required int orderId});
}
