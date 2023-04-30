import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/get_sold_items_model.dart';

class SoldItemTile extends StatelessWidget {
  const SoldItemTile({super.key, required this.soldItem});

  final SoldItem soldItem;

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
          leading: SizedBox(
            width: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://127.0.0.1:8000/${soldItem.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Name: ${soldItem.name}'),
              Text('Price: ${soldItem.price}'),
              Text('Qty: ${soldItem.itemQty}'),
            ],
          ),
        ),
      ),
    );
  }
}
