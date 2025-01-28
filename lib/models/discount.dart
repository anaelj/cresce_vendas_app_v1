import 'package:hive/hive.dart';

part 'discount.g.dart';

@HiveType(typeId: 1)
class Discount {
  @HiveField(0)
  bool status;

  @HiveField(1)
  String type;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  @HiveField(4)
  double fromPrice;

  @HiveField(5)
  double percentageDiscount;

  @HiveField(6)
  double toPrice;

  @HiveField(7)
  int buyQuantity;

  @HiveField(8)
  int payQuantity;

  Discount({
    this.status = true,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.fromPrice = 0,
    this.percentageDiscount = 0,
    this.toPrice = 0,
    this.buyQuantity = 0,
    this.payQuantity = 0,
  });
}