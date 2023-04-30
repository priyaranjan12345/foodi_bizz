import 'package:foodi_bizz/data/model/get_sold_items_model.dart';

abstract class SoldItemState {
  const SoldItemState();
}

class SoldItemInitial extends SoldItemState {
  const SoldItemInitial();
}

class SoldItemLoading extends SoldItemState {
  const SoldItemLoading();
}

class SoldItemLoaded extends SoldItemState {
  final GetSoldItemsModel getSoldItemModel;
  const SoldItemLoaded(this.getSoldItemModel);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SoldItemLoaded &&
        other.getSoldItemModel == getSoldItemModel;
  }

  @override
  int get hashCode => getSoldItemModel.hashCode;
}

class SoldItemError extends SoldItemState {
  final String message;
  const SoldItemError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SoldItemError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
