import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalCatalog extends HiveObject {
  String get name;

  List<String> get listData;

  set setStockList(List<String> list);

  // void add(String stock);
  // void addAll(List<String> stocks);
  // String remove(String stock);

  void rename(String name);

  @override
  operator ==(Object other) {
    return (other is LocalCatalog && other.name == name);
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return "{\n\t$name\n\t${listData.toString()}\n}";
  }
}
