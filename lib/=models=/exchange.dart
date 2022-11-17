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
        throw NullThrownError();
    }
  }
}
