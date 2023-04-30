import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/add_sold_item_model.dart';
import '../../../data/model/bill_fooditem_modle.dart';
import '../../../data/repository/i_fooditem_repo.dart';

class SaveBillDetailsNotifier extends StateNotifier {
  final IFoodItemRepository iFoodItemRepository;

  SaveBillDetailsNotifier(super.state, {required this.iFoodItemRepository});

  // save order details
  // save bill/sold items
  Future<void> saveOrderDetails(List<BillFoodItemModel> billItems) async {
    int noOfItems = billItems.length;
    double total = billItems.isNotEmpty
        ? billItems
            .map<double>((item) => item.quantity * item.price)
            .reduce((value1, value2) => value1 + value2)
        : 0.0;

    final result = await iFoodItemRepository.addOrder(
      dateTime: DateTime.now().toString(),
      invNo: 'INV-${DateTime.now()}',
      noOfItems: noOfItems,
      gst: 0,
      discount: 0,
      grandTotal: total,
    );

    result.when(
      (error) {
        log('$error');
      },
      (addOrderModel) async {
        int orderId = addOrderModel.id;
        List<SoldItemModel> soldItemModels = [];
        for (var billItem in billItems) {
          SoldItemModel soldItemModel = SoldItemModel(
            id: 0,
            itemQty: billItem.quantity,
            orderId: orderId,
            itemId: billItem.id,
            itemUnitPrice: billItem.price,
          );
          soldItemModels.add(soldItemModel);
        }
        AddSoldItemModel addSoldItemModel =
            AddSoldItemModel(soldItemModels: soldItemModels);
        await addSoldItems(addSoldItemModel);
      },
    );
  }

  Future<void> addSoldItems(AddSoldItemModel addSoldItemModel) async {
    final result = await iFoodItemRepository.addSoldItems(
      addSoldItemModel: addSoldItemModel,
    );

    result.when(
      (error) {
        log('$error');
      },
      (addSoldItemModel) {
        log('item Saved : ');
      },
    );
  }
}
