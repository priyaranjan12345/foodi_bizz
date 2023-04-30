import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/data/model/bill_fooditem_modle.dart';

class CurrentBillItem extends StateNotifier<List<BillFoodItemModel>> {
  CurrentBillItem(super.state);

  /// [addFoodItemToBill] method will add the item
  /// <br/> if food item is not present in the list,
  /// <br/> if food item already present in the bill list
  /// <br/> it will increment the qty of the item
  void addFoodItemToBill(BillFoodItemModel billFoodItemModel) {
    var foodItemIndex = state.indexWhere(
      (element) => element.id == billFoodItemModel.id,
    );

    if (foodItemIndex == -1) {
      state = [...state, billFoodItemModel];
    } else {
      state = [
        for (final foodItem in state)
          if (foodItem.id == billFoodItemModel.id)
            foodItem.copyWith(quantity: state[foodItemIndex].quantity + 1)
          else
            foodItem,
      ];
    }
  }

  /// [incrementQty(int foodId, int oldQty)] it will
  /// increment the food item qty
  void incrementQty(int foodId, int oldQty) {
    state = [
      for (final foodItem in state)
        if (foodItem.id == foodId)
          foodItem.copyWith(quantity: oldQty + 1)
        else
          foodItem,
    ];
  }

  /// [decrementQty(int foodId, oldQty)] it will
  /// decrement the food item qty
  void decrementQty(int foodId, oldQty) {
    state = [
      for (final foodItem in state)
        if (foodItem.id == foodId)
          foodItem.copyWith(quantity: max(1, oldQty - 1))
        else
          foodItem,
    ];
  }

  /// [removeItem(int foodId)] method will
  /// remove the item from the bill list
  void removeItem(int foodId) {
    state = [
      for (final foodItem in state)
        if (foodItem.id != foodId) foodItem,
    ];
  }
}
