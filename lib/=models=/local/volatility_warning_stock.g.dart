// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volatility_warning_stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VolatilityWarningFigureAdapter
    extends TypeAdapter<VolatilityWarningFigure> {
  @override
  final int typeId = 6;

  @override
  VolatilityWarningFigure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VolatilityWarningFigure(
      type: fields[0] as VolatilityWarningFigureType,
      value: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, VolatilityWarningFigure obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolatilityWarningFigureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VolatilityWarningCatalogStockAdapter
    extends TypeAdapter<VolatilityWarningCatalogStock> {
  @override
  final int typeId = 7;

  @override
  VolatilityWarningCatalogStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VolatilityWarningCatalogStock(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VolatilityWarningCatalogStock obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stock)
      ..writeByte(1)
      ..write(obj._listFigures.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolatilityWarningCatalogStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VolatilityWarningFigureTypeAdapter
    extends TypeAdapter<VolatilityWarningFigureType> {
  @override
  final int typeId = 5;

  @override
  VolatilityWarningFigureType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VolatilityWarningFigureType.price;
      case 1:
        return VolatilityWarningFigureType.sma;
      case 2:
        return VolatilityWarningFigureType.lossPrice;
      case 3:
        return VolatilityWarningFigureType.gainPrice;
      default:
        return VolatilityWarningFigureType.price;
    }
  }

  @override
  void write(BinaryWriter writer, VolatilityWarningFigureType obj) {
    switch (obj) {
      case VolatilityWarningFigureType.price:
        writer.writeByte(0);
        break;
      case VolatilityWarningFigureType.sma:
        writer.writeByte(1);
        break;
      case VolatilityWarningFigureType.lossPrice:
        writer.writeByte(2);
        break;
      case VolatilityWarningFigureType.gainPrice:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolatilityWarningFigureTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
