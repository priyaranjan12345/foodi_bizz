import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/features/bill_page/widgets/bill_board.dart';
import 'package:foodi_bizz/features/bill_page/widgets/bill_item_tile.dart';
import 'package:foodi_bizz/shared/helper/info_dialog.dart';
import 'package:gap/gap.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/app_colors.dart';
import '../../../data/model/bill_fooditem_modle.dart';
import '../../../data/model/fooditem_model.dart';
import '../../item_page/provider/items_provider.dart';
import '../../item_page/state/fooditem_state.dart';
import '../../../shared/state_ui/on_error.dart';
import '../../../shared/state_ui/on_loading.dart';
import '../provider/billl_page_provider.dart';
import '../widgets/gridview_tile.dart';

final ScrollController scrollController = ScrollController();

class BillPage extends StatelessWidget {
  const BillPage({Key? key}) : super(key: key);

  void onAddItem(WidgetRef ref, FoodItem foodItem) {
    ref.read(currentBillProvider.notifier).addFoodItemToBill(
          BillFoodItemModel(
            desc: foodItem.desc,
            id: foodItem.id,
            image: foodItem.image,
            name: foodItem.name,
            price: foodItem.price,
            quantity: 1,
          ),
        );
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  showPreviewBillDialog(BuildContext context, List<BillFoodItemModel> cbl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return ContentDialog(
          title: const Text('FOODI-BIZZ'),
          content: SizedBox(
            height: 540,
            child: Consumer(builder: (context, ref, _) {
              return PdfPreview(
                useActions: true,
                build: (format) => generateBill(format, cbl),
                onPrinted: (context) {
                  ref
                      .read(saveBillSetailstBillProvider.notifier)
                      .saveOrderDetails(cbl);
                },
              );
            }),
          ),
        );
      },
    );
  }

  Future<Uint8List> generateBill(
    PdfPageFormat format,
    List<BillFoodItemModel> cbl,
  ) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'Foodi-Bizz',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'At- Housing Board Colony, F.C.I Twonship\nDist- Angul(O)- 759106\nMob- 902741097, 8976380189\nEmail- anymail@gmail.com',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 22,
                ),
              ),
              pw.Text(
                '-' * 60,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Text(
                'INV-${DateTime.now()}',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 20,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Name',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Price',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Qty',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Total',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              ...cbl.map(
                (e) => pw.Container(
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          e.name,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          e.price.toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          e.quantity.toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          '${e.price * e.quantity}',
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Text(
                'Grand Total: ${cbl.fold(0, (previousValue, element) => double.parse(previousValue.toString()) + (element.price * element.quantity))}',
                textAlign: pw.TextAlign.right,
                style:
                    pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Wellcome, Username',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Discover what you need easily.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(foodItemsStateNotifierProvider);

                        if (state is FoodItemsInitial) {
                          return const OnLoadingWidget();
                        } else if (state is FoodItemsLoading) {
                          return const OnLoadingWidget();
                        } else if (state is FoodItemsLoaded) {
                          return GridView.builder(
                            itemCount: state.foodItemModel.foodItems.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width < 1500
                                      ? 3
                                      : 4,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 300,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (context, index) {
                              var foodItem =
                                  state.foodItemModel.foodItems[index];
                              return GridviewTile(
                                foodItem: foodItem,
                                onTapAddButton: () => onAddItem(ref, foodItem),
                              );
                            },
                          );
                        } else {
                          return const OnErrorWidget();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                color: AppColors.customLightGrey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Consumer(builder: (context, ref, _) {
                    final cbl = ref.watch(currentBillProvider);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Current Orders : ${cbl.length}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: cbl.length,
                            itemBuilder: (context, index) {
                              return BillItemTile(
                                foodItem: cbl[index],
                                onIncQty: (foodItem) {
                                  ref
                                      .read(currentBillProvider.notifier)
                                      .incrementQty(
                                        foodItem.id,
                                        foodItem.quantity,
                                      );
                                },
                                onDecQty: (foodItem) {
                                  ref
                                      .read(currentBillProvider.notifier)
                                      .decrementQty(
                                          foodItem.id, foodItem.quantity);
                                },
                                onRemoveItem: (foodItemId) {
                                  ref
                                      .read(currentBillProvider.notifier)
                                      .removeItem(foodItemId);
                                },
                              );
                            },
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: BillBoard(),
                        ),
                        PrintBillButton(
                          onBtnPressed: () {
                            if (cbl.isNotEmpty) {
                              showPreviewBillDialog(context, cbl);
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => const InfoDialog(
                                  message:
                                      'No item to print the bill. Please add items to print the bill.',
                                  title: 'Information',
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class PrintBillButton extends StatelessWidget {
  const PrintBillButton({
    Key? key,
    required this.onBtnPressed,
  }) : super(key: key);

  final VoidCallback onBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        backgroundColor: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 0,
        child: SizedBox(
          height: 40,
          child: FilledButton(
            onPressed: onBtnPressed,
            style: ButtonStyle(
              shape: ButtonState.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding: ButtonState.all(
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(FluentIcons.print),
                Gap(10),
                Text(
                  'Print Bill',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
