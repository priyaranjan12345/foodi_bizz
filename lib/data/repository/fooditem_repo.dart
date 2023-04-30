import 'dart:io';

import 'package:foodi_bizz/data/model/add_order_model.dart';
import 'package:foodi_bizz/data/model/add_sold_item_model.dart';
import 'package:foodi_bizz/data/model/get_sold_items_model.dart';
import 'package:foodi_bizz/data/model/get_all_orders_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../api/i_fooditem_apis.dart';
import '../model/fooditem_model.dart';
import 'i_fooditem_repo.dart';

class FoodItemRepository extends IFoodItemRepository {
  final IFoodItemProvider iFoodItemProvider;

  FoodItemRepository({
    required this.iFoodItemProvider,
  });

  @override
  Future<Result<Exception, FoodItemModel>> getAllFoodItems() async {
    var response = await iFoodItemProvider.getAllFoodItem();

    if (response.statusCode == 200) {
      FoodItemModel foodItemModel = FoodItemModel.fromJson(response.toString());

      return Success(foodItemModel);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, FoodItem>> addFoodItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  }) async {
    var response = await iFoodItemProvider.addFoodItem(
      name: name,
      desc: desc,
      price: price,
      dateTime: dateTime,
      image: image,
    );

    if (response.statusCode == 201) {
      FoodItem foodItem = FoodItem.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, FoodItem>> updateFoodItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String lastModifiedDateTime,
    required File? image,
  }) async {
    var response = await iFoodItemProvider.updateFoodItem(
      id: id,
      name: name,
      desc: desc,
      price: price,
      lastModifiedDateTime: lastModifiedDateTime,
      image: image,
    );

    if (response.statusCode == 202) {
      FoodItem foodItem = FoodItem.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, String>> deleteFoodItem(
      {required int foodItemId}) async {
    var response = await iFoodItemProvider.deleteFoodItem(
      foodItemId: foodItemId,
    );
    if (response.statusCode == 204) {
      return const Success('Success');
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, AddOrderModel>> addOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  }) async {
    var response = await iFoodItemProvider.addOrder(
      dateTime: dateTime,
      invNo: invNo,
      noOfItems: noOfItems,
      gst: gst,
      discount: discount,
      grandTotal: grandTotal,
    );

    if (response.statusCode == 201) {
      AddOrderModel foodItem = AddOrderModel.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, AddSoldItemModel>> addSoldItems({
    required AddSoldItemModel addSoldItemModel,
  }) async {
    var response = await iFoodItemProvider.addSoldItems(
      addSoldItemModel: addSoldItemModel,
    );

    if (response.statusCode == 201) {
      AddSoldItemModel foodItem =
          AddSoldItemModel.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, GetAllOrdersModel>> getAllOrders() async {
    var response = await iFoodItemProvider.getAllOrders();

    if (response.statusCode == 200) {
      GetAllOrdersModel foodItem =
          GetAllOrdersModel.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }

  @override
  Future<Result<Exception, GetSoldItemsModel>> getSoldItemsById({
    required int orderId,
  }) async {
    var response = await iFoodItemProvider.getSoldItemsById(orderId: orderId);

    if (response.statusCode == 200) {
      GetSoldItemsModel foodItem =
          GetSoldItemsModel.fromJson(response.toString());

      return Success(foodItem);
    } else {
      return Error(Exception(response.data));
    }
  }
}
