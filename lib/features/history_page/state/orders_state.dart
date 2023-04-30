import 'package:foodi_bizz/data/model/get_all_orders_model.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final GetAllOrdersModel getAllOrdersModel;
  const OrdersLoaded(this.getAllOrdersModel);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersLoaded &&
        other.getAllOrdersModel == getAllOrdersModel;
  }

  @override
  int get hashCode => getAllOrdersModel.hashCode;
}

class OrdersError extends OrdersState {
  final String message;
  const OrdersError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
