import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Box get box;

  Future<void> init();

  List<Stock>? getSavedListAllStock();

  UserToken? getSavedUserToken();

  Future<void> saveUserToken(UserToken token);

  List<String>? getListInterestedStock();

  Future<SavedCatalog?> getSavedCatalog(String user);

  Future<void> putSavedCatalog(SavedCatalog savedCatalog);
}
