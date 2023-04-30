import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/history_page/state/orders_state.dart';

import '../../../data/repository/i_fooditem_repo.dart';

class HistoryNotifiers extends StateNotifier<OrdersState> {
  final IFoodItemRepository iFoodItemRepository;

  HistoryNotifiers(super.state, {required this.iFoodItemRepository});

  Future<void> getAllOrders() async {
    state = const OrdersLoading();
    final result = await iFoodItemRepository.getAllOrders();

    result.when(
      (error) {
        state = OrdersError(
          error.toString() == 'null'
              ? "Couldn't get food items"
              : error.toString(),
        );
      },
      (getAllOrdersModel) {
        state = OrdersLoaded(getAllOrdersModel);
      },
    );
  }

  Future<void> getSoldItems(int orderId) async {
    final result = await iFoodItemRepository.getSoldItemsById(orderId: orderId);

    result.when(
      (error) {},
      (success) {},
    );
  }
}
