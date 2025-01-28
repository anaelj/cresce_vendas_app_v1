// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscountAdapter extends TypeAdapter<Discount> {
  @override
  final int typeId = 1;

  @override
  Discount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Discount(
      status: fields[0] as bool,
      type: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      fromPrice: fields[4] as double,
      percentageDiscount: fields[5] as double,
      toPrice: fields[6] as double,
      buyQuantity: fields[7] as int,
      payQuantity: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Discount obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.fromPrice)
      ..writeByte(5)
      ..write(obj.percentageDiscount)
      ..writeByte(6)
      ..write(obj.toPrice)
      ..writeByte(7)
      ..write(obj.buyQuantity)
      ..writeByte(8)
      ..write(obj.payQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
