import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../data/model/fooditem_model.dart';
import '../provider/items_provider.dart';

class FoodItemListTile extends StatelessWidget {
  const FoodItemListTile({
    Key? key,
    required this.imageWidth,
    required this.foodItem,
  }) : super(key: key);

  final double imageWidth;
  final FoodItem foodItem;

  showDeleteDialog(BuildContext context, int foodId) {
    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: const Text('FOODI-BIZZ'),
          content: const Text('Are you sure, you want to delete this item?'),
          actions: [
            Consumer(builder: (context, ref, _) {
              return FilledButton(
                child: const Text('Yes'),
                onPressed: () async {
                  Navigator.pop(context);
                  await ref
                      .read(foodItemsStateNotifierProvider.notifier)
                      .deleteFoodItem(foodItemId: foodId);
                  await ref
                      .read(foodItemsStateNotifierProvider.notifier)
                      .getAllFoodItems();
                },
              );
            }),
            Button(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 140,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          tileColor: AppColors.customLightGrey,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer(builder: (context, ref, _) {
                return IconButton(
                  icon: Icon(
                    FluentIcons.edit,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: () {
                    isUpdate.value = true;
                    ref.read(imageFileProvider.state).state = null;
                    idController.text = foodItem.id.toString();
                    nameController.text = foodItem.name;
                    descController.text = foodItem.desc;
                    priceController.text = foodItem.price.toString();
                    ref.read(imageNetworkProvider.state).state =
                        'http://127.0.0.1:8000/${foodItem.image}';
                  },
                );
              }),
              IconButton(
                icon: Icon(
                  FluentIcons.delete,
                  color: Colors.blue,
                  size: 20,
                ),
                onPressed: () {
                  showDeleteDialog(context, foodItem.id);
                },
              ),
            ],
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Name : ${foodItem.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Price : \u{20B9} ${foodItem.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                foodItem.desc,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          leading: SizedBox(
            width: imageWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://127.0.0.1:8000/${foodItem.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
