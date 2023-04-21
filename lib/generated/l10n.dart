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

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
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

  /// `Login with Google`
  String get login_with_google {
    return Intl.message(
      'Login with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get login_with_facebook {
    return Intl.message(
      'Login with Facebook',
      name: 'login_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Hi you`
  String get hi_you {
    return Intl.message(
      'Hi you',
      name: 'hi_you',
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

  /// `Custom`
  String get qa_custom {
    return Intl.message(
      'Custom',
      name: 'qa_custom',
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

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
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

  /// `Create account`
  String get create_account {
    return Intl.message(
      'Create account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Create catalog`
  String get create_catalog {
    return Intl.message(
      'Create catalog',
      name: 'create_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Order note`
  String get order_note {
    return Intl.message(
      'Order note',
      name: 'order_note',
      desc: '',
      args: [],
    );
  }

  /// `Order history`
  String get order_htr {
    return Intl.message(
      'Order history',
      name: 'order_htr',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message(
      'Bank',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Accumulate`
  String get accumulate {
    return Intl.message(
      'Accumulate',
      name: 'accumulate',
      desc: '',
      args: [],
    );
  }

  /// `Opening`
  String get status_open {
    return Intl.message(
      'Opening',
      name: 'status_open',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get status_close {
    return Intl.message(
      'Closed',
      name: 'status_close',
      desc: '',
      args: [],
    );
  }

  /// `Intermission`
  String get status_intermission {
    return Intl.message(
      'Intermission',
      name: 'status_intermission',
      desc: '',
      args: [],
    );
  }

  /// `Input password`
  String get please_input_password {
    return Intl.message(
      'Input password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Password not match`
  String get pass_not_match {
    return Intl.message(
      'Password not match',
      name: 'pass_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Ceil`
  String get ceil {
    return Intl.message(
      'Ceil',
      name: 'ceil',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floor {
    return Intl.message(
      'Floor',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `Ref`
  String get ref {
    return Intl.message(
      'Ref',
      name: 'ref',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Average`
  String get average {
    return Intl.message(
      'Average',
      name: 'average',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `FR buy`
  String get fbuy {
    return Intl.message(
      'FR buy',
      name: 'fbuy',
      desc: '',
      args: [],
    );
  }

  /// `Room FR`
  String get froom {
    return Intl.message(
      'Room FR',
      name: 'froom',
      desc: '',
      args: [],
    );
  }

  /// `FR sell`
  String get fsell {
    return Intl.message(
      'FR sell',
      name: 'fsell',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get buy_short {
    return Intl.message(
      'B',
      name: 'buy_short',
      desc: '',
      args: [],
    );
  }

  /// `Buy price`
  String get buy_price {
    return Intl.message(
      'Buy price',
      name: 'buy_price',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `S`
  String get sell_short {
    return Intl.message(
      'S',
      name: 'sell_short',
      desc: '',
      args: [],
    );
  }

  /// `Sell price`
  String get sell_price {
    return Intl.message(
      'Sell price',
      name: 'sell_price',
      desc: '',
      args: [],
    );
  }

  /// `Accumulation`
  String get accumulation {
    return Intl.message(
      'Accumulation',
      name: 'accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volumn {
    return Intl.message(
      'Volume',
      name: 'volumn',
      desc: '',
      args: [],
    );
  }

  /// `Dividend`
  String get dividend {
    return Intl.message(
      'Dividend',
      name: 'dividend',
      desc: '',
      args: [],
    );
  }

  /// `Total {value}`
  String total_wvalue(Object value) {
    return Intl.message(
      'Total $value',
      name: 'total_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Gain {value}`
  String gain_wvalue(Object value) {
    return Intl.message(
      'Gain $value',
      name: 'gain_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Loss {value}`
  String loss_wvalue(Object value) {
    return Intl.message(
      'Loss $value',
      name: 'loss_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Net assets`
  String get net_assets {
    return Intl.message(
      'Net assets',
      name: 'net_assets',
      desc: '',
      args: [],
    );
  }

  /// `Net profit`
  String get net_profit {
    return Intl.message(
      'Net profit',
      name: 'net_profit',
      desc: '',
      args: [],
    );
  }

  /// `Total cash`
  String get total_cash {
    return Intl.message(
      'Total cash',
      name: 'total_cash',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get revenue {
    return Intl.message(
      'Revenue',
      name: 'revenue',
      desc: '',
      args: [],
    );
  }

  /// `Investment value`
  String get investment_value {
    return Intl.message(
      'Investment value',
      name: 'investment_value',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Returning money`
  String get returning_money {
    return Intl.message(
      'Returning money',
      name: 'returning_money',
      desc: '',
      args: [],
    );
  }

  /// `Sold returning money`
  String get sold_returning_money {
    return Intl.message(
      'Sold returning money',
      name: 'sold_returning_money',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawable money`
  String get withdrawable_money {
    return Intl.message(
      'Withdrawable money',
      name: 'withdrawable_money',
      desc: '',
      args: [],
    );
  }

  /// `Total debt`
  String get total_debt {
    return Intl.message(
      'Total debt',
      name: 'total_debt',
      desc: '',
      args: [],
    );
  }

  /// `Total principal debt`
  String get total_principal_debt {
    return Intl.message(
      'Total principal debt',
      name: 'total_principal_debt',
      desc: '',
      args: [],
    );
  }

  /// `Safe ratio`
  String get safe_ratio {
    return Intl.message(
      'Safe ratio',
      name: 'safe_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Cash dividends`
  String get cash_dividends {
    return Intl.message(
      'Cash dividends',
      name: 'cash_dividends',
      desc: '',
      args: [],
    );
  }

  /// `Capital value`
  String get capital_value {
    return Intl.message(
      'Capital value',
      name: 'capital_value',
      desc: '',
      args: [],
    );
  }

  /// `Stock value`
  String get stock_value {
    return Intl.message(
      'Stock value',
      name: 'stock_value',
      desc: '',
      args: [],
    );
  }

  /// `MK value`
  String get mk_value {
    return Intl.message(
      'MK value',
      name: 'mk_value',
      desc: '',
      args: [],
    );
  }

  /// `MK price`
  String get mk_price {
    return Intl.message(
      'MK price',
      name: 'mk_price',
      desc: '',
      args: [],
    );
  }

  /// `Available balanc`
  String get available_balanc {
    return Intl.message(
      'Available balanc',
      name: 'available_balanc',
      desc: '',
      args: [],
    );
  }

  /// `Total vol`
  String get total_vol {
    return Intl.message(
      'Total vol',
      name: 'total_vol',
      desc: '',
      args: [],
    );
  }

  /// `Normal vol`
  String get normal_vol {
    return Intl.message(
      'Normal vol',
      name: 'normal_vol',
      desc: '',
      args: [],
    );
  }

  /// `FS vol`
  String get fs_vol {
    return Intl.message(
      'FS vol',
      name: 'fs_vol',
      desc: '',
      args: [],
    );
  }

  /// `Available vol`
  String get available_vol {
    return Intl.message(
      'Available vol',
      name: 'available_vol',
      desc: '',
      args: [],
    );
  }

  /// `Other vol`
  String get other_vol {
    return Intl.message(
      'Other vol',
      name: 'other_vol',
      desc: '',
      args: [],
    );
  }

  /// `Sold returning`
  String get sold_returning {
    return Intl.message(
      'Sold returning',
      name: 'sold_returning',
      desc: '',
      args: [],
    );
  }

  /// `Sold returning vol`
  String get sold_returning_vol {
    return Intl.message(
      'Sold returning vol',
      name: 'sold_returning_vol',
      desc: '',
      args: [],
    );
  }

  /// `Sold vol`
  String get sold_vol {
    return Intl.message(
      'Sold vol',
      name: 'sold_vol',
      desc: '',
      args: [],
    );
  }

  /// `Selling price`
  String get selling_price {
    return Intl.message(
      'Selling price',
      name: 'selling_price',
      desc: '',
      args: [],
    );
  }

  /// `Bought returning`
  String get bought_returning {
    return Intl.message(
      'Bought returning',
      name: 'bought_returning',
      desc: '',
      args: [],
    );
  }

  /// `Bought returning vol`
  String get bought_returning_vol {
    return Intl.message(
      'Bought returning vol',
      name: 'bought_returning_vol',
      desc: '',
      args: [],
    );
  }

  /// `Extension`
  String get extension {
    return Intl.message(
      'Extension',
      name: 'extension',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Base note`
  String get base_note {
    return Intl.message(
      'Base note',
      name: 'base_note',
      desc: '',
      args: [],
    );
  }

  /// `Inday note`
  String get inday_note {
    return Intl.message(
      'Inday note',
      name: 'inday_note',
      desc: '',
      args: [],
    );
  }

  /// `Conditional note`
  String get conditional_note {
    return Intl.message(
      'Conditional note',
      name: 'conditional_note',
      desc: '',
      args: [],
    );
  }

  /// `Debt following`
  String get debt_following {
    return Intl.message(
      'Debt following',
      name: 'debt_following',
      desc: '',
      args: [],
    );
  }

  /// `Profit/Loss`
  String get profit_and_loss {
    return Intl.message(
      'Profit/Loss',
      name: 'profit_and_loss',
      desc: '',
      args: [],
    );
  }

  /// `Executed profit/Loss`
  String get executed_profit_and_loss {
    return Intl.message(
      'Executed profit/Loss',
      name: 'executed_profit_and_loss',
      desc: '',
      args: [],
    );
  }

  /// `Margin debt`
  String get margin_debt {
    return Intl.message(
      'Margin debt',
      name: 'margin_debt',
      desc: '',
      args: [],
    );
  }

  /// `Inday ordernote`
  String get inday_ordnote {
    return Intl.message(
      'Inday ordernote',
      name: 'inday_ordnote',
      desc: '',
      args: [],
    );
  }

  /// `Condition ordernote`
  String get condition_ordnote {
    return Intl.message(
      'Condition ordernote',
      name: 'condition_ordnote',
      desc: '',
      args: [],
    );
  }

  /// `Order history`
  String get order_history {
    return Intl.message(
      'Order history',
      name: 'order_history',
      desc: '',
      args: [],
    );
  }

  /// `Margin`
  String get margin {
    return Intl.message(
      'Margin',
      name: 'margin',
      desc: '',
      args: [],
    );
  }

  /// `Order price`
  String get order_price {
    return Intl.message(
      'Order price',
      name: 'order_price',
      desc: '',
      args: [],
    );
  }

  /// `Matched price`
  String get match_price {
    return Intl.message(
      'Matched price',
      name: 'match_price',
      desc: '',
      args: [],
    );
  }

  /// `Match vol`
  String get match_vol {
    return Intl.message(
      'Match vol',
      name: 'match_vol',
      desc: '',
      args: [],
    );
  }

  /// `Minimum purchasing power`
  String get minimum_ee {
    return Intl.message(
      'Minimum purchasing power',
      name: 'minimum_ee',
      desc: '',
      args: [],
    );
  }

  /// `Purchasing ability`
  String get purchasing_ability {
    return Intl.message(
      'Purchasing ability',
      name: 'purchasing_ability',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Buy date`
  String get buy_date {
    return Intl.message(
      'Buy date',
      name: 'buy_date',
      desc: '',
      args: [],
    );
  }

  /// `Sell date`
  String get sell_date {
    return Intl.message(
      'Sell date',
      name: 'sell_date',
      desc: '',
      args: [],
    );
  }

  /// `From date`
  String get from_day {
    return Intl.message(
      'From date',
      name: 'from_day',
      desc: '',
      args: [],
    );
  }

  /// `To date`
  String get to_day {
    return Intl.message(
      'To date',
      name: 'to_day',
      desc: '',
      args: [],
    );
  }

  /// `Owned`
  String get owned {
    return Intl.message(
      'Owned',
      name: 'owned',
      desc: '',
      args: [],
    );
  }

  /// `Avg price`
  String get avg_price {
    return Intl.message(
      'Avg price',
      name: 'avg_price',
      desc: '',
      args: [],
    );
  }

  /// `Bonus share`
  String get bonus_sh {
    return Intl.message(
      'Bonus share',
      name: 'bonus_sh',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get maximum {
    return Intl.message(
      'Maximum',
      name: 'maximum',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get minimum {
    return Intl.message(
      'Minimum',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `Order value`
  String get order_value {
    return Intl.message(
      'Order value',
      name: 'order_value',
      desc: '',
      args: [],
    );
  }

  /// `Waiting match`
  String get waiting_match {
    return Intl.message(
      'Waiting match',
      name: 'waiting_match',
      desc: '',
      args: [],
    );
  }

  /// `Matched`
  String get matched {
    return Intl.message(
      'Matched',
      name: 'matched',
      desc: '',
      args: [],
    );
  }

  /// `Matching`
  String get matching {
    return Intl.message(
      'Matching',
      name: 'matching',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get million_short {
    return Intl.message(
      'M',
      name: 'million_short',
      desc: '',
      args: [],
    );
  }

  /// `Million`
  String get million {
    return Intl.message(
      'Million',
      name: 'million',
      desc: '',
      args: [],
    );
  }

  /// `million`
  String get million_lower {
    return Intl.message(
      'million',
      name: 'million_lower',
      desc: '',
      args: [],
    );
  }

  /// `K`
  String get thousand_short {
    return Intl.message(
      'K',
      name: 'thousand_short',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get billion_short {
    return Intl.message(
      'B',
      name: 'billion_short',
      desc: '',
      args: [],
    );
  }

  /// `b`
  String get billion_lowercase {
    return Intl.message(
      'b',
      name: 'billion_lowercase',
      desc: '',
      args: [],
    );
  }

  /// `Bil`
  String get billion {
    return Intl.message(
      'Bil',
      name: 'billion',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} minutes ago`
  String minutes_ago(Object minutes) {
    return Intl.message(
      '$minutes minutes ago',
      name: 'minutes_ago',
      desc: '',
      args: [minutes],
    );
  }

  /// `{hours} hours ago`
  String hours_ago(Object hours) {
    return Intl.message(
      '$hours hours ago',
      name: 'hours_ago',
      desc: '',
      args: [hours],
    );
  }

  /// `{days} days ago`
  String days_ago(Object days) {
    return Intl.message(
      '$days days ago',
      name: 'days_ago',
      desc: '',
      args: [days],
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

  /// `Base asset`
  String get base_asset {
    return Intl.message(
      'Base asset',
      name: 'base_asset',
      desc: '',
      args: [],
    );
  }

  /// `Derivative asset`
  String get derivative_asset {
    return Intl.message(
      'Derivative asset',
      name: 'derivative_asset',
      desc: '',
      args: [],
    );
  }

  /// `CopyTrade asset`
  String get copyTrade_asset {
    return Intl.message(
      'CopyTrade asset',
      name: 'copyTrade_asset',
      desc: '',
      args: [],
    );
  }

  /// `Asset distribution`
  String get asset_distribution {
    return Intl.message(
      'Asset distribution',
      name: 'asset_distribution',
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

  /// `Trading board`
  String get trading_board {
    return Intl.message(
      'Trading board',
      name: 'trading_board',
      desc: '',
      args: [],
    );
  }

  /// `Matched order detail`
  String get matched_order_detail {
    return Intl.message(
      'Matched order detail',
      name: 'matched_order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Financial index`
  String get financial_index {
    return Intl.message(
      'Financial index',
      name: 'financial_index',
      desc: '',
      args: [],
    );
  }

  /// `Index`
  String get index {
    return Intl.message(
      'Index',
      name: 'index',
      desc: '',
      args: [],
    );
  }

  /// `News and events`
  String get news_and_events {
    return Intl.message(
      'News and events',
      name: 'news_and_events',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Interested`
  String get interested {
    return Intl.message(
      'Interested',
      name: 'interested',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Analysis`
  String get analysis {
    return Intl.message(
      'Analysis',
      name: 'analysis',
      desc: '',
      args: [],
    );
  }

  /// `Industry`
  String get industry {
    return Intl.message(
      'Industry',
      name: 'industry',
      desc: '',
      args: [],
    );
  }

  /// `Industry list`
  String get industry_list {
    return Intl.message(
      'Industry list',
      name: 'industry_list',
      desc: '',
      args: [],
    );
  }

  /// `Market deep`
  String get market_deep {
    return Intl.message(
      'Market deep',
      name: 'market_deep',
      desc: '',
      args: [],
    );
  }

  /// `Add stock`
  String get add_stock {
    return Intl.message(
      'Add stock',
      name: 'add_stock',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get order_confirm {
    return Intl.message(
      'Confirm order',
      name: 'order_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Order type`
  String get order_type {
    return Intl.message(
      'Order type',
      name: 'order_type',
      desc: '',
      args: [],
    );
  }

  /// `Exchange total`
  String get exchange_total {
    return Intl.message(
      'Exchange total',
      name: 'exchange_total',
      desc: '',
      args: [],
    );
  }

  /// `Period of validity`
  String get period_of_validity {
    return Intl.message(
      'Period of validity',
      name: 'period_of_validity',
      desc: '',
      args: [],
    );
  }

  /// `Pin code`
  String get pin_code {
    return Intl.message(
      'Pin code',
      name: 'pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Matched order by time`
  String get matched_order_by_time {
    return Intl.message(
      'Matched order by time',
      name: 'matched_order_by_time',
      desc: '',
      args: [],
    );
  }

  /// `Matched order by price steps`
  String get matched_order_by_price_step {
    return Intl.message(
      'Matched order by price steps',
      name: 'matched_order_by_price_step',
      desc: '',
      args: [],
    );
  }

  /// `Search history`
  String get search_history {
    return Intl.message(
      'Search history',
      name: 'search_history',
      desc: '',
      args: [],
    );
  }

  /// `Top search`
  String get top_search {
    return Intl.message(
      'Top search',
      name: 'top_search',
      desc: '',
      args: [],
    );
  }

  /// `No matching results were found`
  String get no_matching_results_were_found {
    return Intl.message(
      'No matching results were found',
      name: 'no_matching_results_were_found',
      desc: '',
      args: [],
    );
  }

  /// `Try searching again with another keyword!`
  String get try_searching_again_with_another_keyword {
    return Intl.message(
      'Try searching again with another keyword!',
      name: 'try_searching_again_with_another_keyword',
      desc: '',
      args: [],
    );
  }

  /// `DTND assistant`
  String get DTND_assistant {
    return Intl.message(
      'DTND assistant',
      name: 'DTND_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Virtual assistant`
  String get virtual_assistant {
    return Intl.message(
      'Virtual assistant',
      name: 'virtual_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Virtual assistant available`
  String get virtual_assistant_available {
    return Intl.message(
      'Virtual assistant available',
      name: 'virtual_assistant_available',
      desc: '',
      args: [],
    );
  }

  /// `terms`
  String get term {
    return Intl.message(
      'terms',
      name: 'term',
      desc: '',
      args: [],
    );
  }

  /// `Agree with `
  String get agree_with {
    return Intl.message(
      'Agree with ',
      name: 'agree_with',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// ` of DTND's virtual assistant`
  String get DTNDs_virtual_assistant {
    return Intl.message(
      ' of DTND\'s virtual assistant',
      name: 'DTNDs_virtual_assistant',
      desc: '',
      args: [],
    );
  }

  /// `The OTP has been sent to your {value} extension email. Enter the 6-digit code to continue.`
  String otp_code_sent_to_phone_number(Object value) {
    return Intl.message(
      'The OTP has been sent to your $value extension email. Enter the 6-digit code to continue.',
      name: 'otp_code_sent_to_phone_number',
      desc: '',
      args: [value],
    );
  }

  /// `Create virtual assistant successfully`
  String get successfully_create_assistant_account {
    return Intl.message(
      'Create virtual assistant successfully',
      name: 'successfully_create_assistant_account',
      desc: '',
      args: [],
    );
  }

  /// `The DTND virtual assistant will help you with successful transaction`
  String
      get the_DTND_virtual_assistant_will_help_you_with_successful_transaction {
    return Intl.message(
      'The DTND virtual assistant will help you with successful transaction',
      name:
          'the_DTND_virtual_assistant_will_help_you_with_successful_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Stocks you are interested in`
  String get stocks_you_interested {
    return Intl.message(
      'Stocks you are interested in',
      name: 'stocks_you_interested',
      desc: '',
      args: [],
    );
  }

  /// `Select the stocks you are interested in. You can update later`
  String get choose_stocks_you_interested {
    return Intl.message(
      'Select the stocks you are interested in. You can update later',
      name: 'choose_stocks_you_interested',
      desc: '',
      args: [],
    );
  }

  /// `Following catalog`
  String get following_catalog {
    return Intl.message(
      'Following catalog',
      name: 'following_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Following catalog "{name}"`
  String following_catalog_with(Object name) {
    return Intl.message(
      'Following catalog "$name"',
      name: 'following_catalog_with',
      desc: '',
      args: [name],
    );
  }

  /// `Catalog is empty`
  String get empty_catalog {
    return Intl.message(
      'Catalog is empty',
      name: 'empty_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Add following stocks`
  String get add_following_stock {
    return Intl.message(
      'Add following stocks',
      name: 'add_following_stock',
      desc: '',
      args: [],
    );
  }

  /// `This stock is already exist`
  String get stock_already_exist {
    return Intl.message(
      'This stock is already exist',
      name: 'stock_already_exist',
      desc: '',
      args: [],
    );
  }

  /// `Something went erong`
  String get something_went_wrong {
    return Intl.message(
      'Something went erong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Session had been expired`
  String get session_had_been_expired {
    return Intl.message(
      'Session had been expired',
      name: 'session_had_been_expired',
      desc: '',
      args: [],
    );
  }

  /// `Search stock`
  String get search_stock {
    return Intl.message(
      'Search stock',
      name: 'search_stock',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filter stocks`
  String get filter_stock {
    return Intl.message(
      'Filter stocks',
      name: 'filter_stock',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Filter stocks figure`
  String get filter_stock_figure {
    return Intl.message(
      'Filter stocks figure',
      name: 'filter_stock_figure',
      desc: '',
      args: [],
    );
  }

  /// `Technical analysis`
  String get technical_analysis {
    return Intl.message(
      'Technical analysis',
      name: 'technical_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Matched vol`
  String get matched_vol {
    return Intl.message(
      'Matched vol',
      name: 'matched_vol',
      desc: '',
      args: [],
    );
  }

  /// `Matched price`
  String get matched_price {
    return Intl.message(
      'Matched price',
      name: 'matched_price',
      desc: '',
      args: [],
    );
  }

  /// `Vol analysis`
  String get vol_analysis {
    return Intl.message(
      'Vol analysis',
      name: 'vol_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Price alert`
  String get price_alert {
    return Intl.message(
      'Price alert',
      name: 'price_alert',
      desc: '',
      args: [],
    );
  }

  /// `Trading`
  String get trading {
    return Intl.message(
      'Trading',
      name: 'trading',
      desc: '',
      args: [],
    );
  }

  /// `Login required`
  String get login_required {
    return Intl.message(
      'Login required',
      name: 'login_required',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue`
  String get login_to_continue {
    return Intl.message(
      'Login to continue',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `You are not yet logged in`
  String get you_are_not_logged_in {
    return Intl.message(
      'You are not yet logged in',
      name: 'you_are_not_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `You are not account?`
  String get you_are_not_account {
    return Intl.message(
      'You are not account?',
      name: 'you_are_not_account',
      desc: '',
      args: [],
    );
  }

  /// `Login with another account`
  String get login_with_another_account {
    return Intl.message(
      'Login with another account',
      name: 'login_with_another_account',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_falied {
    return Intl.message(
      'Login failed',
      name: 'login_falied',
      desc: '',
      args: [],
    );
  }

  /// `Price increase`
  String get price_increase {
    return Intl.message(
      'Price increase',
      name: 'price_increase',
      desc: '',
      args: [],
    );
  }

  /// `Price decrease`
  String get price_decrease {
    return Intl.message(
      'Price decrease',
      name: 'price_decrease',
      desc: '',
      args: [],
    );
  }

  /// `Top foreign`
  String get top_foreign {
    return Intl.message(
      'Top foreign',
      name: 'top_foreign',
      desc: '',
      args: [],
    );
  }

  /// `Create new order`
  String get create_new_order {
    return Intl.message(
      'Create new order',
      name: 'create_new_order',
      desc: '',
      args: [],
    );
  }

  /// `Create order`
  String get stock_order {
    return Intl.message(
      'Create order',
      name: 'stock_order',
      desc: '',
      args: [],
    );
  }

  /// `Create order successfully`
  String get create_order_successfully {
    return Intl.message(
      'Create order successfully',
      name: 'create_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Change order successfully`
  String get change_order_successfully {
    return Intl.message(
      'Change order successfully',
      name: 'change_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order successfully`
  String get cancel_order_successfully {
    return Intl.message(
      'Cancel order successfully',
      name: 'cancel_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Create order failed`
  String get create_order_failed {
    return Intl.message(
      'Create order failed',
      name: 'create_order_failed',
      desc: '',
      args: [],
    );
  }

  /// `Order will appear in your order note`
  String get order_will_appear_in_ur_order_note {
    return Intl.message(
      'Order will appear in your order note',
      name: 'order_will_appear_in_ur_order_note',
      desc: '',
      args: [],
    );
  }

  /// `Volatility warning`
  String get volatility_warning {
    return Intl.message(
      'Volatility warning',
      name: 'volatility_warning',
      desc: '',
      args: [],
    );
  }

  /// `Volatility notice`
  String get volatility_notice {
    return Intl.message(
      'Volatility notice',
      name: 'volatility_notice',
      desc: '',
      args: [],
    );
  }

  /// `Account notice`
  String get account_notice {
    return Intl.message(
      'Account notice',
      name: 'account_notice',
      desc: '',
      args: [],
    );
  }

  /// `Catalog notice`
  String get catalog_notice {
    return Intl.message(
      'Catalog notice',
      name: 'catalog_notice',
      desc: '',
      args: [],
    );
  }

  /// `Set up fluctuations alerts for your account and interest catalogs`
  String get volatility_notice_quote1 {
    return Intl.message(
      'Set up fluctuations alerts for your account and interest catalogs',
      name: 'volatility_notice_quote1',
      desc: '',
      args: [],
    );
  }

  /// `Add catalog`
  String get add_catalog {
    return Intl.message(
      'Add catalog',
      name: 'add_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get right {
    return Intl.message(
      'Right',
      name: 'right',
      desc: '',
      args: [],
    );
  }

  /// `Catalog`
  String get catalog {
    return Intl.message(
      'Catalog',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Catalog name`
  String get catalog_name {
    return Intl.message(
      'Catalog name',
      name: 'catalog_name',
      desc: '',
      args: [],
    );
  }

  /// `Edit catalog name`
  String get edit_catalog_name {
    return Intl.message(
      'Edit catalog name',
      name: 'edit_catalog_name',
      desc: '',
      args: [],
    );
  }

  /// `Rename catalog “{name}” to`
  String rename_catalog_to(Object name) {
    return Intl.message(
      'Rename catalog “$name” to',
      name: 'rename_catalog_to',
      desc: '',
      args: [name],
    );
  }

  /// `Delete catalog`
  String get delete_catalog {
    return Intl.message(
      'Delete catalog',
      name: 'delete_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete the “{name}” category?`
  String are_you_sure_to_delete_catalog(Object name) {
    return Intl.message(
      'Are you sure to delete the “$name” category?',
      name: 'are_you_sure_to_delete_catalog',
      desc: '',
      args: [name],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Deposite money`
  String get deposite_money {
    return Intl.message(
      'Deposite money',
      name: 'deposite_money',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw money`
  String get withdraw_money {
    return Intl.message(
      'Withdraw money',
      name: 'withdraw_money',
      desc: '',
      args: [],
    );
  }

  /// `Base`
  String get base {
    return Intl.message(
      'Base',
      name: 'base',
      desc: '',
      args: [],
    );
  }

  /// `Derivative`
  String get derivative {
    return Intl.message(
      'Derivative',
      name: 'derivative',
      desc: '',
      args: [],
    );
  }

  /// `TD volatility`
  String get trading_volatility {
    return Intl.message(
      'TD volatility',
      name: 'trading_volatility',
      desc: '',
      args: [],
    );
  }

  /// `Stock trading`
  String get stock_trading {
    return Intl.message(
      'Stock trading',
      name: 'stock_trading',
      desc: '',
      args: [],
    );
  }

  /// `Money trading`
  String get money_trading {
    return Intl.message(
      'Money trading',
      name: 'money_trading',
      desc: '',
      args: [],
    );
  }

  /// `Account managing`
  String get account_managing {
    return Intl.message(
      'Account managing',
      name: 'account_managing',
      desc: '',
      args: [],
    );
  }

  /// `Help center`
  String get help_center {
    return Intl.message(
      'Help center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Setting and secutiry`
  String get setting_and_secutiry {
    return Intl.message(
      'Setting and secutiry',
      name: 'setting_and_secutiry',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Account information`
  String get account_infomation {
    return Intl.message(
      'Account information',
      name: 'account_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personal_infomation {
    return Intl.message(
      'Personal information',
      name: 'personal_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get account_number {
    return Intl.message(
      'Account number',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id_or_business_id_short {
    return Intl.message(
      'ID',
      name: 'id_or_business_id_short',
      desc: '',
      args: [],
    );
  }

  /// `Issue date`
  String get issue_date {
    return Intl.message(
      'Issue date',
      name: 'issue_date',
      desc: '',
      args: [],
    );
  }

  /// `Issue place`
  String get issue_place {
    return Intl.message(
      'Issue place',
      name: 'issue_place',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Sex`
  String get sex {
    return Intl.message(
      'Sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get contact_infomation {
    return Intl.message(
      'Contact information',
      name: 'contact_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Adrress`
  String get address {
    return Intl.message(
      'Adrress',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Business information`
  String get business_information {
    return Intl.message(
      'Business information',
      name: 'business_information',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get general_information {
    return Intl.message(
      'General information',
      name: 'general_information',
      desc: '',
      args: [],
    );
  }

  /// `Subsidiaries`
  String get subsidiaries {
    return Intl.message(
      'Subsidiaries',
      name: 'subsidiaries',
      desc: '',
      args: [],
    );
  }

  /// `Associated Company`
  String get associated_company {
    return Intl.message(
      'Associated Company',
      name: 'associated_company',
      desc: '',
      args: [],
    );
  }

  /// `Register right successfully`
  String get register_right_successfully {
    return Intl.message(
      'Register right successfully',
      name: 'register_right_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Register right failed`
  String get register_right_failed {
    return Intl.message(
      'Register right failed',
      name: 'register_right_failed',
      desc: '',
      args: [],
    );
  }

  /// `Other functions`
  String get other_functions {
    return Intl.message(
      'Other functions',
      name: 'other_functions',
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

  /// `Please log in to access more feature of DTND`
  String get account_not_login_sentence {
    return Intl.message(
      'Please log in to access more feature of DTND',
      name: 'account_not_login_sentence',
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

  /// `Welcome back, please fill the password to continue`
  String get not_first_login_quote {
    return Intl.message(
      'Welcome back, please fill the password to continue',
      name: 'not_first_login_quote',
      desc: '',
      args: [],
    );
  }

  /// `You are a newbie and want to make trading easier`
  String get technical_trading_newbie {
    return Intl.message(
      'You are a newbie and want to make trading easier',
      name: 'technical_trading_newbie',
      desc: '',
      args: [],
    );
  }

  /// `You trade like a Professional Investor`
  String get technical_trading_pro {
    return Intl.message(
      'You trade like a Professional Investor',
      name: 'technical_trading_pro',
      desc: '',
      args: [],
    );
  }

  /// `Top influence`
  String get top_influence {
    return Intl.message(
      'Top influence',
      name: 'top_influence',
      desc: '',
      args: [],
    );
  }

  /// `Liquidity`
  String get liquidity {
    return Intl.message(
      'Liquidity',
      name: 'liquidity',
      desc: '',
      args: [],
    );
  }

  /// `Cash flow`
  String get cash_flow {
    return Intl.message(
      'Cash flow',
      name: 'cash_flow',
      desc: '',
      args: [],
    );
  }

  /// `Market breadth`
  String get market_breadth {
    return Intl.message(
      'Market breadth',
      name: 'market_breadth',
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

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Petroleum Production' key

  // skipped getter for the 'Oil and Gas Equipment, Service and Distribution' key

  /// `Chemistry`
  String get Chemistry {
    return Intl.message(
      'Chemistry',
      name: 'Chemistry',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Forestry and Paper' key

  /// `Metal`
  String get Metal {
    return Intl.message(
      'Metal',
      name: 'Metal',
      desc: '',
      args: [],
    );
  }

  /// `Extractive`
  String get Extractive {
    return Intl.message(
      'Extractive',
      name: 'Extractive',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Construction and Materials' key

  // skipped getter for the 'Aviation and Defense' key

  // skipped getter for the 'Industrial goods' key

  // skipped getter for the 'Electronics and Electrical Equipment' key

  // skipped getter for the 'Heavy industry' key

  /// `Carriage`
  String get Carriage {
    return Intl.message(
      'Carriage',
      name: 'Carriage',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Business Consulting and Support' key

  // skipped getter for the 'Cars and spare parts' key

  // skipped getter for the 'Beer and drinks' key

  // skipped getter for the 'Food production' key

  // skipped getter for the 'Household appliances' key

  // skipped getter for the 'Leisure goods' key

  // skipped getter for the 'Personal goods' key

  /// `Cigarette`
  String get Cigarette {
    return Intl.message(
      'Cigarette',
      name: 'Cigarette',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Medical Equipment and Services' key

  /// `Medicine`
  String get Medicine {
    return Intl.message(
      'Medicine',
      name: 'Medicine',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Food and pharmaceutical distribution' key

  /// `Retail`
  String get Retail {
    return Intl.message(
      'Retail',
      name: 'Retail',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'The media' key

  // skipped getter for the 'Travel and Leisure' key

  // skipped getter for the 'Fixed telecommunications' key

  // skipped getter for the 'Mobile telecommunications' key

  // skipped getter for the 'Water and Gas' key

  /// `Banking`
  String get Banking {
    return Intl.message(
      'Banking',
      name: 'Banking',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Non-life insurance' key

  // skipped getter for the 'Life insurance' key

  // skipped getter for the 'Real estate' key

  // skipped getter for the 'Financial services' key

  // skipped getter for the 'Investment funds' key

  // skipped getter for the 'Venture capital funds' key

  // skipped getter for the 'Computer Software and Services' key

  // skipped getter for the 'Equipment and Hardware' key

  /// `No response from server`
  String get timeout {
    return Intl.message(
      'No response from server',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
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

  /// `Date`
  String get date_translations {
    return Intl.message(
      'Date',
      name: 'date_translations',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open_translations {
    return Intl.message(
      'Open',
      name: 'open_translations',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high_translations {
    return Intl.message(
      'High',
      name: 'high_translations',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low_translations {
    return Intl.message(
      'Low',
      name: 'low_translations',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close_translations {
    return Intl.message(
      'Close',
      name: 'close_translations',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get changeAmount_translations {
    return Intl.message(
      'Change',
      name: 'changeAmount_translations',
      desc: '',
      args: [],
    );
  }

  /// `Change%`
  String get change_translations {
    return Intl.message(
      'Change%',
      name: 'change_translations',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volumn_translations {
    return Intl.message(
      'Volume',
      name: 'volumn_translations',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount_translations {
    return Intl.message(
      'Amount',
      name: 'amount_translations',
      desc: '',
      args: [],
    );
  }

  /// `Vietnam`
  String get vietnam {
    return Intl.message(
      'Vietnam',
      name: 'vietnam',
      desc: '',
      args: [],
    );
  }

  /// `Foreign`
  String get foreign {
    return Intl.message(
      'Foreign',
      name: 'foreign',
      desc: '',
      args: [],
    );
  }

  /// `World`
  String get world {
    return Intl.message(
      'World',
      name: 'world',
      desc: '',
      args: [],
    );
  }

  /// `Commodities`
  String get commodities {
    return Intl.message(
      'Commodities',
      name: 'commodities',
      desc: '',
      args: [],
    );
  }

  /// `Copytrade`
  String get copytrade {
    return Intl.message(
      'Copytrade',
      name: 'copytrade',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Signal type`
  String get signal_type {
    return Intl.message(
      'Signal type',
      name: 'signal_type',
      desc: '',
      args: [],
    );
  }

  /// `Effective`
  String get effective {
    return Intl.message(
      'Effective',
      name: 'effective',
      desc: '',
      args: [],
    );
  }

  /// `Ratio`
  String get ratio {
    return Intl.message(
      'Ratio',
      name: 'ratio',
      desc: '',
      args: [],
    );
  }

  /// `Base trading`
  String get base_trading {
    return Intl.message(
      'Base trading',
      name: 'base_trading',
      desc: '',
      args: [],
    );
  }

  /// `Derivative trading`
  String get derivative_trading {
    return Intl.message(
      'Derivative trading',
      name: 'derivative_trading',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get statement {
    return Intl.message(
      'Statement',
      name: 'statement',
      desc: '',
      args: [],
    );
  }

  /// `Money statement`
  String get money_statement {
    return Intl.message(
      'Money statement',
      name: 'money_statement',
      desc: '',
      args: [],
    );
  }

  /// `Stock statement`
  String get stock_statement {
    return Intl.message(
      'Stock statement',
      name: 'stock_statement',
      desc: '',
      args: [],
    );
  }

  /// `Lookup`
  String get lookup {
    return Intl.message(
      'Lookup',
      name: 'lookup',
      desc: '',
      args: [],
    );
  }

  /// `Gain/loss history`
  String get gain_loss_history {
    return Intl.message(
      'Gain/loss history',
      name: 'gain_loss_history',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Order orders pin`
  String get order_orders_pin {
    return Intl.message(
      'Order orders pin',
      name: 'order_orders_pin',
      desc: '',
      args: [],
    );
  }

  /// `Biomestric`
  String get biomestric {
    return Intl.message(
      'Biomestric',
      name: 'biomestric',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message(
      'by',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Languges`
  String get languges {
    return Intl.message(
      'Languges',
      name: 'languges',
      desc: '',
      args: [],
    );
  }

  /// `Interface`
  String get interface {
    return Intl.message(
      'Interface',
      name: 'interface',
      desc: '',
      args: [],
    );
  }

  /// `Stock analysis`
  String get stock_analysis {
    return Intl.message(
      'Stock analysis',
      name: 'stock_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Unknown exception`
  String get unknown_exception {
    return Intl.message(
      'Unknown exception',
      name: 'unknown_exception',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get Later {
    return Intl.message(
      'Later',
      name: 'Later',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication`
  String get biometric_authentication {
    return Intl.message(
      'Biometric authentication',
      name: 'biometric_authentication',
      desc: '',
      args: [],
    );
  }

  /// `You have not registered for biometric authentication.\nWould you like to register now?`
  String get login_with_biometric {
    return Intl.message(
      'You have not registered for biometric authentication.\nWould you like to register now?',
      name: 'login_with_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get money {
    return Intl.message(
      'Money',
      name: 'money',
      desc: '',
      args: [],
    );
  }

  /// `stock`
  String get stock {
    return Intl.message(
      'stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Register to buy`
  String get register_to_buy {
    return Intl.message(
      'Register to buy',
      name: 'register_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `Maximum load`
  String get maximum_load {
    return Intl.message(
      'Maximum load',
      name: 'maximum_load',
      desc: '',
      args: [],
    );
  }

  /// `Buying Price`
  String get buying_price {
    return Intl.message(
      'Buying Price',
      name: 'buying_price',
      desc: '',
      args: [],
    );
  }

  /// `Deduction account`
  String get deduction_account {
    return Intl.message(
      'Deduction account',
      name: 'deduction_account',
      desc: '',
      args: [],
    );
  }

  /// `Total transaction`
  String get total_transaction {
    return Intl.message(
      'Total transaction',
      name: 'total_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Weight must be filled in`
  String get Weight_must_be_filled_in {
    return Intl.message(
      'Weight must be filled in',
      name: 'Weight_must_be_filled_in',
      desc: '',
      args: [],
    );
  }

  /// `invalid weight`
  String get invalid_weight {
    return Intl.message(
      'invalid weight',
      name: 'invalid_weight',
      desc: '',
      args: [],
    );
  }

  /// `Tax fee`
  String get tax_fee {
    return Intl.message(
      'Tax fee',
      name: 'tax_fee',
      desc: '',
      args: [],
    );
  }

  /// `Sale value`
  String get sale_value {
    return Intl.message(
      'Sale value',
      name: 'sale_value',
      desc: '',
      args: [],
    );
  }

  /// `Cost price`
  String get cost_price {
    return Intl.message(
      'Cost price',
      name: 'cost_price',
      desc: '',
      args: [],
    );
  }

  /// `Cost value`
  String get cost_value {
    return Intl.message(
      'Cost value',
      name: 'cost_value',
      desc: '',
      args: [],
    );
  }

  /// `command type`
  String get command_type {
    return Intl.message(
      'command type',
      name: 'command_type',
      desc: '',
      args: [],
    );
  }

  /// `return command`
  String get return_command {
    return Intl.message(
      'return command',
      name: 'return_command',
      desc: '',
      args: [],
    );
  }

  /// `Return home page`
  String get return_home_page {
    return Intl.message(
      'Return home page',
      name: 'return_home_page',
      desc: '',
      args: [],
    );
  }

  /// `Your account information has been sent to your email!`
  String get info_sent_to_email {
    return Intl.message(
      'Your account information has been sent to your email!',
      name: 'info_sent_to_email',
      desc: '',
      args: [],
    );
  }

  /// `Let us protect your account and important information`
  String get title_change_password {
    return Intl.message(
      'Let us protect your account and important information',
      name: 'title_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm command edit`
  String get confirm_command_edit {
    return Intl.message(
      'Confirm command edit',
      name: 'confirm_command_edit',
      desc: '',
      args: [],
    );
  }

  /// `Stock code`
  String get stock_code {
    return Intl.message(
      'Stock code',
      name: 'stock_code',
      desc: '',
      args: [],
    );
  }

  /// ` saved pin code`
  String get saved_pin_code {
    return Intl.message(
      ' saved pin code',
      name: 'saved_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `edit filter`
  String get edit_filter {
    return Intl.message(
      'edit filter',
      name: 'edit_filter',
      desc: '',
      args: [],
    );
  }

  /// `create filter`
  String get create_filter {
    return Intl.message(
      'create filter',
      name: 'create_filter',
      desc: '',
      args: [],
    );
  }

  /// `apply`
  String get apply {
    return Intl.message(
      'apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `type`
  String get type {
    return Intl.message(
      'type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `stock exchange`
  String get stock_exchange {
    return Intl.message(
      'stock exchange',
      name: 'stock_exchange',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a list`
  String get Please_provide_a_list {
    return Intl.message(
      'Please provide a list',
      name: 'Please_provide_a_list',
      desc: '',
      args: [],
    );
  }

  /// `Invalid value`
  String get invalid_value {
    return Intl.message(
      'Invalid value',
      name: 'invalid_value',
      desc: '',
      args: [],
    );
  }

  /// `A chart comparing the cash flow at the current time with the previous session, averaging one week. Data is based on a daily basis `
  String get chart_comparing_the_cash {
    return Intl.message(
      'A chart comparing the cash flow at the current time with the previous session, averaging one week. Data is based on a daily basis ',
      name: 'chart_comparing_the_cash',
      desc: '',
      args: [],
    );
  }

  /// `Order cancellation confirmation`
  String get order_cancellation_confirmation {
    return Intl.message(
      'Order cancellation confirmation',
      name: 'order_cancellation_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel the order ?`
  String get Are_you_sure_you_want_to_cancel_the_order {
    return Intl.message(
      'Are you sure you want to cancel the order ?',
      name: 'Are_you_sure_you_want_to_cancel_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Top traded stocks by sector`
  String get top_traded_stocks_by_sector {
    return Intl.message(
      'Top traded stocks by sector',
      name: 'top_traded_stocks_by_sector',
      desc: '',
      args: [],
    );
  }

  /// `Find sector...`
  String get find_sector {
    return Intl.message(
      'Find sector...',
      name: 'find_sector',
      desc: '',
      args: [],
    );
  }

  /// `Invalid industry`
  String get invalid_industry {
    return Intl.message(
      'Invalid industry',
      name: 'invalid_industry',
      desc: '',
      args: [],
    );
  }

  /// `stock_symbol`
  String get stock_symbol {
    return Intl.message(
      'stock_symbol',
      name: 'stock_symbol',
      desc: '',
      args: [],
    );
  }

  /// `Institution`
  String get Institution {
    return Intl.message(
      'Institution',
      name: 'Institution',
      desc: '',
      args: [],
    );
  }

  /// `Setting up Smart OTP password`
  String get Setting_up_Smart_OTP_password {
    return Intl.message(
      'Setting up Smart OTP password',
      name: 'Setting_up_Smart_OTP_password',
      desc: '',
      args: [],
    );
  }

  /// `Please remember your SmartOTP password`
  String get Please_remember_your_SmartOTP_password {
    return Intl.message(
      'Please remember your SmartOTP password',
      name: 'Please_remember_your_SmartOTP_password',
      desc: '',
      args: [],
    );
  }

  /// `Set a password consisting of 6 digits`
  String get Set_a_password_consisting_of_6_digits {
    return Intl.message(
      'Set a password consisting of 6 digits',
      name: 'Set_a_password_consisting_of_6_digits',
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
