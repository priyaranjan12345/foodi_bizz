import '../../../data/model/fooditem_model.dart';

abstract class FoodItemState {
  const FoodItemState();
}

class FoodItemsInitial extends FoodItemState {
  const FoodItemsInitial();
}

class FoodItemsLoading extends FoodItemState {
  const FoodItemsLoading();
}

class FoodItemsLoaded extends FoodItemState {
  final FoodItemModel foodItemModel;
  const FoodItemsLoaded(this.foodItemModel);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodItemsLoaded && other.foodItemModel == foodItemModel;
  }

  @override
  int get hashCode => foodItemModel.hashCode;
}

class FoodItemsError extends FoodItemState {
  final String message;
  const FoodItemsError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodItemsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
