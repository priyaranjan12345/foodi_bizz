import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodi_bizz/core/file_picker.dart';
import 'package:foodi_bizz/shared/state_ui/on_error.dart';
import 'package:foodi_bizz/shared/state_ui/on_loading.dart';
import 'package:foodi_bizz/features/item_page/widgets/item_list.dart';
import 'package:gap/gap.dart';

import '../../../core/app_colors.dart';
import '../provider/items_provider.dart';
import '../state/fooditem_state.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Item List',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Consumer(builder: (context, ref, _) {
                          return FilledButton(
                            onPressed: () {
                              isUpdate.value = false;
                              idController.text = '';
                              nameController.clear();
                              descController.clear();
                              priceController.clear();
                              ref.read(imageFileProvider.state).state = null;
                            },
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
                              children: const [
                                Icon(FluentIcons.add),
                                Gap(10),
                                Text(
                                  'Add Item',
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(foodItemsStateNotifierProvider);

                        if (state is FoodItemsInitial) {
                          return const OnLoadingWidget();
                        } else if (state is FoodItemsLoading) {
                          return const OnLoadingWidget();
                        } else if (state is FoodItemsLoaded) {
                          return ItemList(
                            foodItems: state.foodItemModel.foodItems,
                            imageWidth: width * 0.1,
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
            flex: 1,
            child: LayoutBuilder(builder: (context, constraints) {
              double cHeight = constraints.maxHeight / 100;
              double cWidth = constraints.maxWidth / 100;
              double cTextScale = (cHeight * cWidth) / 10;

              return Consumer(builder: (context, ref, _) {
                final imgPicker = ref.watch(imageFileProvider);
                final imgNetworkPicker = ref.watch(imageNetworkProvider);

                return Container(
                  color: AppColors.customLightGrey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Add/Update Item',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: cTextScale * 5.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextBox(
                        header: 'ID',
                        placeholder: 'Item ID',
                        expands: false,
                        enabled: false,
                        controller: idController,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextBox(
                        header: 'Enter Food Name',
                        placeholder: 'Name',
                        expands: false,
                        controller: nameController,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextBox(
                        header: 'Enter Food Description',
                        placeholder: 'Description',
                        expands: false,
                        maxLines: null,
                        controller: descController,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextBox(
                        header: 'Enter Food Price',
                        placeholder: 'Price',
                        expands: false,
                        controller: priceController,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ValueListenableBuilder(
                          valueListenable: isUpdate,
                          builder: (_, __, ___) => Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            height: cHeight * 30,
                            width: cHeight * 40,
                            // image viewer
                            child: !isUpdate.value
                                ? imgPicker == null
                                    ? Container()
                                    : Image.file(
                                        imgPicker,
                                        fit: BoxFit.cover,
                                      )
                                : imgNetworkPicker == ''
                                    ? Container()
                                    : imgPicker == null
                                        ? Image.network(
                                            imgNetworkPicker,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            imgPicker,
                                            fit: BoxFit.cover,
                                          ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: FilledButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(FluentIcons.add),
                              SizedBox(width: 10),
                              Text('Select Food Image')
                            ],
                          ),
                          onPressed: () async {
                            ref.read(imageFileProvider.state).state =
                                await SelectFile().pickFile();
                          },
                        ),
                      ),
                      const Spacer(),
                      ValueListenableBuilder(
                        valueListenable: isUpdate,
                        builder: (context, bool value, child) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                              scale: animation,
                              child: SizeTransition(
                                sizeFactor: animation,
                                axisAlignment: -10,
                                axis: Axis.vertical,
                                child: child,
                              ),
                            ),
                            child: value
                                ? UpdateItemButtons(
                                    cHeight: cHeight,
                                    cWidth: cWidth,
                                    cTextScale: cTextScale,
                                  )
                                : AddItemButtons(
                                    cHeight: cHeight,
                                    cWidth: cWidth,
                                    cTextScale: cTextScale,
                                  ),
                          );
                        },
                      )
                    ],
                  ),
                );
              });
            }),
          )
        ],
      ),
    );
  }
}

class UpdateItemButtons extends StatelessWidget {
  const UpdateItemButtons(
      {Key? key,
      required this.cHeight,
      required this.cWidth,
      required this.cTextScale})
      : super(key: key);

  final double cHeight;
  final double cWidth;
  final double cTextScale;

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      elevation: 0,
      child: SizedBox(
        height: cHeight * 4.7,
        child: Consumer(builder: (context, ref, _) {
          final imgPicker = ref.watch(imageFileProvider);
          return FilledButton(
            onPressed: () async {
              // update item
              await ref
                  .read(foodItemsStateNotifierProvider.notifier)
                  .updateFoodItem(
                    foodId: int.parse(idController.text),
                    name: nameController.text,
                    desc: descController.text,
                    price: double.parse(priceController.text),
                    dateTime: DateTime.now().toString(),
                    image: imgPicker,
                  );

              await ref
                  .read(foodItemsStateNotifierProvider.notifier)
                  .getAllFoodItems();

              idController.clear();
              nameController.clear();
              descController.clear();
              priceController.clear();
              ref.read(imageFileProvider.state).state = null;
              ref.read(imageNetworkProvider.state).state = '';
            },
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
                Icon(FluentIcons.upload),
                Gap(10),
                Text(
                  'Update Item',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AddItemButtons extends ConsumerWidget {
  const AddItemButtons(
      {Key? key,
      required this.cHeight,
      required this.cWidth,
      required this.cTextScale})
      : super(key: key);

  final double cHeight;
  final double cWidth;
  final double cTextScale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgPicker = ref.watch(imageFileProvider);
    return Card(
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      elevation: 0,
      child: SizedBox(
        height: cHeight * 4.7,
        child: FilledButton(
          onPressed: () async {
            await ref.read(foodItemsStateNotifierProvider.notifier).addFoodItem(
                  name: nameController.text,
                  desc: descController.text,
                  price: double.parse(priceController.text),
                  dateTime: DateTime.now().toString(),
                  image: imgPicker,
                );

            await ref
                .read(foodItemsStateNotifierProvider.notifier)
                .getAllFoodItems();

            nameController.clear();
            descController.clear();
            priceController.clear();
            ref.read(imageFileProvider.state).state = null;
          },
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
              Icon(FluentIcons.save),
              Gap(10),
              Text(
                'Save Item',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
