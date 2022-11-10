import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/logic/x_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  return ThemeModeNotifier();
});

final appLocaleProvider =
    StateNotifierProvider<LocaleNotifier, AppLocale>((ref) {
  return LocaleNotifier();
});

class AppThemeMode extends Equatable {
  final XStatus status;
  final ThemeMode data;
  final String? errorMsg;

  const AppThemeMode({
    this.status = XStatus.initializing,
    required this.data,
    this.errorMsg,
  });
  @override
  List<Object?> get props => [status, data, errorMsg];
}

class AppLocale extends Equatable {
  final XStatus status;
  final Locale data;
  final String? errorMsg;

  const AppLocale({
    this.status = XStatus.initializing,
    required this.data,
    this.errorMsg,
  });
  @override
  List<Object?> get props => [status, data, errorMsg];
}

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  late final AppService _appService;
  ThemeModeNotifier()
      : _appService = AppService(),
        super(AppThemeMode(data: AppService().themeMode));

  Future<void> switchTheme() async {
    final currentThemeMode = await _appService.switchTheme();
    state = AppThemeMode(status: XStatus.success, data: currentThemeMode);
  }
}

class LocaleNotifier extends StateNotifier<AppLocale> {
  late final AppService _appService;
  LocaleNotifier()
      : _appService = AppService(),
        super(AppLocale(data: AppService().locale));

  Future<void> switchLanguage() async {
    final currentLocale = await _appService.switchLanguage();
    state = AppLocale(status: XStatus.success, data: currentLocale);
  }
}
