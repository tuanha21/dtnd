import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_catalog.g.dart';

@HiveType(typeId: 4)
class UserCatalog extends LocalCatalog {
  UserCatalog(this._name,this._stocks);

  @HiveField(0)
  String _name;

  @HiveField(1, defaultValue: <String>[])
  List<String> _stocks;

  @override
  String get name => _name;

  @override
  List<String> get listStock => _stocks;

  @override
  void rename(String name) {
    if (name.isEmpty || name.length > 30) {
      return;
    }
    _name = name;
  }

  @override
  set setStockList(List<String> list) {
    _stocks = list;
  }
}
