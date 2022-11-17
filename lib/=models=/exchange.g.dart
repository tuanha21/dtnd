// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeAdapter extends TypeAdapter<Exchange> {
  @override
  final int typeId = 1;

  @override
  Exchange read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Exchange.HOSE;
      case 1:
        return Exchange.HNX;
      case 2:
        return Exchange.UPCOM;
      default:
        return Exchange.HOSE;
    }
  }

  @override
  void write(BinaryWriter writer, Exchange obj) {
    switch (obj) {
      case Exchange.HOSE:
        writer.writeByte(0);
        break;
      case Exchange.HNX:
        writer.writeByte(1);
        break;
      case Exchange.UPCOM:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
