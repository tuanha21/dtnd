import 'package:hive_flutter/hive_flutter.dart';

part 'volatility_warning_stock.g.dart';

@HiveType(typeId: 5)
enum VolatilityWarningFigureType {
  @HiveField(0)
  price,

  @HiveField(1)
  sma,

  @HiveField(2)
  lossPrice,

  @HiveField(3)
  gainPrice,
}

extension VolatilityWarningFigureTypeX on VolatilityWarningFigureType {
  Type get type {
    switch (this) {
      case VolatilityWarningFigureType.price:
        return num;
      case VolatilityWarningFigureType.sma:
        return String;
      case VolatilityWarningFigureType.lossPrice:
        return num;
      case VolatilityWarningFigureType.gainPrice:
        return num;
    }
  }

  dynamic get defaultValue {
    switch (this) {
      case VolatilityWarningFigureType.price:
        return 0;
      case VolatilityWarningFigureType.sma:
        return "Giá cắt lên SMA(10)";
      case VolatilityWarningFigureType.lossPrice:
        return 0;
      case VolatilityWarningFigureType.gainPrice:
        return 0;
    }
  }
}

@HiveType(typeId: 6)
class VolatilityWarningFigure {
  VolatilityWarningFigure({required this.type, this.value});
  @HiveField(0)
  final VolatilityWarningFigureType type;

  @HiveField(1)
  dynamic value;

  void updateValue(dynamic newValue) => value = newValue;
}

@HiveType(typeId: 7)
class VolatilityWarningCatalogStock extends HiveObject {
  VolatilityWarningCatalogStock(this.stock);
  @HiveField(0)
  String stock;

  @HiveField(1)
  final Set<VolatilityWarningFigure> _listFigures = <VolatilityWarningFigure>{
    for (var type in VolatilityWarningFigureType.values)
      VolatilityWarningFigure(type: type, value: type.defaultValue)
  };

  Set<VolatilityWarningFigure> get listFigures => _listFigures;
}