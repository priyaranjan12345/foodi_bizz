import 'dart:io';

class FoodItemPropModel {
  final int id;
  final String name;
  final String desc;
  final double price;
  final String dateTime;
  final File? file;

  FoodItemPropModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.dateTime,
    required this.file,
  });
}
