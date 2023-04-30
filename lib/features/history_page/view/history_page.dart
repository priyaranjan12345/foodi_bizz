import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/history_page/state/orders_state.dart';
import 'package:foodi_bizz/features/history_page/widgets/sold_items_list.dart';

import '../../../core/app_colors.dart';
import '../provider/history_providers.dart';
import '../state/sold_item_state.dart';
import '../widgets/all_orders_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Consumer(
              builder: (context, ref, _) {
                final orderState = ref.watch(historyProvider);
                if (orderState is OrdersInitial) {
                  return const Center(
                    child: Text('Init state'),
                  );
                } else if (orderState is OrdersLoading) {
                  return const Center(
                    child: Text('Loading state'),
                  );
                } else if (orderState is OrdersLoaded) {
                  return HistoryList(
                    allOrders: orderState.getAllOrdersModel.allOrders,
                  );
                } else if (orderState is OrdersError) {
                  return Center(
                    child: Text('Error state : ${orderState.message}'),
                  );
                } else {
                  return const Center(
                    child: Text('Undefined state'),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.customLightGrey,
              child: Column(
                children: [
                  const Text(
                    'Sold Items',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final soldItemState = ref.watch(soldItemProvider);
                      if (soldItemState is SoldItemInitial) {
                        return const Center(
                          child: Text('Init state'),
                        );
                      } else if (soldItemState is SoldItemLoading) {
                        return const Center(
                          child: Text('Loading state'),
                        );
                      } else if (soldItemState is SoldItemLoaded) {
                        return Expanded(
                          child: SoldItemList(
                            allSoldItems:
                                soldItemState.getSoldItemModel.allSoldItems,
                          ),
                        );
                      } else if (soldItemState is SoldItemError) {
                        return Center(
                          child: Text('Error state : ${soldItemState.message}'),
                        );
                      } else {
                        return const Center(
                          child: Text('Undefined state'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
