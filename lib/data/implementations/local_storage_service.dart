import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i_local_storage_service.dart';

const String _boxName = "dtnd_hive_box";
const String appAccessTimeKey = "appAccessTimeKey";
const String savedUserTokenBoxKey = "savedUserTokenBoxName";
const String savedAllListStockBoxKey = "savedAllListStock";
const String savedInterestedStocksBoxKey = "savedInterestedStocksBoxKey";

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
    box = await Hive.openBox(_boxName);
    _appAccessTime = box.get(appAccessTimeKey) ?? 1;
    box.put(appAccessTimeKey, _appAccessTime);
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
}