import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Future<void> init();

  List<Stock>? getSavedListAllStock();

  UserToken? getSavedUserToken();

  List<String>? getListInterestedStock();

  Future<Box<E>> getBox<E>(String boxName);
}
