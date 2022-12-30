import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/local/user_catalog.dart';
import 'package:dtnd/=models=/local/volatility_warning_catalog.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i_local_storage_service.dart';

const String _boxName = "dtnd_hive_box";
const String appAccessTimeKey = "appAccessTimeKey";
const String savedUserTokenBoxKey = "savedUserTokenBoxKey";
const String savedAllListStockBoxKey = "savedAllListStock";
const String savedInterestedStocksBoxKey = "savedInterestedStocksBoxKey";
const String listSavedCatalogKey = "listSavedCatalogKey";

class LocalStorageService implements ILocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _instance = LocalStorageService._internal();

  static LocalStorageService get instance => _instance;

  factory LocalStorageService() => _instance;

  late final SharedPreferences sharedPreferences;
  late final Box box;

  /// Local Storage data

  late final int _appAccessTime;

  // late final UserToken? savedUserToken;

  // late final List<Stock>? listAllStock;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    sharedPreferences = await SharedPreferences.getInstance();

    Hive.registerAdapter(UserTokenAdapter());
    Hive.registerAdapter(ExchangeAdapter());
    Hive.registerAdapter(StockAdapter());
    Hive.registerAdapter(SavedCatalogAdapter());
    Hive.registerAdapter(UserCatalogAdapter());
    Hive.registerAdapter(VolatilityWarningFigureTypeAdapter());
    Hive.registerAdapter(VolatilityWarningFigureAdapter());
    Hive.registerAdapter(VolatilityWarningCatalogAdapter());
    Hive.registerAdapter(VolatilityWarningCatalogStockAdapter());

    box = await getBox(_boxName);
    _appAccessTime = box.get(appAccessTimeKey) ?? 0;
    box.put(appAccessTimeKey, _appAccessTime + 1);
    // savedUserToken = box.get(_savedUserTokenBoxName);
    // listAllStock = box.get(_savedAllListStock);
  }

  @override
  int get appAccessTime => _appAccessTime;

  @override
  UserToken? getSavedUserToken() {
    return box.get(savedUserTokenBoxKey);
  }

  @override
  List<Stock>? getSavedListAllStock() {
    return box.get(savedAllListStockBoxKey);
  }

  @override
  List<String>? getListInterestedStock() {
    return box.get(savedInterestedStocksBoxKey);
  }

  @override
  Future<Box<E>> getBox<E>(String boxName) {
    return Hive.openBox(boxName);
  }

  @override
  Future<void> saveUserToken(UserToken token) {
    return box.put(savedUserTokenBoxKey, token);
  }

  // void createDefault(SavedCatalog savedCatalog) {
  //   savedCatalog.catalogs.add(UserCatalog("Default catalog", defaultListStock));
  //   savedCatalog.catalogs.addAll(defaultListStock);
  //   savedCatalog.save();
  //   return;
  // }

  @override
  Future<SavedCatalog<String>?> getSavedCatalog(String user) async {
    try {
      return box.get("${user}_saved_catalog");
    } catch (e) {
      return null;
    }
    // final SavedCatalog? savedCatalog = box.get("${user}_saved_catalog");
    // if (savedCatalog == null) {
    //   final SavedCatalog newSavedCatalog = SavedCatalog(user);
    //   createDefault(newSavedCatalog);
    //   await box.put("${user}_saved_catalog", newSavedCatalog);
    //   return newSavedCatalog;
    // }
    // if (savedCatalog.catalogs.isEmpty) {
    //   createDefault(savedCatalog);
    // }
    // return savedCatalog;
  }

  @override
  Future<void> putSavedCatalog(SavedCatalog savedCatalog) {
    return box.put("${savedCatalog.user}_saved_catalog", savedCatalog);
  }

  @override
  Future<SavedCatalog<VolatilityWarningCatalogStock>?>
      getSavedVolatilityWarningCatalog(String user) async {
    try {
      return box.get("${user}_saved_volatility_warning_catalog");
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> putSavedVolatilityWarningCatalog(SavedCatalog savedCatalog) {
    return box.put(
        "${savedCatalog.user}_saved_volatility_warning_catalog", savedCatalog);
  }
}
