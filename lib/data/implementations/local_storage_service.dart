import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/user_catalog.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/ui_model/exception.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:shared_preferences/shared_preferences.dart';

import '../i_local_storage_service.dart';

const String _boxName = "dtnd_hive_box";
const String _vaBox = "va_box";
const String appAccessTimeKey = "appAccessTimeKey";
const String savedUserTokenBoxKey = "savedUserTokenBoxKey";
const String savedAllListStockBoxKey = "savedAllListStock";
const String savedInterestedStocksBoxKey = "savedInterestedStocksBoxKey";
const String listSavedCatalogKey = "listSavedCatalogKey";

const String regBioKey = "regBioKey";
const String usernameKey = "usernameKey";
const String passwordKey = "passwordKey";
const String infoRegisteredKey = "infoRegistered";

class LocalStorageService implements ILocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _instance = LocalStorageService._internal();

  static LocalStorageService get instance => _instance;

  factory LocalStorageService() => _instance;

  late final SharedPreferences _sharedPreferences;
  late final Box _box;

  late final LocalAuthentication _localAuthentication;

  @override
  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  Box get box => _box;

  Box<VAPortfolio>? vaBox;

  @override
  LocalAuthentication get localAuthentication => _localAuthentication;
  @override
  late final bool isDeviceSupport;

  @override
  bool get biometricsRegistered =>
      sharedPreferences.getBool(regBioKey) ?? false;

  @override
  String get usernameRegistered {
    if (!biometricsRegistered) {
      throw Exception();
    }
    return sharedPreferences.getString(usernameKey)!;
  }

  @override
  String get passwordRegistered {
    if (!biometricsRegistered) {
      throw Exception();
    }
    return sharedPreferences.getString(passwordKey)!;
  }

  late final int _appAccessTime;

  // late final UserToken? savedUserToken;

  // late final List<Stock>? listAllStock;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _sharedPreferences = await SharedPreferences.getInstance();
    _localAuthentication = LocalAuthentication();
    isDeviceSupport = await _localAuthentication.canCheckBiometrics ||
        await _localAuthentication.isDeviceSupported();
    Hive.registerAdapter(UserTokenAdapter());
    Hive.registerAdapter(ExchangeAdapter());
    Hive.registerAdapter(StockAdapter());
    Hive.registerAdapter(SavedCatalogAdapter());
    Hive.registerAdapter(UserCatalogAdapter());
    Hive.registerAdapter(VAPortfolioAdapter());
    Hive.registerAdapter(VAPortfolioItemAdapter());
    Hive.registerAdapter(VAPortfolioSettingAdapter());

    _box = await Hive.openBox(_boxName);

    _appAccessTime = _box.get(appAccessTimeKey) ?? 0;
    _box.put(appAccessTimeKey, _appAccessTime + 1);
    // savedUserToken = box.get(_savedUserTokenBoxName);
    // listAllStock = box.get(_savedAllListStock);
  }

  @override
  int get appAccessTime => _appAccessTime;

  @override
  UserToken? getSavedUserToken() {
    return _box.get(savedUserTokenBoxKey);
  }

  @override
  List<Stock>? getSavedListAllStock() {
    return _box.get(savedAllListStockBoxKey);
  }

  @override
  List<String>? getListInterestedStock() {
    return _box.get(savedInterestedStocksBoxKey);
  }

  @override
  Future<void> saveUserToken(UserToken token, String password) {
    sharedPreferences.setString(usernameKey, token.user);
    sharedPreferences.setString(passwordKey, password);
    return _box.put(savedUserTokenBoxKey, token);
  }

  // void createDefault(SavedCatalog savedCatalog) {
  //   savedCatalog.catalogs.add(UserCatalog("Default catalog", defaultListStock));
  //   savedCatalog.catalogs.addAll(defaultListStock);
  //   savedCatalog.save();
  //   return;
  // }

  @override
  SavedCatalog getSavedCatalog(String user) {
    if (_box.containsKey("saved_catalog_$user")) {
      return _box.get("saved_catalog_$user");
    }
    return SavedCatalog(user, catalogs: []);
  }

  @override
  Future<void> putSavedCatalog(SavedCatalog savedCatalog) {
    print("put");
    return _box.put("saved_catalog_${savedCatalog.user}", savedCatalog);
  }

  @override
  Future<void> openSavedVAPortfolioBox() async {
    if (vaBox != null) {
      return;
    }
    vaBox = await Hive.openBox<VAPortfolio>(_vaBox);
    return;
  }

  @override
  Future<void> closeSavedVAPortfolioBox() async {
    if (vaBox == null) {
      return;
    }
    await vaBox!.close();
    vaBox = null;
  }

  @override
  VAPortfolio getSavedVAPortfolio(String user) {
    if (vaBox == null) {
      throw const BoxNotOpenedException();
    }
    try {
      return vaBox!.get("va_box_$user")!;
    } catch (e) {
      throw const BotNotExistedException();
    }
  }

  @override
  Future<void> putVAPortfolio(String user, VAPortfolio portfolio) async {
    if (vaBox == null) {
      await openSavedVAPortfolioBox();
      return putVAPortfolio(user, portfolio);
    }
    await vaBox!.put("va_box_$user", portfolio);
    return;
  }

  @override
  Stock? geStock(String code) {
    throw UnimplementedError();
  }

  @override
  Future<bool> biometricsValidate() async {
    if (isDeviceSupport) {
      final List<BiometricType> availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      logger.v(availableBiometrics);
      if (availableBiometrics.isEmpty) {
        throw Exception();
      }
      try {
        final bool didAuthenticate = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to register',
        );
        return didAuthenticate;
        // ···
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
        } else if (e.code == auth_error.notEnrolled) {
          // ...
        } else {
          // ...
        }
        logger.e(e);
        rethrow;
      }

      // if (availableBiometrics.contains(BiometricType.strong) ||
      //     availableBiometrics.contains(BiometricType.face)) {
      //   // Specific types of biometrics are available.
      //   // Use checks like this with caution!
      // }
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> registerBiometrics() =>
      sharedPreferences.setBool(regBioKey, true);

  @override
  Future<void> cancelBiometrics() =>
      sharedPreferences.setBool(regBioKey, false);

  @override
  Future<void> saveInfoRegistered(String infoRegistered) async {
    sharedPreferences.setString(infoRegisteredKey, infoRegistered);
  }
}
