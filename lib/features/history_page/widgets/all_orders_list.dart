import 'package:fluent_ui/fluent_ui.dart';
import 'package:foodi_bizz/features/history_page/widgets/order_tile.dart';

import '../../../data/model/get_all_orders_model.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.allOrders});

  final List<Order> allOrders;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return ListView.builder(
      controller: scrollController,
      itemCount: allOrders.length,
      itemBuilder: (context, index) {
        int revIndex = allOrders.length - (index + 1);
        return OrderTile(
          order: allOrders[revIndex],
        );
      },
    );
  }
}
