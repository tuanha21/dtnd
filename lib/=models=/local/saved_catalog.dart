import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 3)
class SavedCatalog extends HiveObject {
  SavedCatalog({required String user}) : _user = user;

  @HiveField(0)
  final String _user;

  @HiveField(1)
  final List<LocalCatalog> catalogs = const <LocalCatalog>[];
}
