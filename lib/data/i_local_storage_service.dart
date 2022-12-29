import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Future<void> init();

  List<Stock>? getSavedListAllStock();

  UserToken? getSavedUserToken();

  Future<void> saveUserToken(UserToken token);

  List<String>? getListInterestedStock();

  Future<Box<E>> getBox<E>(String boxName);

  Future<SavedCatalog<String>?> getSavedCatalog(String user);

  Future<void> putSavedCatalog(SavedCatalog<String> savedCatalog);

  Future<SavedCatalog<VolatilityWarningCatalogStock>?>
      getSavedVolatilityWarningCatalog(String user);

  Future<void> putSavedVolatilityWarningCatalog(
      SavedCatalog<VolatilityWarningCatalogStock> savedCatalog);
}
