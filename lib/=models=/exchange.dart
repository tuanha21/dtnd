// ignore_for_file: constant_identifier_names
import 'package:hive_flutter/hive_flutter.dart';
part 'exchange.g.dart';

@HiveType(typeId: 1)
enum Exchange {
  @HiveField(0)
  HOSE,
  @HiveField(1)
  HNX,
  @HiveField(2)
  UPCOM
}

extension ExchangeX on Exchange {
  Set<OrderType> get listOrderType {
    switch (this) {
      case Exchange.HOSE:
        return {
          OrderType.LO,
          OrderType.MP,
          OrderType.ATO,
          OrderType.ATC,
        };
      case Exchange.HNX:
        return {
          OrderType.LO,
          OrderType.PLO,
          OrderType.MOK,
          OrderType.MAK,
          OrderType.ATO,
          OrderType.ATC,
        };
      case Exchange.UPCOM:
        return {
          OrderType.LO,
        };
    }
  }

  num getPriceInterval(num price) {
    switch (this) {
      case Exchange.HOSE:
        if (price <= 9.99) return 0.01;
        if (price > 9.99 && price <= 49.95) return 0.05;
        return 0.1;
      default:
        return 0.1;
    }
  }

  num get volumnInterval => 100;
}

enum OrderType { LO, MP, ATO, ATC, PLO, MAK, MOK, MTL }

extension OrderTypeX on OrderType {
  bool get isLO => this == OrderType.LO;

  String get value => name;

  String get detailName {
    switch (this) {
      case OrderType.LO:
        return "Limit order";
      case OrderType.MP:
        return "Market order";
      case OrderType.ATO:
        return "At the opening";
      case OrderType.ATC:
        return "At the closing";
      case OrderType.PLO:
        return "Post limit order";
      case OrderType.MAK:
        return "Match and kill";
      case OrderType.MOK:
        return "Match or kill";
      case OrderType.MTL:
        return "Market to limit";
    }
  }
}

class ExchangeHelper {
  static Exchange fromString(String? string) {
    switch (string?.toUpperCase()) {
      case "HOSE":
        return Exchange.HOSE;
      case "HNX":
        return Exchange.HNX;
      case "UPCOM":
        return Exchange.UPCOM;
      default:
        return Exchange.HOSE;
    }
  }
}
