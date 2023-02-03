import 'package:dtnd/=models=/local/catalog_exception.dart';
import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'saved_catalog.g.dart';

@HiveType(typeId: 3)
class SavedCatalog{
  SavedCatalog(this._user, {this.catalogs = const <LocalCatalog>[]});

  @HiveField(0)
  final String _user;

  @HiveField(1, defaultValue: <LocalCatalog>[])
  late List<LocalCatalog> catalogs;

  void addCatalog(LocalCatalog catalog) {
    try {
      if (catalogs.contains(catalog)) {
        throw ExistedCatalogException();
      }
      catalogs.add(catalog);
    } catch (e) {
      logger.e(e);
    }
  }

  void removeCatalog(LocalCatalog catalog) {
    try {
      catalogs.removeWhere((element) => element.name == catalog.name);
    } catch (e) {
      logger.e(e);
    }
  }

  String get user => _user;

  @override
  String toString() {
    return "$_user \n ${catalogs.toString()}";
  }
}
