import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/fooditem_model.dart';
import 'item_tile.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
    required this.foodItems,
    required this.imageWidth,
  }) : super(key: key);

  final List<FoodItem> foodItems;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: foodItems.length,
      itemBuilder: (
        context,
        index,
      ) {
        return FoodItemListTile(
          imageWidth: imageWidth,
          foodItem: foodItems[index],
        );
      },
    );
  }
}
