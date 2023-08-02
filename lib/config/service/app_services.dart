import 'package:dtnd/=models=/ui_model/exception.dart';
import 'package:dtnd/config/helper/app_service_helper.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import '../../=models=/response/banner_model.dart';

extension ThemeModeX on ThemeMode {
  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;
}

class AppService {
  AppService._internal();

  static final AppService _instance = AppService._internal();

  static AppService get instance => _instance;

  late final SharedPreferences sharedPreferencesInstance;

  late final String appVersion;

  late final RxMap<String, dynamic> appConfig;

  late final Rx<ThemeMode> _themeMode;

  late final Rx<Locale> _locale;

  Rx<ThemeMode> get themeMode => _themeMode;

  Rx<Locale> get locale => _locale;

  factory AppService() => _instance;

  final RxList<DataBanner>? homeBanner = RxList();

  final Rx<bool> loadingHomBanner = false.obs;

  Future<void> initialize(SharedPreferences sharedPreferences) async {
    sharedPreferencesInstance = sharedPreferences;
    final themeMode = sharedPreferencesInstance.getString("ThemeMode");
    print("themeMode $themeMode");
    _themeMode = Rx<ThemeMode>(ThemeMode.light);
    if (themeMode == null) {
      await sharedPreferencesInstance.setString(
          "ThemeMode", ThemeMode.dark.name);
      _themeMode = Rx<ThemeMode>(ThemeMode.light);
    } else {
      // _themeMode = Rx<ThemeMode>(ThemeModeHelper.fromString(themeMode));
    }

    final languageCode = sharedPreferencesInstance.getString("Locale");
    if (languageCode == null) {
      await sharedPreferencesInstance.setString("Locale", "vi");
      _locale = Rx<Locale>(const Locale("vi", "VN"));
    } else {
      _locale = Rx<Locale>(LocaleHelper.fromLanguageCode(languageCode));
    }
  }

  ThemeMode get currentTheme => themeMode.value;

  /// change [ThemeMode] and return [ThemeMode] after change
  Future<ThemeMode> switchTheme() async {
    return _changeThemeMode(themeMode.value.switcher);
  }

  /// change [Locale] and return [Locale] after change
  Future<Locale> switchLanguage() async {
    return _changeLanguage(locale.value.next);
  }

  Future<ThemeMode> _changeThemeMode(ThemeMode themeMode) async {
    _themeMode.value = themeMode;
    print(themeMode.name);
    await sharedPreferencesInstance.setString("ThemeMode", themeMode.name);
    final getThemeMode = sharedPreferencesInstance.getString("ThemeMode");
    print("getThemeMode $getThemeMode");
    return themeMode;
  }

  Future<Locale> _changeLanguage(Locale locale) async {
    _locale.value = locale;
    await S.load(locale);
    return locale;
  }

  Future<List<DataBanner>?> getHomeBanner(
      INetworkService networkService) async {
    if (loadingHomBanner.value) {
      await 1.delay();
      return getHomeBanner(networkService);
    }
    loadingHomBanner.value = true;
    var res = await networkService.getHomeBanner();
    if (res != null) {
      homeBanner?.value = res;
      loadingHomBanner.value = false;
      return homeBanner;
    } else {
      loadingHomBanner.value = false;
      throw Exception();
    }
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    logger.v(appVersion);
    return appVersion;
  }

  Future<bool?> checkForUpdate(INetworkService networkService) async {
    final List<String> appVersionList;
    final List<String> miniumAppVersionList;
    final List<String> storeAppVersionList;

    try {
      appVersionList = (await _getAppVersion()).split(".");
    } catch (e) {
      throw const SomethingWentWrongException();
    }

    final Map<String, dynamic> appCfg = await networkService.getAppConfig();
    // final Map<String, dynamic> storeList = await networkService.getAppConfig();
    logger.v(appCfg);

    if (appCfg["current_version"] == null ||
        appCfg["minimum_version"] == null) {
      throw const NoInternetException();
    } else {
      appConfig = RxMap<String, dynamic>(appCfg);
      logger.v(
          "App version: ${appVersionList.join('.')}\nStore version: ${appCfg["current_version"]}\nMinimum version: ${appCfg["minimum_version"]}");
      try {
        miniumAppVersionList = appCfg["minimum_version"].split(".");
        storeAppVersionList = appCfg["current_version"].split(".");
        // storeAppVersionList = ["1", "0", "2"];
      } catch (e) {
        throw const SomethingWentWrongException();
      }
    }

    for (var i = 0; i < 3; i++) {
      if (int.parse(appVersionList.elementAt(i)) <
          int.parse(miniumAppVersionList.elementAt(i))) {
        return true;
      } else if (int.parse(appVersionList.elementAt(i)) <
          int.parse(storeAppVersionList.elementAt(i))) {
        return false;
      }
    }
    return null;
  }

  String get storeUrl {
    if (Platform.isAndroid) {
      return appConfig["playstore_url"];
    }
    if (Platform.isIOS) {
      return appConfig["appstore_url"];
    }
    throw UnimplementedError();
  }
}
