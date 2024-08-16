// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelsAdapter extends TypeAdapter<TransactionModels> {
  @override
  final int typeId = 3;

  @override
  TransactionModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModels(
      purpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      transactiontype: fields[3] as CategoryType,
      transactionmodel: fields[4] as CategoryModel,
    )..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, TransactionModels obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.transactiontype)
      ..writeByte(4)
      ..write(obj.transactionmodel)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
