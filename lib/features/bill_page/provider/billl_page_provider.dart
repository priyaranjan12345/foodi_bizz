import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/bill_page/notifier/save_bill_details_notifier.dart';

import '../../../data/model/bill_fooditem_modle.dart';
import '../../item_page/provider/items_provider.dart';
import '../notifier/current_bill_notifier.dart';

final currentBillProvider =
    StateNotifierProvider<CurrentBillItem, List<BillFoodItemModel>>(
  (ref) => CurrentBillItem([]),
);

final saveBillSetailstBillProvider = StateNotifierProvider(
  (ref) => SaveBillDetailsNotifier(
    null,
    iFoodItemRepository: ref.watch(foodItemRepositoryProvider),
  ),
);
