import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/history_page/state/sold_item_state.dart';

import '../../../data/repository/i_fooditem_repo.dart';

class SoldItemNotifiers extends StateNotifier<SoldItemState> {
  final IFoodItemRepository iFoodItemRepository;

  SoldItemNotifiers(super.state, {required this.iFoodItemRepository});

  Future<void> getSoldItems(int orderId) async {
    state = const SoldItemLoading();
    final result = await iFoodItemRepository.getSoldItemsById(orderId: orderId);

    result.when(
      (error) {
        state = SoldItemError(
          error.toString() == 'null'
              ? "Couldn't get food items"
              : error.toString(),
        );
      },
      (getSoldItemsModel) {
        state = SoldItemLoaded(getSoldItemsModel);
      },
    );
  }
}
