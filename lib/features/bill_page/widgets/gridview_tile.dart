import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/fooditem_model.dart';

class GridviewTile extends StatelessWidget {
  const GridviewTile(
      {Key? key, required this.foodItem, required this.onTapAddButton})
      : super(key: key);

  final FoodItem foodItem;
  final VoidCallback onTapAddButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 134,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://127.0.0.1:8000/${foodItem.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Name : ${foodItem.name}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 40,
            child: Text(
              foodItem.desc,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const Spacer(),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Price : \u{20B9} ${foodItem.price}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              FilledButton(
                onPressed: onTapAddButton,
                style: ButtonStyle(
                  shape: ButtonState.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
