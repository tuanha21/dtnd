import 'package:dtnd/=models=/response/user_token.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_local_storage_service.dart';

const String _boxName = "dtnd_hive_box";
const String _savedUserTokenBoxName = "savedUserTokenBoxName";

class LocalStorageService implements ILocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _instance = LocalStorageService._internal();

  static LocalStorageService get instance => _instance;

  factory LocalStorageService() {
    return _instance;
  }

  late final SharedPreferences sharedPreferences;

  late final Box box;

  /// Local Storage data

  late final UserToken? savedUserToken;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    sharedPreferences = await SharedPreferences.getInstance();

    Hive.registerAdapter(UserTokenAdapter());
    box = await Hive.openBox(_boxName);
    savedUserToken = box.get(_savedUserTokenBoxName);
  }
}
