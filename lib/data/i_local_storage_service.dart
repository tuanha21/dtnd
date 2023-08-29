import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorageService {
  int get appAccessTime;

  Box get box;

  LocalAuthentication get localAuthentication;

  SharedPreferences get sharedPreferences;

  bool get isDeviceSupport;

  bool get biometricsRegistered;

  String get usernameRegistered;

  String get passwordRegistered;

  Future<void> init();

  List<Stock>? getSavedListAllStock();

  Stock? geStock(String code);

  UserToken? getSavedUserToken();

  Future<void> saveUserToken(UserToken token, String password);

  List<String>? getListInterestedStock();

  SavedCatalog getSavedCatalog(String user);

  Future<void> putSavedCatalog(SavedCatalog savedCatalog);

  Future<void> openSavedVAPortfolioBox();

  Future<void> closeSavedVAPortfolioBox();

  VAPortfolio getSavedVAPortfolio(String user);

  Future<void> putVAPortfolio(String user, VAPortfolio portfolio);

  Future<bool> biometricsValidate();

  Future<void> registerBiometrics();

  Future<void> cancelBiometrics();

  Future<void> saveInfoRegistered(String infoRegistered);

  Future<void> savePinCode(String pinCode);
}
