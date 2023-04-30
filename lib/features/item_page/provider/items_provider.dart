import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/data/model/fooditem_prop_model.dart';

import '../../../data/api/fooditem_apis.dart';
import '../../../data/api/i_fooditem_apis.dart';
import '../../../data/repository/fooditem_repo.dart';
import '../../../data/repository/i_fooditem_repo.dart';
import '../notifier/items_state_notifier.dart';
import '../state/fooditem_state.dart';

final foodItemPropModelProvider = StateProvider<FoodItemPropModel>(
  (ref) => FoodItemPropModel(
    id: 0,
    name: '',
    desc: '',
    price: 0.0,
    dateTime: '',
    file: null,
  ),
);

final foodItemApiProvider = Provider<IFoodItemProvider>(
  (ref) => FoodItemProvider(),
);

final foodItemRepositoryProvider = Provider<IFoodItemRepository>(
  (ref) => FoodItemRepository(
    iFoodItemProvider: ref.watch(foodItemApiProvider),
  ),
);

final foodItemsStateNotifierProvider =
    StateNotifierProvider.autoDispose<FoodItemStateNotifier, FoodItemState>(
  (ref) => FoodItemStateNotifier(
    const FoodItemsInitial(),
    iFoodItemRepository: ref.watch(foodItemRepositoryProvider),
  )..getAllFoodItems(),
);

final addFoodItemFutureProvider = FutureProvider((ref) async {
  final repository = ref.watch(foodItemRepositoryProvider);
  final foodItem = ref.watch(foodItemPropModelProvider);
  final result = await repository.addFoodItem(
    name: foodItem.name,
    desc: foodItem.desc,
    price: foodItem.price,
    dateTime: foodItem.dateTime,
    image: foodItem.file,
  );

  result.when(
    (error) {
      throw Exception();
    },
    (foodItem) {
      return foodItem;
    },
  );
});

final imageFileProvider = StateProvider<File?>((ref) => null);
final imageNetworkProvider = StateProvider<String>((ref) => '');

TextEditingController nameController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController idController = TextEditingController();

var isUpdate = ValueNotifier(false);
