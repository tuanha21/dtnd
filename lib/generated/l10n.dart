// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login_upper {
    return Intl.message(
      'LOGIN',
      name: 'login_upper',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Market`
  String get market {
    return Intl.message(
      'Market',
      name: 'market',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Bond`
  String get bond {
    return Intl.message(
      'Bond',
      name: 'bond',
      desc: '',
      args: [],
    );
  }

  /// `Asset`
  String get asset {
    return Intl.message(
      'Asset',
      name: 'asset',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Cash deposits`
  String get qa_money {
    return Intl.message(
      'Cash deposits',
      name: 'qa_money',
      desc: '',
      args: [],
    );
  }

  /// `Base`
  String get qa_base {
    return Intl.message(
      'Base',
      name: 'qa_base',
      desc: '',
      args: [],
    );
  }

  /// `Derivative`
  String get qa_derivative {
    return Intl.message(
      'Derivative',
      name: 'qa_derivative',
      desc: '',
      args: [],
    );
  }

  /// `Pack enrollment`
  String get qa_pack_enrol {
    return Intl.message(
      'Pack enrollment',
      name: 'qa_pack_enrol',
      desc: '',
      args: [],
    );
  }

  /// `Bond`
  String get qa_bond {
    return Intl.message(
      'Bond',
      name: 'qa_bond',
      desc: '',
      args: [],
    );
  }

  /// `Copytrade`
  String get qa_copytrade {
    return Intl.message(
      'Copytrade',
      name: 'qa_copytrade',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Fill account`
  String get fill_account {
    return Intl.message(
      'Fill account',
      name: 'fill_account',
      desc: '',
      args: [],
    );
  }

  /// `Fill password`
  String get fill_password {
    return Intl.message(
      'Fill password',
      name: 'fill_password',
      desc: '',
      args: [],
    );
  }

  /// `Fill OTP`
  String get fill_OTP {
    return Intl.message(
      'Fill OTP',
      name: 'fill_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Session expired in `
  String get session_expired_in {
    return Intl.message(
      'Session expired in ',
      name: 'session_expired_in',
      desc: '',
      args: [],
    );
  }

  /// ` minutes`
  String get minutes {
    return Intl.message(
      ' minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Back again to exit`
  String get double_back_to_close_app {
    return Intl.message(
      'Back again to exit',
      name: 'double_back_to_close_app',
      desc: '',
      args: [],
    );
  }

  /// `Total asset`
  String get total_asset {
    return Intl.message(
      'Total asset',
      name: 'total_asset',
      desc: '',
      args: [],
    );
  }

  /// `Interested catalog`
  String get interested_catalog {
    return Intl.message(
      'Interested catalog',
      name: 'interested_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Market today`
  String get market_today {
    return Intl.message(
      'Market today',
      name: 'market_today',
      desc: '',
      args: [],
    );
  }

  /// `Market overview`
  String get market_overview {
    return Intl.message(
      'Market overview',
      name: 'market_overview',
      desc: '',
      args: [],
    );
  }

  /// `Login with OTP code sent to your phone`
  String get login_exception_required_OTP {
    return Intl.message(
      'Login with OTP code sent to your phone',
      name: 'login_exception_required_OTP',
      desc: '',
      args: [],
    );
  }

  /// `This account has not been registered or Internet trading feature is no longer available`
  String get invalid_account {
    return Intl.message(
      'This account has not been registered or Internet trading feature is no longer available',
      name: 'invalid_account',
      desc: '',
      args: [],
    );
  }

  /// `Username requires at least 6 characters`
  String get null_username {
    return Intl.message(
      'Username requires at least 6 characters',
      name: 'null_username',
      desc: '',
      args: [],
    );
  }

  /// `Password requires at least 8 characters`
  String get null_password {
    return Intl.message(
      'Password requires at least 8 characters',
      name: 'null_password',
      desc: '',
      args: [],
    );
  }

  /// `Password is incorrect`
  String get wrong_password {
    return Intl.message(
      'Password is incorrect',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Let's join the exciting investment market with `
  String get login_qoute1 {
    return Intl.message(
      'Let\'s join the exciting investment market with ',
      name: 'login_qoute1',
      desc: '',
      args: [],
    );
  }

  /// ` application`
  String get login_qoute2 {
    return Intl.message(
      ' application',
      name: 'login_qoute2',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get see_more {
    return Intl.message(
      'See more',
      name: 'see_more',
      desc: '',
      args: [],
    );
  }

  /// `No response from server`
  String get timeout {
    return Intl.message(
      'No response from server',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection`
  String get no_internet {
    return Intl.message(
      'No Internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
