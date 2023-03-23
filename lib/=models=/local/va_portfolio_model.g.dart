// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'va_portfolio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VAPortfolioAdapter extends TypeAdapter<VAPortfolio> {
  @override
  final int typeId = 7;

  @override
  VAPortfolio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VAPortfolio(
      fields[0] as VAPortfolioSetting,
      listStocks: (fields[1] as List?)?.cast<VAPortfolioItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, VAPortfolio obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.generalSetting)
      ..writeByte(1)
      ..write(obj.listStocks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VAPortfolioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VAPortfolioItemAdapter extends TypeAdapter<VAPortfolioItem> {
  @override
  final int typeId = 6;

  @override
  VAPortfolioItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VAPortfolioItem(
      fields[0] as String,
      fields[1] as VAPortfolioSetting,
    );
  }

  @override
  void write(BinaryWriter writer, VAPortfolioItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.setting);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VAPortfolioItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VAPortfolioSettingAdapter extends TypeAdapter<VAPortfolioSetting> {
  @override
  final int typeId = 5;

  @override
  VAPortfolioSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VAPortfolioSetting(
      fields[0] as num,
      fields[1] as num,
      fields[2] as num,
      fields[3] as num,
      fields[4] as num,
    );
  }

  @override
  void write(BinaryWriter writer, VAPortfolioSetting obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.rrMax)
      ..writeByte(1)
      ..write(obj.buy)
      ..writeByte(2)
      ..write(obj.sell)
      ..writeByte(3)
      ..write(obj.volumeFix)
      ..writeByte(4)
      ..write(obj.volumePercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VAPortfolioSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
