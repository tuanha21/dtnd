import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'saved_catalog.g.dart';

@HiveType(typeId: 3)
class SavedCatalog extends HiveObject {
  SavedCatalog(this._user);

  @HiveField(0)
  final String _user;

  @HiveField(1)
  final List<LocalCatalog> catalogs = const <LocalCatalog>[];
}
