import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../features/item_page/provider/items_provider.dart';

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/error.json',
            width: 200,
            height: 200,
          ),
          const Text(
            'Oops Something Went Wrong Please Try Again Later',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(10),
          Consumer(builder: (context, ref, _) {
            return Button(
              onPressed: () {
                ref
                    .read(foodItemsStateNotifierProvider.notifier)
                    .getAllFoodItems();
              },
              child: const Text('Refresh'),
            );
          }),
        ],
      ),
    );
  }
}
