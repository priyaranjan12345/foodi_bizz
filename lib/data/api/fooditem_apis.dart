import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:foodi_bizz/data/api/i_fooditem_apis.dart';
import 'package:foodi_bizz/data/model/add_sold_item_model.dart';

import 'fooditem_interceptor.dart';

class FoodItemProvider extends IFoodItemProvider {
  late Dio dio;

  @override
  FoodItemProvider() {
    dio = Dio();
    dio.options.baseUrl = 'http://127.0.0.1:8000/';
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    dio.interceptors.addAll(
      [
        RetryInterceptor(
          dio: dio,
          retries: 4,
          retryDelays: [
            const Duration(seconds: 1),
            const Duration(seconds: 2),
            const Duration(seconds: 3),
          ],
          retryEvaluator: (error, i) {
            if (error.type == DioErrorType.other &&
                error.error is SocketException) {
              return true;
            } else {
              return false;
            }
          },
        ),
        FoodItemInterceptor(dio: dio),
      ],
    );
  }

  @override
  Future<Response> getAllFoodItem() async {
    return await dio.get('item/all-fooditems');
  }

  @override
  Future<Response> addFoodItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  }) async {
    var formData = FormData.fromMap({
      'name': name,
      'desc': desc,
      'price': price,
      'creationDate': dateTime,
      if (image != null) 'foodImage': await MultipartFile.fromFile(image.path)
    });

    return await dio.post(
      'item/add-fooditem',
      data: formData,
    );
  }

  @override
  Future<Response> updateFoodItem({
    required int id,
    required String name,
    required String desc,
    required double price,
    required String lastModifiedDateTime,
    required File? image,
  }) async {
    var formData = FormData.fromMap({
      'name': name,
      'desc': desc,
      'price': price,
      'lastModifiedDate': lastModifiedDateTime,
      if (image != null) 'foodImage': await MultipartFile.fromFile(image.path)
    });

    return await dio.put(
      'item/update-fooditem/$id',
      data: formData,
    );
  }

  @override
  Future<Response> deleteFoodItem({required int foodItemId}) async {
    return await dio.delete('delete-fooditem/$foodItemId');
  }

  @override
  Future<Response> addOrder({
    required String dateTime,
    required String invNo,
    required int noOfItems,
    required double gst,
    required double discount,
    required double grandTotal,
  }) async {
    var payload = {
      "id": 0,
      "billingDate": dateTime,
      "invNum": invNo,
      "noOfItems": noOfItems,
      "discount": discount,
      "gst": gst,
      "grandTotal": grandTotal,
    };

    return await dio.post(
      'Order/add-order',
      data: payload,
    );
  }

  @override
  Future<Response> addSoldItems({
    required AddSoldItemModel addSoldItemModel,
  }) async {
    var payload = addSoldItemModel.toJson();

    return await dio.post(
      'sold/add-solditem',
      data: payload,
    );
  }

  @override
  Future<Response> getAllOrders() async {
    return await dio.get('Order/all-orders');
  }

  @override
  Future<Response> getSoldItemsById({required int orderId}) async {
    return await dio.get('sold/all-solditems/$orderId');
  }
}
