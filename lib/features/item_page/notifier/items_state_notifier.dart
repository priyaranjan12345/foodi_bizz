import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/data/repository/i_fooditem_repo.dart';

import '../state/fooditem_state.dart';

class FoodItemStateNotifier extends StateNotifier<FoodItemState> {
  final IFoodItemRepository iFoodItemRepository;

  FoodItemStateNotifier(super.state, {required this.iFoodItemRepository});

  Future<void> getAllFoodItems() async {
    state = const FoodItemsLoading();
    final result = await iFoodItemRepository.getAllFoodItems();

    result.when(
      (error) {
        state = FoodItemsError(
          error.toString() == 'null'
              ? "Couldn't get food items"
              : error.toString(),
        );
      },
      (foodItemModel) {
        state = FoodItemsLoaded(foodItemModel);
      },
    );
  }

  Future<void> addFoodItem({
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  }) async {
    final result = await iFoodItemRepository.addFoodItem(
      name: name,
      desc: desc,
      price: price,
      dateTime: dateTime,
      image: image,
    );

    result.when(
      (error) {},
      (foodItem) {},
    );
  }

  Future<void> deleteFoodItem({
    required int foodItemId,
  }) async {
    final result = await iFoodItemRepository.deleteFoodItem(
      foodItemId: foodItemId,
    );

    result.when(
      (error) {},
      (success) {},
    );
  }

  Future<void> updateFoodItem({
    required int foodId,
    required String name,
    required String desc,
    required double price,
    required String dateTime,
    required File? image,
  }) async {
    final result = await iFoodItemRepository.updateFoodItem(
      id: foodId,
      name: name,
      desc: desc,
      price: price,
      lastModifiedDateTime: dateTime,
      image: image,
    );

    result.when(
      (error) {},
      (success) {},
    );
  }
}
