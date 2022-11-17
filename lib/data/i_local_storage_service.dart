import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Future<void> init();

  List<Stock>? getSavedListAllStock();

  UserToken? getSavedUserToken();

  List<String>? getListInterestedStock();
}
