import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/bill_fooditem_modle.dart';

class BillItemTile extends StatelessWidget {
  const BillItemTile({
    Key? key,
    required this.foodItem,
    required this.onIncQty,
    required this.onDecQty,
    required this.onRemoveItem,
  }) : super(key: key);

  final BillFoodItemModel foodItem;
  final void Function(BillFoodItemModel) onIncQty;
  final void Function(BillFoodItemModel) onDecQty;
  final void Function(int) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          tileColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                foodItem.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\u{20B9} ${foodItem.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () => onIncQty(foodItem),
                        style: ButtonStyle(
                          shape: ButtonState.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          padding: ButtonState.all(
                            const EdgeInsets.all(8),
                          ),
                        ),
                        child: const Icon(
                          FluentIcons.add,
                          size: 10,
                        ),
                      ),
                      Text(
                        '  ${foodItem.quantity}  ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      FilledButton(
                        onPressed: () => onDecQty(foodItem),
                        style: ButtonStyle(
                          shape: ButtonState.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          padding: ButtonState.all(
                            const EdgeInsets.all(8),
                          ),
                        ),
                        child: const Icon(
                          FluentIcons.remove,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "\u{20B9} ${foodItem.price * foodItem.quantity}",
                textAlign: TextAlign.right,
              ),
            ],
          ),
          leading: SizedBox(
            width: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://127.0.0.1:8000/${foodItem.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: Column(
            children: [
              IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: () => onRemoveItem(foodItem.id),
              )
            ],
          ),
        ),
      ),
    );
  }
}
