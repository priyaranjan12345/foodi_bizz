import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/history_page/state/orders_state.dart';

import '../../item_page/provider/items_provider.dart';
import '../notifier/history_notifiers.dart';
import '../notifier/sold_item_notifiers.dart';
import '../state/sold_item_state.dart';

final historyProvider =
    StateNotifierProvider.autoDispose<HistoryNotifiers, OrdersState>(
  (ref) => HistoryNotifiers(
    const OrdersInitial(),
    iFoodItemRepository: ref.watch(foodItemRepositoryProvider),
  )..getAllOrders(),
);

final soldItemProvider =
    StateNotifierProvider.autoDispose<SoldItemNotifiers, SoldItemState>(
  (ref) => SoldItemNotifiers(
    const SoldItemInitial(),
    iFoodItemRepository: ref.watch(foodItemRepositoryProvider),
  ),
);
