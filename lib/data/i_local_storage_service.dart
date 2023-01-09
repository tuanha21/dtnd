import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Box get box;

  SharedPreferences get sharedPreferences;

  Future<void> init();

  Future<void> flush();

  List<Stock>? getSavedListAllStock();

  UserToken? getSavedUserToken();

  Future<void> saveUserToken(UserToken token);

  List<String>? getListInterestedStock();

  SavedCatalog? getSavedCatalog(String user);

  Future<void> putSavedCatalog(SavedCatalog savedCatalog);
}
