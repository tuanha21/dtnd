import 'package:intl/intl.dart';

final NumberFormat integerFormat = NumberFormat("###,###,###,###,###", "en_US");
final NumberFormat integerFormat10 =
    NumberFormat("###,###,###,###,##", "en_US");
final NumberFormat doubleFormat =
    NumberFormat("###,###,###,###,###.##", "en_US");

enum Compact { million, billion }

class NumUtils {
  static String formatDouble(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return doubleFormat.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static String formatInteger(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return integerFormat.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static String formatInteger10(num? integer, [String? nullString]) {
    if (_invalidInput(integer)) return nullString ?? "";
    try {
      return integerFormat10.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static String formatDoubleString(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return doubleFormat.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static String formatIntegerString(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return integerFormat.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static String formatIntegerString10(String? string, [String? nullString]) {
    if (_invalidInput(string)) return nullString ?? "";
    try {
      final num integer = num.parse(string!);
      return integerFormat10.format(integer);
    } catch (e) {
      print(e);
      return nullString ?? "";
    }
  }

  static bool _invalidInput(dynamic data) => data == null;
}
