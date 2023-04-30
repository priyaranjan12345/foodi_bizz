import 'package:fluent_ui/fluent_ui.dart';
import 'package:foodi_bizz/features/history_page/widgets/sold_item_tile.dart';
import '../../../data/model/get_sold_items_model.dart';

class SoldItemList extends StatelessWidget {
  const SoldItemList({super.key, required this.allSoldItems});

  final List<SoldItem> allSoldItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: allSoldItems.length,
      itemBuilder: (context, index) => SoldItemTile(
        soldItem: allSoldItems[index],
      ),
    );
  }
}
