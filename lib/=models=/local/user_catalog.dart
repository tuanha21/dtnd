import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_catalog.g.dart';

@HiveType(typeId: 4)
class UserCatalog extends LocalCatalog {
  UserCatalog(this._name);

  @HiveField(0)
  String _name;

  @HiveField(1)
  final List<String> _stocks = [];

  @override
  String get name => _name;

  @override
  List<String> get stocks => _stocks;

  @override
  void rename(String name) {
    if (name.isEmpty || name.length > 30) {
      return;
    }
    _name = name;
    save();
  }
}
