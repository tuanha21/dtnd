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

  /// `Sell price`
  String get sell_price {
    return Intl.message(
      'Sell price',
      name: 'sell_price',
      desc: '',
      args: [],
    );
  }

  /// `Volumn`
  String get volumn {
    return Intl.message(
      'Volumn',
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

  /// `MK value`
  String get mk_value {
    return Intl.message(
      'MK value',
      name: 'mk_value',
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

  /// `Sold returning vol`
  String get sold_returning_vol {
    return Intl.message(
      'Sold returning vol',
      name: 'sold_returning_vol',
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

  /// `B`
  String get billion_short {
    return Intl.message(
      'B',
      name: 'billion_short',
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

  /// `The OTP has been sent to your {value} extension phone number. Enter the 6-digit code to continue.`
  String otp_code_sent_to_phone_number(Object value) {
    return Intl.message(
      'The OTP has been sent to your $value extension phone number. Enter the 6-digit code to continue.',
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

  /// `Create new order`
  String get create_new_order {
    return Intl.message(
      'Create new order',
      name: 'create_new_order',
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

  /// `Copytrade`
  String get copytrade {
    return Intl.message(
      'Copytrade',
      name: 'copytrade',
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
