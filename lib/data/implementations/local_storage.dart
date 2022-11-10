import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i_local_storage_service.dart';

class LocalStorage implements ILocalStorageService {
  static const String boxName = "dtnd_box";
  late final SharedPreferences sharedPreferences;
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }
}
