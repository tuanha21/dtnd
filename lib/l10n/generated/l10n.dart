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

  /// `Chào bạn`
  String get hello {
    return Intl.message(
      'Chào bạn',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào`
  String get hi {
    return Intl.message(
      'Xin chào',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message(
      'Đăng xuất',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `ĐĂNG NHẬP`
  String get login_upper {
    return Intl.message(
      'ĐĂNG NHẬP',
      name: 'login_upper',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập với Google`
  String get login_with_google {
    return Intl.message(
      'Đăng nhập với Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập với Facebook`
  String get login_with_facebook {
    return Intl.message(
      'Đăng nhập với Facebook',
      name: 'login_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get sign_up {
    return Intl.message(
      'Đăng ký',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Chào bạn`
  String get hi_you {
    return Intl.message(
      'Chào bạn',
      name: 'hi_you',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Thị trường`
  String get market {
    return Intl.message(
      'Thị trường',
      name: 'market',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lệnh`
  String get order {
    return Intl.message(
      'Đặt lệnh',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Trái phiếu`
  String get bond {
    return Intl.message(
      'Trái phiếu',
      name: 'bond',
      desc: '',
      args: [],
    );
  }

  /// `Tài sản`
  String get asset {
    return Intl.message(
      'Tài sản',
      name: 'asset',
      desc: '',
      args: [],
    );
  }

  /// `Cộng đồng`
  String get community {
    return Intl.message(
      'Cộng đồng',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Tiền gửi`
  String get qa_money {
    return Intl.message(
      'Tiền gửi',
      name: 'qa_money',
      desc: '',
      args: [],
    );
  }

  /// `Cơ sở`
  String get qa_base {
    return Intl.message(
      'Cơ sở',
      name: 'qa_base',
      desc: '',
      args: [],
    );
  }

  /// `Phái sinh`
  String get qa_derivative {
    return Intl.message(
      'Phái sinh',
      name: 'qa_derivative',
      desc: '',
      args: [],
    );
  }

  /// `ĐK gói`
  String get qa_pack_enrol {
    return Intl.message(
      'ĐK gói',
      name: 'qa_pack_enrol',
      desc: '',
      args: [],
    );
  }

  /// `Trái phiếu`
  String get qa_bond {
    return Intl.message(
      'Trái phiếu',
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

  /// `Tuỳ chỉnh`
  String get qa_custom {
    return Intl.message(
      'Tuỳ chỉnh',
      name: 'qa_custom',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản`
  String get account {
    return Intl.message(
      'Tài khoản',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get username {
    return Intl.message(
      'Tên đăng nhập',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get full_name {
    return Intl.message(
      'Họ và tên',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phone_number {
    return Intl.message(
      'Số điện thoại',
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

  /// `Nhập tài khoản`
  String get fill_account {
    return Intl.message(
      'Nhập tài khoản',
      name: 'fill_account',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mật khẩu`
  String get fill_password {
    return Intl.message(
      'Nhập mật khẩu',
      name: 'fill_password',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mã OTP`
  String get fill_OTP {
    return Intl.message(
      'Nhập mã OTP',
      name: 'fill_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Hết phiên đăng nhập sau `
  String get session_expired_in {
    return Intl.message(
      'Hết phiên đăng nhập sau ',
      name: 'session_expired_in',
      desc: '',
      args: [],
    );
  }

  /// ` phút`
  String get minutes {
    return Intl.message(
      ' phút',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Ấn thêm lần nữa để thoát`
  String get double_back_to_close_app {
    return Intl.message(
      'Ấn thêm lần nữa để thoát',
      name: 'double_back_to_close_app',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản`
  String get create_account {
    return Intl.message(
      'Tạo tài khoản',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Tạo danh mục`
  String get create_catalog {
    return Intl.message(
      'Tạo danh mục',
      name: 'create_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Sổ lệnh`
  String get order_note {
    return Intl.message(
      'Sổ lệnh',
      name: 'order_note',
      desc: '',
      args: [],
    );
  }

  /// `LS lệnh`
  String get order_htr {
    return Intl.message(
      'LS lệnh',
      name: 'order_htr',
      desc: '',
      args: [],
    );
  }

  /// `Ngân hàng`
  String get bank {
    return Intl.message(
      'Ngân hàng',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Tích luỹ`
  String get accumulate {
    return Intl.message(
      'Tích luỹ',
      name: 'accumulate',
      desc: '',
      args: [],
    );
  }

  /// `Mở cửa`
  String get status_open {
    return Intl.message(
      'Mở cửa',
      name: 'status_open',
      desc: '',
      args: [],
    );
  }

  /// `Đóng cửa`
  String get status_close {
    return Intl.message(
      'Đóng cửa',
      name: 'status_close',
      desc: '',
      args: [],
    );
  }

  /// `Tạm nghỉ`
  String get status_intermission {
    return Intl.message(
      'Tạm nghỉ',
      name: 'status_intermission',
      desc: '',
      args: [],
    );
  }

  /// `Nhập password`
  String get please_input_password {
    return Intl.message(
      'Nhập password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không trùng khớp`
  String get pass_not_match {
    return Intl.message(
      'Mật khẩu không trùng khớp',
      name: 'pass_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Mã chứng khoán`
  String get stock_code {
    return Intl.message(
      'Mã chứng khoán',
      name: 'stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Mã CK`
  String get stk_code {
    return Intl.message(
      'Mã CK',
      name: 'stk_code',
      desc: '',
      args: [],
    );
  }

  /// `Trần`
  String get ceil {
    return Intl.message(
      'Trần',
      name: 'ceil',
      desc: '',
      args: [],
    );
  }

  /// `Sàn`
  String get floor {
    return Intl.message(
      'Sàn',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `TC`
  String get ref {
    return Intl.message(
      'TC',
      name: 'ref',
      desc: '',
      args: [],
    );
  }

  /// `Thấp`
  String get low {
    return Intl.message(
      'Thấp',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Trung bình`
  String get average {
    return Intl.message(
      'Trung bình',
      name: 'average',
      desc: '',
      args: [],
    );
  }

  /// `Cao`
  String get high {
    return Intl.message(
      'Cao',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `NN mua`
  String get fbuy {
    return Intl.message(
      'NN mua',
      name: 'fbuy',
      desc: '',
      args: [],
    );
  }

  /// `Room NN`
  String get froom {
    return Intl.message(
      'Room NN',
      name: 'froom',
      desc: '',
      args: [],
    );
  }

  /// `NN bán`
  String get fsell {
    return Intl.message(
      'NN bán',
      name: 'fsell',
      desc: '',
      args: [],
    );
  }

  /// `Mua`
  String get buy {
    return Intl.message(
      'Mua',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get buy_short {
    return Intl.message(
      'M',
      name: 'buy_short',
      desc: '',
      args: [],
    );
  }

  /// `Giá mua vào`
  String get buy_price {
    return Intl.message(
      'Giá mua vào',
      name: 'buy_price',
      desc: '',
      args: [],
    );
  }

  /// `Bán`
  String get sell {
    return Intl.message(
      'Bán',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get sell_short {
    return Intl.message(
      'B',
      name: 'sell_short',
      desc: '',
      args: [],
    );
  }

  /// `Giá bán ra`
  String get sell_price {
    return Intl.message(
      'Giá bán ra',
      name: 'sell_price',
      desc: '',
      args: [],
    );
  }

  /// `Giá bán`
  String get selling_price {
    return Intl.message(
      'Giá bán',
      name: 'selling_price',
      desc: '',
      args: [],
    );
  }

  /// `Tích lũy`
  String get accumulation {
    return Intl.message(
      'Tích lũy',
      name: 'accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Khối lượng`
  String get volumn {
    return Intl.message(
      'Khối lượng',
      name: 'volumn',
      desc: '',
      args: [],
    );
  }

  /// `Cổ tức`
  String get dividend {
    return Intl.message(
      'Cổ tức',
      name: 'dividend',
      desc: '',
      args: [],
    );
  }

  /// `Tổng {value}`
  String total_wvalue(Object value) {
    return Intl.message(
      'Tổng $value',
      name: 'total_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Tăng {value}`
  String gain_wvalue(Object value) {
    return Intl.message(
      'Tăng $value',
      name: 'gain_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Giảm {value}`
  String loss_wvalue(Object value) {
    return Intl.message(
      'Giảm $value',
      name: 'loss_wvalue',
      desc: '',
      args: [value],
    );
  }

  /// `Giá`
  String get price {
    return Intl.message(
      'Giá',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Tài sản ròng`
  String get net_assets {
    return Intl.message(
      'Tài sản ròng',
      name: 'net_assets',
      desc: '',
      args: [],
    );
  }

  /// `Lợi nhuận ròng`
  String get net_profit {
    return Intl.message(
      'Lợi nhuận ròng',
      name: 'net_profit',
      desc: '',
      args: [],
    );
  }

  /// `Lợi nhuận`
  String get profit_value {
    return Intl.message(
      'Lợi nhuận',
      name: 'profit_value',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tiền`
  String get total_cash {
    return Intl.message(
      'Tổng tiền',
      name: 'total_cash',
      desc: '',
      args: [],
    );
  }

  /// `Doanh thu`
  String get revenue {
    return Intl.message(
      'Doanh thu',
      name: 'revenue',
      desc: '',
      args: [],
    );
  }

  /// `Tổng giá trị đầu tư`
  String get investment_value {
    return Intl.message(
      'Tổng giá trị đầu tư',
      name: 'investment_value',
      desc: '',
      args: [],
    );
  }

  /// `Tiền mặt`
  String get cash {
    return Intl.message(
      'Tiền mặt',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Tiền chờ về`
  String get returning_money {
    return Intl.message(
      'Tiền chờ về',
      name: 'returning_money',
      desc: '',
      args: [],
    );
  }

  /// `Tiền bán chờ về`
  String get sold_returning_money {
    return Intl.message(
      'Tiền bán chờ về',
      name: 'sold_returning_money',
      desc: '',
      args: [],
    );
  }

  /// `Tiền có thể rút`
  String get withdrawable_money {
    return Intl.message(
      'Tiền có thể rút',
      name: 'withdrawable_money',
      desc: '',
      args: [],
    );
  }

  /// `Tổng nợ`
  String get total_debt {
    return Intl.message(
      'Tổng nợ',
      name: 'total_debt',
      desc: '',
      args: [],
    );
  }

  /// `Tổng nợ gốc`
  String get total_principal_debt {
    return Intl.message(
      'Tổng nợ gốc',
      name: 'total_principal_debt',
      desc: '',
      args: [],
    );
  }

  /// `Tỷ lệ an toàn`
  String get safe_ratio {
    return Intl.message(
      'Tỷ lệ an toàn',
      name: 'safe_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Cổ tức bằng tiền`
  String get cash_dividends {
    return Intl.message(
      'Cổ tức bằng tiền',
      name: 'cash_dividends',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị vốn`
  String get capital_value {
    return Intl.message(
      'Giá trị vốn',
      name: 'capital_value',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị chứng khoán`
  String get stock_value {
    return Intl.message(
      'Giá trị chứng khoán',
      name: 'stock_value',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị TT`
  String get mk_value {
    return Intl.message(
      'Giá trị TT',
      name: 'mk_value',
      desc: '',
      args: [],
    );
  }

  /// `Giá TT`
  String get mk_price {
    return Intl.message(
      'Giá TT',
      name: 'mk_price',
      desc: '',
      args: [],
    );
  }

  /// `SD khả dụng`
  String get available_balanc {
    return Intl.message(
      'SD khả dụng',
      name: 'available_balanc',
      desc: '',
      args: [],
    );
  }

  /// `Tổng KL`
  String get total_vol {
    return Intl.message(
      'Tổng KL',
      name: 'total_vol',
      desc: '',
      args: [],
    );
  }

  /// `KL thường`
  String get normal_vol {
    return Intl.message(
      'KL thường',
      name: 'normal_vol',
      desc: '',
      args: [],
    );
  }

  /// `KL FS`
  String get fs_vol {
    return Intl.message(
      'KL FS',
      name: 'fs_vol',
      desc: '',
      args: [],
    );
  }

  /// `KL khả dụng`
  String get available_vol {
    return Intl.message(
      'KL khả dụng',
      name: 'available_vol',
      desc: '',
      args: [],
    );
  }

  /// `KL khác`
  String get other_vol {
    return Intl.message(
      'KL khác',
      name: 'other_vol',
      desc: '',
      args: [],
    );
  }

  /// `Bán chờ về`
  String get sold_returning {
    return Intl.message(
      'Bán chờ về',
      name: 'sold_returning',
      desc: '',
      args: [],
    );
  }

  /// `KL bán chờ về`
  String get sold_returning_vol {
    return Intl.message(
      'KL bán chờ về',
      name: 'sold_returning_vol',
      desc: '',
      args: [],
    );
  }

  /// `KL bán`
  String get sold_vol {
    return Intl.message(
      'KL bán',
      name: 'sold_vol',
      desc: '',
      args: [],
    );
  }

  /// `Mua chờ về`
  String get bought_returning {
    return Intl.message(
      'Mua chờ về',
      name: 'bought_returning',
      desc: '',
      args: [],
    );
  }

  /// `KL mua chờ về`
  String get bought_returning_vol {
    return Intl.message(
      'KL mua chờ về',
      name: 'bought_returning_vol',
      desc: '',
      args: [],
    );
  }

  /// `Mở rộng`
  String get extension {
    return Intl.message(
      'Mở rộng',
      name: 'extension',
      desc: '',
      args: [],
    );
  }

  /// `Tất cả`
  String get all {
    return Intl.message(
      'Tất cả',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Sổ lệnh cơ sở`
  String get base_note {
    return Intl.message(
      'Sổ lệnh cơ sở',
      name: 'base_note',
      desc: '',
      args: [],
    );
  }

  /// `SL trong ngày`
  String get inday_note {
    return Intl.message(
      'SL trong ngày',
      name: 'inday_note',
      desc: '',
      args: [],
    );
  }

  /// `SL điều kiện`
  String get conditional_note {
    return Intl.message(
      'SL điều kiện',
      name: 'conditional_note',
      desc: '',
      args: [],
    );
  }

  /// `Theo dõi dư nợ`
  String get debt_following {
    return Intl.message(
      'Theo dõi dư nợ',
      name: 'debt_following',
      desc: '',
      args: [],
    );
  }

  /// `Lãi/lỗ`
  String get profit_and_loss {
    return Intl.message(
      'Lãi/lỗ',
      name: 'profit_and_loss',
      desc: '',
      args: [],
    );
  }

  /// `Lãi/lỗ đã thực hiện`
  String get executed_profit_and_loss {
    return Intl.message(
      'Lãi/lỗ đã thực hiện',
      name: 'executed_profit_and_loss',
      desc: '',
      args: [],
    );
  }

  /// `Công nợ margin`
  String get margin_debt {
    return Intl.message(
      'Công nợ margin',
      name: 'margin_debt',
      desc: '',
      args: [],
    );
  }

  /// `SL trong ngày`
  String get inday_ordnote {
    return Intl.message(
      'SL trong ngày',
      name: 'inday_ordnote',
      desc: '',
      args: [],
    );
  }

  /// `SL điều kiện`
  String get condition_ordnote {
    return Intl.message(
      'SL điều kiện',
      name: 'condition_ordnote',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử lệnh`
  String get order_history {
    return Intl.message(
      'Lịch sử lệnh',
      name: 'order_history',
      desc: '',
      args: [],
    );
  }

  /// `Ký quỹ`
  String get margin {
    return Intl.message(
      'Ký quỹ',
      name: 'margin',
      desc: '',
      args: [],
    );
  }

  /// `Giá đặt`
  String get order_price {
    return Intl.message(
      'Giá đặt',
      name: 'order_price',
      desc: '',
      args: [],
    );
  }

  /// `Giá khớp`
  String get match_price {
    return Intl.message(
      'Giá khớp',
      name: 'match_price',
      desc: '',
      args: [],
    );
  }

  /// `KL khớp`
  String get match_vol {
    return Intl.message(
      'KL khớp',
      name: 'match_vol',
      desc: '',
      args: [],
    );
  }

  /// `Sức mua tối thiểu`
  String get minimum_ee {
    return Intl.message(
      'Sức mua tối thiểu',
      name: 'minimum_ee',
      desc: '',
      args: [],
    );
  }

  /// `Sức mua`
  String get purchasing_ability {
    return Intl.message(
      'Sức mua',
      name: 'purchasing_ability',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết`
  String get detail {
    return Intl.message(
      'Chi tiết',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Ngày mua`
  String get buy_date {
    return Intl.message(
      'Ngày mua',
      name: 'buy_date',
      desc: '',
      args: [],
    );
  }

  /// `Ngày bán`
  String get sell_date {
    return Intl.message(
      'Ngày bán',
      name: 'sell_date',
      desc: '',
      args: [],
    );
  }

  /// `Từ ngày`
  String get from_day {
    return Intl.message(
      'Từ ngày',
      name: 'from_day',
      desc: '',
      args: [],
    );
  }

  /// `Tới ngày`
  String get to_day {
    return Intl.message(
      'Tới ngày',
      name: 'to_day',
      desc: '',
      args: [],
    );
  }

  /// `Sở hữu`
  String get owned {
    return Intl.message(
      'Sở hữu',
      name: 'owned',
      desc: '',
      args: [],
    );
  }

  /// `Giá TB`
  String get avg_price {
    return Intl.message(
      'Giá TB',
      name: 'avg_price',
      desc: '',
      args: [],
    );
  }

  /// `CP thưởng`
  String get bonus_sh {
    return Intl.message(
      'CP thưởng',
      name: 'bonus_sh',
      desc: '',
      args: [],
    );
  }

  /// `Tối đa`
  String get maximum {
    return Intl.message(
      'Tối đa',
      name: 'maximum',
      desc: '',
      args: [],
    );
  }

  /// `Tối thiểu`
  String get minimum {
    return Intl.message(
      'Tối thiểu',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị đặt lệnh`
  String get order_value {
    return Intl.message(
      'Giá trị đặt lệnh',
      name: 'order_value',
      desc: '',
      args: [],
    );
  }

  /// `Phí GD`
  String get td_fee {
    return Intl.message(
      'Phí GD',
      name: 'td_fee',
      desc: '',
      args: [],
    );
  }

  /// `Phí giao dịch`
  String get trading_fee {
    return Intl.message(
      'Phí giao dịch',
      name: 'trading_fee',
      desc: '',
      args: [],
    );
  }

  /// `Chờ khớp`
  String get waiting_match {
    return Intl.message(
      'Chờ khớp',
      name: 'waiting_match',
      desc: '',
      args: [],
    );
  }

  /// `Đã khớp`
  String get matched {
    return Intl.message(
      'Đã khớp',
      name: 'matched',
      desc: '',
      args: [],
    );
  }

  /// `Đang khớp`
  String get matching {
    return Intl.message(
      'Đang khớp',
      name: 'matching',
      desc: '',
      args: [],
    );
  }

  /// `Tr`
  String get million_short {
    return Intl.message(
      'Tr',
      name: 'million_short',
      desc: '',
      args: [],
    );
  }

  /// `Triệu`
  String get million {
    return Intl.message(
      'Triệu',
      name: 'million',
      desc: '',
      args: [],
    );
  }

  /// `triệu`
  String get million_lower {
    return Intl.message(
      'triệu',
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

  /// `Tỷ`
  String get billion_short {
    return Intl.message(
      'Tỷ',
      name: 'billion_short',
      desc: '',
      args: [],
    );
  }

  /// `tỷ`
  String get billion_lowercase {
    return Intl.message(
      'tỷ',
      name: 'billion_lowercase',
      desc: '',
      args: [],
    );
  }

  /// `Tỷ`
  String get billion {
    return Intl.message(
      'Tỷ',
      name: 'billion',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} phút trước`
  String minutes_ago(Object minutes) {
    return Intl.message(
      '$minutes phút trước',
      name: 'minutes_ago',
      desc: '',
      args: [minutes],
    );
  }

  /// `{hours} giờ trước`
  String hours_ago(Object hours) {
    return Intl.message(
      '$hours giờ trước',
      name: 'hours_ago',
      desc: '',
      args: [hours],
    );
  }

  /// `{days} ngày trước`
  String days_ago(Object days) {
    return Intl.message(
      '$days ngày trước',
      name: 'days_ago',
      desc: '',
      args: [days],
    );
  }

  /// `Tổng tài sản`
  String get total_asset {
    return Intl.message(
      'Tổng tài sản',
      name: 'total_asset',
      desc: '',
      args: [],
    );
  }

  /// `Tài sản cơ sở`
  String get base_asset {
    return Intl.message(
      'Tài sản cơ sở',
      name: 'base_asset',
      desc: '',
      args: [],
    );
  }

  /// `Tài sản phái sinh`
  String get derivative_asset {
    return Intl.message(
      'Tài sản phái sinh',
      name: 'derivative_asset',
      desc: '',
      args: [],
    );
  }

  /// `Tài sản CopyTrade`
  String get copyTrade_asset {
    return Intl.message(
      'Tài sản CopyTrade',
      name: 'copyTrade_asset',
      desc: '',
      args: [],
    );
  }

  /// `Phân bố tài sản`
  String get asset_distribution {
    return Intl.message(
      'Phân bố tài sản',
      name: 'asset_distribution',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục quan tâm`
  String get interested_catalog {
    return Intl.message(
      'Danh mục quan tâm',
      name: 'interested_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Thị trường hôm nay`
  String get market_today {
    return Intl.message(
      'Thị trường hôm nay',
      name: 'market_today',
      desc: '',
      args: [],
    );
  }

  /// `Tổng quan thị trường`
  String get market_overview {
    return Intl.message(
      'Tổng quan thị trường',
      name: 'market_overview',
      desc: '',
      args: [],
    );
  }

  /// `Bảng giá`
  String get trading_board {
    return Intl.message(
      'Bảng giá',
      name: 'trading_board',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết khớp lệnh`
  String get matched_order_detail {
    return Intl.message(
      'Chi tiết khớp lệnh',
      name: 'matched_order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ số tài chính`
  String get financial_index {
    return Intl.message(
      'Chỉ số tài chính',
      name: 'financial_index',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ số`
  String get index {
    return Intl.message(
      'Chỉ số',
      name: 'index',
      desc: '',
      args: [],
    );
  }

  /// `Tin tức, sự kiện`
  String get news_and_events {
    return Intl.message(
      'Tin tức, sự kiện',
      name: 'news_and_events',
      desc: '',
      args: [],
    );
  }

  /// `Tin tức`
  String get news {
    return Intl.message(
      'Tin tức',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Sự kiện`
  String get event {
    return Intl.message(
      'Sự kiện',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Quan tâm`
  String get interested {
    return Intl.message(
      'Quan tâm',
      name: 'interested',
      desc: '',
      args: [],
    );
  }

  /// `Tổng quan`
  String get overview {
    return Intl.message(
      'Tổng quan',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Phân tích`
  String get analysis {
    return Intl.message(
      'Phân tích',
      name: 'analysis',
      desc: '',
      args: [],
    );
  }

  /// `Ngành`
  String get industry {
    return Intl.message(
      'Ngành',
      name: 'industry',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách ngành`
  String get industry_list {
    return Intl.message(
      'Danh sách ngành',
      name: 'industry_list',
      desc: '',
      args: [],
    );
  }

  /// `Độ sâu thị trường`
  String get market_deep {
    return Intl.message(
      'Độ sâu thị trường',
      name: 'market_deep',
      desc: '',
      args: [],
    );
  }

  /// `Thêm mã`
  String get add_stock {
    return Intl.message(
      'Thêm mã',
      name: 'add_stock',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận lệnh`
  String get order_confirm {
    return Intl.message(
      'Xác nhận lệnh',
      name: 'order_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Loại lệnh`
  String get order_type {
    return Intl.message(
      'Loại lệnh',
      name: 'order_type',
      desc: '',
      args: [],
    );
  }

  /// `Tổng giao dịch`
  String get exchange_total {
    return Intl.message(
      'Tổng giao dịch',
      name: 'exchange_total',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian hiệu lực`
  String get period_of_validity {
    return Intl.message(
      'Thời gian hiệu lực',
      name: 'period_of_validity',
      desc: '',
      args: [],
    );
  }

  /// `Mã pin`
  String get pin_code {
    return Intl.message(
      'Mã pin',
      name: 'pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Khớp lệnh theo thời gian`
  String get matched_order_by_time {
    return Intl.message(
      'Khớp lệnh theo thời gian',
      name: 'matched_order_by_time',
      desc: '',
      args: [],
    );
  }

  /// `Khớp lệnh theo bước giá`
  String get matched_order_by_price_step {
    return Intl.message(
      'Khớp lệnh theo bước giá',
      name: 'matched_order_by_price_step',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử tìm kiếm`
  String get search_history {
    return Intl.message(
      'Lịch sử tìm kiếm',
      name: 'search_history',
      desc: '',
      args: [],
    );
  }

  /// `Top tìm kiếm`
  String get top_search {
    return Intl.message(
      'Top tìm kiếm',
      name: 'top_search',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy kết quả phù hợp`
  String get no_matching_results_were_found {
    return Intl.message(
      'Không tìm thấy kết quả phù hợp',
      name: 'no_matching_results_were_found',
      desc: '',
      args: [],
    );
  }

  /// `Bạn thử tìm kiếm lại bằng từ khoá khác nhé!`
  String get try_searching_again_with_another_keyword {
    return Intl.message(
      'Bạn thử tìm kiếm lại bằng từ khoá khác nhé!',
      name: 'try_searching_again_with_another_keyword',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý IFIS`
  String get DTND_assistant {
    return Intl.message(
      'Trợ lý IFIS',
      name: 'DTND_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý ảo`
  String get virtual_assistant {
    return Intl.message(
      'Trợ lý ảo',
      name: 'virtual_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý ảo đã sẵn sàng`
  String get virtual_assistant_available {
    return Intl.message(
      'Trợ lý ảo đã sẵn sàng',
      name: 'virtual_assistant_available',
      desc: '',
      args: [],
    );
  }

  /// `điều khoản`
  String get term {
    return Intl.message(
      'điều khoản',
      name: 'term',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý với `
  String get agree_with {
    return Intl.message(
      'Đồng ý với ',
      name: 'agree_with',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// ` của trợ lý ảo IFIS`
  String get DTNDs_virtual_assistant {
    return Intl.message(
      ' của trợ lý ảo IFIS',
      name: 'DTNDs_virtual_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Mã OTP đã được gửi về email {value} của bạn. Nhập mã 6 số để tiếp tục.`
  String otp_code_sent_to_phone_number(Object value) {
    return Intl.message(
      'Mã OTP đã được gửi về email $value của bạn. Nhập mã 6 số để tiếp tục.',
      name: 'otp_code_sent_to_phone_number',
      desc: '',
      args: [value],
    );
  }

  /// `Tạo tài khoản\ntrợ lý ảo thành công`
  String get successfully_create_assistant_account {
    return Intl.message(
      'Tạo tài khoản\ntrợ lý ảo thành công',
      name: 'successfully_create_assistant_account',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý ảo IFIS sẽ giúp bạn có những\ngiao dịch thành công`
  String
      get the_DTND_virtual_assistant_will_help_you_with_successful_transaction {
    return Intl.message(
      'Trợ lý ảo IFIS sẽ giúp bạn có những\ngiao dịch thành công',
      name:
          'the_DTND_virtual_assistant_will_help_you_with_successful_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Các mã CK mà bạn quan tâm`
  String get stocks_you_interested {
    return Intl.message(
      'Các mã CK mà bạn quan tâm',
      name: 'stocks_you_interested',
      desc: '',
      args: [],
    );
  }

  /// `Chọn các mã CK mà bạn đang quan tâm. Bạn có thể cập nhật thêm các mã CK sau`
  String get choose_stocks_you_interested {
    return Intl.message(
      'Chọn các mã CK mà bạn đang quan tâm. Bạn có thể cập nhật thêm các mã CK sau',
      name: 'choose_stocks_you_interested',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục theo dõi`
  String get following_catalog {
    return Intl.message(
      'Danh mục theo dõi',
      name: 'following_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục theo dõi "{name}"`
  String following_catalog_with(Object name) {
    return Intl.message(
      'Danh mục theo dõi "$name"',
      name: 'following_catalog_with',
      desc: '',
      args: [name],
    );
  }

  /// `Danh mục rỗng`
  String get empty_catalog {
    return Intl.message(
      'Danh mục rỗng',
      name: 'empty_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Thêm mã theo dõi`
  String get add_following_stock {
    return Intl.message(
      'Thêm mã theo dõi',
      name: 'add_following_stock',
      desc: '',
      args: [],
    );
  }

  /// `Mã đã tồn tại trong danh mục`
  String get stock_already_exist {
    return Intl.message(
      'Mã đã tồn tại trong danh mục',
      name: 'stock_already_exist',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi xảy ra`
  String get something_went_wrong {
    return Intl.message(
      'Đã có lỗi xảy ra',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Phiên đăng nhập đã hết hạn`
  String get session_had_been_expired {
    return Intl.message(
      'Phiên đăng nhập đã hết hạn',
      name: 'session_had_been_expired',
      desc: '',
      args: [],
    );
  }

  /// `Tìm mã CP`
  String get search_stock {
    return Intl.message(
      'Tìm mã CP',
      name: 'search_stock',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message(
      'Tìm kiếm',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Lọc cổ phiếu`
  String get filter_stock {
    return Intl.message(
      'Lọc cổ phiếu',
      name: 'filter_stock',
      desc: '',
      args: [],
    );
  }

  /// `Bộ lọc`
  String get filter {
    return Intl.message(
      'Bộ lọc',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ số lọc cổ phiếu`
  String get filter_stock_figure {
    return Intl.message(
      'Chỉ số lọc cổ phiếu',
      name: 'filter_stock_figure',
      desc: '',
      args: [],
    );
  }

  /// `Phân tích kỹ thuật`
  String get technical_analysis {
    return Intl.message(
      'Phân tích kỹ thuật',
      name: 'technical_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Tạo`
  String get create {
    return Intl.message(
      'Tạo',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ`
  String get cancel {
    return Intl.message(
      'Huỷ',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian`
  String get time {
    return Intl.message(
      'Thời gian',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `KL khớp`
  String get matched_vol {
    return Intl.message(
      'KL khớp',
      name: 'matched_vol',
      desc: '',
      args: [],
    );
  }

  /// `Giá khớp`
  String get matched_price {
    return Intl.message(
      'Giá khớp',
      name: 'matched_price',
      desc: '',
      args: [],
    );
  }

  /// `Phân tích KL`
  String get vol_analysis {
    return Intl.message(
      'Phân tích KL',
      name: 'vol_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Cảnh báo giá`
  String get price_alert {
    return Intl.message(
      'Cảnh báo giá',
      name: 'price_alert',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch`
  String get trading {
    return Intl.message(
      'Giao dịch',
      name: 'trading',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu đăng nhập`
  String get login_required {
    return Intl.message(
      'Yêu cầu đăng nhập',
      name: 'login_required',
      desc: '',
      args: [],
    );
  }

  /// `Hãy đăng nhập để tiếp tục`
  String get login_to_continue {
    return Intl.message(
      'Hãy đăng nhập để tiếp tục',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa đăng nhập`
  String get you_are_not_logged_in {
    return Intl.message(
      'Bạn chưa đăng nhập',
      name: 'you_are_not_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có tài khoản?`
  String get you_are_not_account {
    return Intl.message(
      'Bạn chưa có tài khoản?',
      name: 'you_are_not_account',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng tài khoản khác`
  String get login_with_another_account {
    return Intl.message(
      'Đăng nhập bằng tài khoản khác',
      name: 'login_with_another_account',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập không thành công`
  String get login_falied {
    return Intl.message(
      'Đăng nhập không thành công',
      name: 'login_falied',
      desc: '',
      args: [],
    );
  }

  /// `Tăng giá`
  String get price_increase {
    return Intl.message(
      'Tăng giá',
      name: 'price_increase',
      desc: '',
      args: [],
    );
  }

  /// `Giảm giá`
  String get price_decrease {
    return Intl.message(
      'Giảm giá',
      name: 'price_decrease',
      desc: '',
      args: [],
    );
  }

  /// `Top nước ngoài`
  String get top_foreign {
    return Intl.message(
      'Top nước ngoài',
      name: 'top_foreign',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lệnh mới`
  String get create_new_order {
    return Intl.message(
      'Đặt lệnh mới',
      name: 'create_new_order',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận sửa lệnh`
  String get confirm_change_order {
    return Intl.message(
      'Xác nhận sửa lệnh',
      name: 'confirm_change_order',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lệnh`
  String get stock_order {
    return Intl.message(
      'Đặt lệnh',
      name: 'stock_order',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lệnh thành công`
  String get create_order_successfully {
    return Intl.message(
      'Đặt lệnh thành công',
      name: 'create_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Sửa lệnh thành công`
  String get change_order_successfully {
    return Intl.message(
      'Sửa lệnh thành công',
      name: 'change_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ lệnh thành công`
  String get cancel_order_successfully {
    return Intl.message(
      'Huỷ lệnh thành công',
      name: 'cancel_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lệnh không thành công`
  String get create_order_failed {
    return Intl.message(
      'Đặt lệnh không thành công',
      name: 'create_order_failed',
      desc: '',
      args: [],
    );
  }

  /// `Lệnh đặt sẽ xuất hiện trong sổ lệnh của bạn`
  String get order_will_appear_in_ur_order_note {
    return Intl.message(
      'Lệnh đặt sẽ xuất hiện trong sổ lệnh của bạn',
      name: 'order_will_appear_in_ur_order_note',
      desc: '',
      args: [],
    );
  }

  /// `Cảnh báo biến động`
  String get volatility_warning {
    return Intl.message(
      'Cảnh báo biến động',
      name: 'volatility_warning',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo biến động`
  String get volatility_notice {
    return Intl.message(
      'Thông báo biến động',
      name: 'volatility_notice',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo tài khoản`
  String get account_notice {
    return Intl.message(
      'Thông báo tài khoản',
      name: 'account_notice',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo danh mục`
  String get catalog_notice {
    return Intl.message(
      'Thông báo danh mục',
      name: 'catalog_notice',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt thống báo biến động tài khoản và danh mục quan tâm của bạn`
  String get volatility_notice_quote1 {
    return Intl.message(
      'Cài đặt thống báo biến động tài khoản và danh mục quan tâm của bạn',
      name: 'volatility_notice_quote1',
      desc: '',
      args: [],
    );
  }

  /// `Thêm danh mục`
  String get add_catalog {
    return Intl.message(
      'Thêm danh mục',
      name: 'add_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Quyền`
  String get right {
    return Intl.message(
      'Quyền',
      name: 'right',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục`
  String get catalog {
    return Intl.message(
      'Danh mục',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Tên danh mục`
  String get catalog_name {
    return Intl.message(
      'Tên danh mục',
      name: 'catalog_name',
      desc: '',
      args: [],
    );
  }

  /// `Sửa tên danh mục`
  String get edit_catalog_name {
    return Intl.message(
      'Sửa tên danh mục',
      name: 'edit_catalog_name',
      desc: '',
      args: [],
    );
  }

  /// `Sửa tên danh mục “{name}” thành`
  String rename_catalog_to(Object name) {
    return Intl.message(
      'Sửa tên danh mục “$name” thành',
      name: 'rename_catalog_to',
      desc: '',
      args: [name],
    );
  }

  /// `Xoá danh mục`
  String get delete_catalog {
    return Intl.message(
      'Xoá danh mục',
      name: 'delete_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa danh mục “{name}” không ?`
  String are_you_sure_to_delete_catalog(Object name) {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa danh mục “$name” không ?',
      name: 'are_you_sure_to_delete_catalog',
      desc: '',
      args: [name],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message(
      'Lưu',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Nộp tiền`
  String get deposite_money {
    return Intl.message(
      'Nộp tiền',
      name: 'deposite_money',
      desc: '',
      args: [],
    );
  }

  /// `Rút tiền`
  String get withdraw_money {
    return Intl.message(
      'Rút tiền',
      name: 'withdraw_money',
      desc: '',
      args: [],
    );
  }

  /// `Cơ sở`
  String get base {
    return Intl.message(
      'Cơ sở',
      name: 'base',
      desc: '',
      args: [],
    );
  }

  /// `Phái sinh`
  String get derivative {
    return Intl.message(
      'Phái sinh',
      name: 'derivative',
      desc: '',
      args: [],
    );
  }

  /// `Biến động GD`
  String get trading_volatility {
    return Intl.message(
      'Biến động GD',
      name: 'trading_volatility',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch cổ phiếu`
  String get stock_trading {
    return Intl.message(
      'Giao dịch cổ phiếu',
      name: 'stock_trading',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch tiền`
  String get money_trading {
    return Intl.message(
      'Giao dịch tiền',
      name: 'money_trading',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý tài khoản`
  String get account_managing {
    return Intl.message(
      'Quản lý tài khoản',
      name: 'account_managing',
      desc: '',
      args: [],
    );
  }

  /// `Trung tâm trợ giúp`
  String get help_center {
    return Intl.message(
      'Trung tâm trợ giúp',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt và bảo mật`
  String get setting_and_secutiry {
    return Intl.message(
      'Cài đặt và bảo mật',
      name: 'setting_and_secutiry',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get setting {
    return Intl.message(
      'Cài đặt',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản`
  String get account_infomation {
    return Intl.message(
      'Thông tin tài khoản',
      name: 'account_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin cá nhân`
  String get personal_infomation {
    return Intl.message(
      'Thông tin cá nhân',
      name: 'personal_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản`
  String get account_number {
    return Intl.message(
      'Số tài khoản',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `CMND/ĐKKD`
  String get id_or_business_id_short {
    return Intl.message(
      'CMND/ĐKKD',
      name: 'id_or_business_id_short',
      desc: '',
      args: [],
    );
  }

  /// `Ngày cấp`
  String get issue_date {
    return Intl.message(
      'Ngày cấp',
      name: 'issue_date',
      desc: '',
      args: [],
    );
  }

  /// `Nơi cấp`
  String get issue_place {
    return Intl.message(
      'Nơi cấp',
      name: 'issue_place',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh`
  String get birthday {
    return Intl.message(
      'Ngày sinh',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Giới tính`
  String get sex {
    return Intl.message(
      'Giới tính',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Nam`
  String get male {
    return Intl.message(
      'Nam',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Nữ`
  String get female {
    return Intl.message(
      'Nữ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Khác`
  String get other {
    return Intl.message(
      'Khác',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin liên lạc`
  String get contact_infomation {
    return Intl.message(
      'Thông tin liên lạc',
      name: 'contact_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get address {
    return Intl.message(
      'Địa chỉ',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin doanh nghiệp`
  String get business_information {
    return Intl.message(
      'Thông tin doanh nghiệp',
      name: 'business_information',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin chung`
  String get general_information {
    return Intl.message(
      'Thông tin chung',
      name: 'general_information',
      desc: '',
      args: [],
    );
  }

  /// `Công ty con`
  String get subsidiaries {
    return Intl.message(
      'Công ty con',
      name: 'subsidiaries',
      desc: '',
      args: [],
    );
  }

  /// `Công ty liên kết`
  String get associated_company {
    return Intl.message(
      'Công ty liên kết',
      name: 'associated_company',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký quyền thành công`
  String get register_right_successfully {
    return Intl.message(
      'Đăng ký quyền thành công',
      name: 'register_right_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký quyền không thành công`
  String get register_right_failed {
    return Intl.message(
      'Đăng ký quyền không thành công',
      name: 'register_right_failed',
      desc: '',
      args: [],
    );
  }

  /// `Các chức năng khác`
  String get other_functions {
    return Intl.message(
      'Các chức năng khác',
      name: 'other_functions',
      desc: '',
      args: [],
    );
  }

  /// `Hãy đăng nhập bằng mã OTP được gửi về máy của bạn`
  String get login_exception_required_OTP {
    return Intl.message(
      'Hãy đăng nhập bằng mã OTP được gửi về máy của bạn',
      name: 'login_exception_required_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản chưa đăng ký hoặc đã hết hiệu lực giao dịch Internet`
  String get invalid_account {
    return Intl.message(
      'Tài khoản chưa đăng ký hoặc đã hết hiệu lực giao dịch Internet',
      name: 'invalid_account',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đăng nhập để thực hiện được nhiều tác vụ hơn với IFIS nhé`
  String get account_not_login_sentence {
    return Intl.message(
      'Bạn đăng nhập để thực hiện được nhiều tác vụ hơn với IFIS nhé',
      name: 'account_not_login_sentence',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập cần tối thiểu 6 ký tự`
  String get null_username {
    return Intl.message(
      'Tên đăng nhập cần tối thiểu 6 ký tự',
      name: 'null_username',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu cần tối thiểu 8 ký tự`
  String get null_password {
    return Intl.message(
      'Mật khẩu cần tối thiểu 8 ký tự',
      name: 'null_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không chính xác`
  String get wrong_password {
    return Intl.message(
      'Mật khẩu không chính xác',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng `
  String get login_qoute1 {
    return Intl.message(
      'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng ',
      name: 'login_qoute1',
      desc: '',
      args: [],
    );
  }

  /// ` bạn nhé`
  String get login_qoute2 {
    return Intl.message(
      ' bạn nhé',
      name: 'login_qoute2',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng bạn quay trở lại, vui lòng nhập mật khẩu để tiếp tục nhé`
  String get not_first_login_quote {
    return Intl.message(
      'Chào mừng bạn quay trở lại, vui lòng nhập mật khẩu để tiếp tục nhé',
      name: 'not_first_login_quote',
      desc: '',
      args: [],
    );
  }

  /// `Bạn là 1 newbie và muốn giao dịch dễ dàng hơn`
  String get technical_trading_newbie {
    return Intl.message(
      'Bạn là 1 newbie và muốn giao dịch dễ dàng hơn',
      name: 'technical_trading_newbie',
      desc: '',
      args: [],
    );
  }

  /// `Bạn giao dịch như 1 nhà đầu tư Chuyên nghiệp`
  String get technical_trading_pro {
    return Intl.message(
      'Bạn giao dịch như 1 nhà đầu tư Chuyên nghiệp',
      name: 'technical_trading_pro',
      desc: '',
      args: [],
    );
  }

  /// `Top ảnh hưởng`
  String get top_influence {
    return Intl.message(
      'Top ảnh hưởng',
      name: 'top_influence',
      desc: '',
      args: [],
    );
  }

  /// `Thanh khoản`
  String get liquidity {
    return Intl.message(
      'Thanh khoản',
      name: 'liquidity',
      desc: '',
      args: [],
    );
  }

  /// `Dòng tiền`
  String get cash_flow {
    return Intl.message(
      'Dòng tiền',
      name: 'cash_flow',
      desc: '',
      args: [],
    );
  }

  /// `Độ rộng thị trường`
  String get market_breadth {
    return Intl.message(
      'Độ rộng thị trường',
      name: 'market_breadth',
      desc: '',
      args: [],
    );
  }

  /// `Xem thêm`
  String get see_more {
    return Intl.message(
      'Xem thêm',
      name: 'see_more',
      desc: '',
      args: [],
    );
  }

  /// `Đang tải...`
  String get loading {
    return Intl.message(
      'Đang tải...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get next {
    return Intl.message(
      'Tiếp tục',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa`
  String get edit {
    return Intl.message(
      'Chỉnh sửa',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Xoá`
  String get delete {
    return Intl.message(
      'Xoá',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Petroleum Production' key

  // skipped getter for the 'Oil and Gas Equipment, Service and Distribution' key

  /// `Hóa chất`
  String get Chemistry {
    return Intl.message(
      'Hóa chất',
      name: 'Chemistry',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Forestry and Paper' key

  /// `Kim loại`
  String get Metal {
    return Intl.message(
      'Kim loại',
      name: 'Metal',
      desc: '',
      args: [],
    );
  }

  /// `Khai khoáng`
  String get Extractive {
    return Intl.message(
      'Khai khoáng',
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

  /// `Vận tải`
  String get Carriage {
    return Intl.message(
      'Vận tải',
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

  /// `Thuốc lá`
  String get Cigarette {
    return Intl.message(
      'Thuốc lá',
      name: 'Cigarette',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Medical Equipment and Services' key

  /// `Dược phẩm`
  String get Medicine {
    return Intl.message(
      'Dược phẩm',
      name: 'Medicine',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Food and pharmaceutical distribution' key

  /// `Bán lẻ`
  String get Retail {
    return Intl.message(
      'Bán lẻ',
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

  /// `Ngân hàng`
  String get Banking {
    return Intl.message(
      'Ngân hàng',
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

  /// `Không nhận được phản hồi từ máy chủ`
  String get timeout {
    return Intl.message(
      'Không nhận được phản hồi từ máy chủ',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi không xác định`
  String get unknown_error {
    return Intl.message(
      'Lỗi không xác định',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Không có kết nối Internet`
  String get no_internet {
    return Intl.message(
      'Không có kết nối Internet',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Ngày`
  String get date_translations {
    return Intl.message(
      'Ngày',
      name: 'date_translations',
      desc: '',
      args: [],
    );
  }

  /// `Giá mở cửa`
  String get open_translations {
    return Intl.message(
      'Giá mở cửa',
      name: 'open_translations',
      desc: '',
      args: [],
    );
  }

  /// `Cao`
  String get high_translations {
    return Intl.message(
      'Cao',
      name: 'high_translations',
      desc: '',
      args: [],
    );
  }

  /// `Thấp`
  String get low_translations {
    return Intl.message(
      'Thấp',
      name: 'low_translations',
      desc: '',
      args: [],
    );
  }

  /// `Giá đóng cửa`
  String get close_translations {
    return Intl.message(
      'Giá đóng cửa',
      name: 'close_translations',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi`
  String get changeAmount_translations {
    return Intl.message(
      'Thay đổi',
      name: 'changeAmount_translations',
      desc: '',
      args: [],
    );
  }

  /// `% Thay đổi`
  String get change_translations {
    return Intl.message(
      '% Thay đổi',
      name: 'change_translations',
      desc: '',
      args: [],
    );
  }

  /// `Khối lượng`
  String get volumn_translations {
    return Intl.message(
      'Khối lượng',
      name: 'volumn_translations',
      desc: '',
      args: [],
    );
  }

  /// `Số lượng`
  String get amount_translations {
    return Intl.message(
      'Số lượng',
      name: 'amount_translations',
      desc: '',
      args: [],
    );
  }

  /// `Việt nam`
  String get vietnam {
    return Intl.message(
      'Việt nam',
      name: 'vietnam',
      desc: '',
      args: [],
    );
  }

  /// `Nước ngoài`
  String get foreign {
    return Intl.message(
      'Nước ngoài',
      name: 'foreign',
      desc: '',
      args: [],
    );
  }

  /// `Thế giới`
  String get world {
    return Intl.message(
      'Thế giới',
      name: 'world',
      desc: '',
      args: [],
    );
  }

  /// `Hàng hoá`
  String get commodities {
    return Intl.message(
      'Hàng hoá',
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

  /// `Giao dịch`
  String get transaction {
    return Intl.message(
      'Giao dịch',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Loại tín hiệu`
  String get signal_type {
    return Intl.message(
      'Loại tín hiệu',
      name: 'signal_type',
      desc: '',
      args: [],
    );
  }

  /// `Hiệu quả`
  String get effective {
    return Intl.message(
      'Hiệu quả',
      name: 'effective',
      desc: '',
      args: [],
    );
  }

  /// `Tỷ lệ`
  String get ratio {
    return Intl.message(
      'Tỷ lệ',
      name: 'ratio',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch cơ sở`
  String get base_trading {
    return Intl.message(
      'Giao dịch cơ sở',
      name: 'base_trading',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch phái sinh`
  String get derivative_trading {
    return Intl.message(
      'Giao dịch phái sinh',
      name: 'derivative_trading',
      desc: '',
      args: [],
    );
  }

  /// `Sao kê`
  String get statement {
    return Intl.message(
      'Sao kê',
      name: 'statement',
      desc: '',
      args: [],
    );
  }

  /// `Sao kê tiền`
  String get money_statement {
    return Intl.message(
      'Sao kê tiền',
      name: 'money_statement',
      desc: '',
      args: [],
    );
  }

  /// `Sao kê chứng khoán`
  String get stock_statement {
    return Intl.message(
      'Sao kê chứng khoán',
      name: 'stock_statement',
      desc: '',
      args: [],
    );
  }

  /// `Tra cứu`
  String get lookup {
    return Intl.message(
      'Tra cứu',
      name: 'lookup',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử lãi/lỗ`
  String get gain_loss_history {
    return Intl.message(
      'Lịch sử lãi/lỗ',
      name: 'gain_loss_history',
      desc: '',
      args: [],
    );
  }

  /// `Bảo mật`
  String get security {
    return Intl.message(
      'Bảo mật',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu`
  String get change_password {
    return Intl.message(
      'Đổi mật khẩu',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Mã pin đặt lệnh`
  String get order_orders_pin {
    return Intl.message(
      'Mã pin đặt lệnh',
      name: 'order_orders_pin',
      desc: '',
      args: [],
    );
  }

  /// `Sinh trắc học`
  String get biomestric {
    return Intl.message(
      'Sinh trắc học',
      name: 'biomestric',
      desc: '',
      args: [],
    );
  }

  /// `bằng`
  String get by {
    return Intl.message(
      'bằng',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Ngôn ngữ`
  String get languge {
    return Intl.message(
      'Ngôn ngữ',
      name: 'languge',
      desc: '',
      args: [],
    );
  }

  /// `Giao diện`
  String get interface {
    return Intl.message(
      'Giao diện',
      name: 'interface',
      desc: '',
      args: [],
    );
  }

  /// `Phân tích cổ phiếu`
  String get stock_analysis {
    return Intl.message(
      'Phân tích cổ phiếu',
      name: 'stock_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi không xác định`
  String get unknown_exception {
    return Intl.message(
      'Lỗi không xác định',
      name: 'unknown_exception',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get ok {
    return Intl.message(
      'Đồng ý',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Để sau`
  String get later {
    return Intl.message(
      'Để sau',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng sinh trắc học`
  String get biometric_authentication {
    return Intl.message(
      'Đăng nhập bằng sinh trắc học',
      name: 'biometric_authentication',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?`
  String get login_with_biometric {
    return Intl.message(
      'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
      name: 'login_with_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Tiền`
  String get money {
    return Intl.message(
      'Tiền',
      name: 'money',
      desc: '',
      args: [],
    );
  }

  /// `Cổ phiếu`
  String get stock {
    return Intl.message(
      'Cổ phiếu',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký mua`
  String get register_to_buy {
    return Intl.message(
      'Đăng ký mua',
      name: 'register_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `Khối lượng tối đa`
  String get maximum_load {
    return Intl.message(
      'Khối lượng tối đa',
      name: 'maximum_load',
      desc: '',
      args: [],
    );
  }

  /// `Giá mua vào`
  String get buying_price {
    return Intl.message(
      'Giá mua vào',
      name: 'buying_price',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản cắt tiền`
  String get deduction_account {
    return Intl.message(
      'Tài khoản cắt tiền',
      name: 'deduction_account',
      desc: '',
      args: [],
    );
  }

  /// `Tổng giao dịch`
  String get total_transaction {
    return Intl.message(
      'Tổng giao dịch',
      name: 'total_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Khối lượng không được bỏ trống`
  String get Weight_must_be_filled_in {
    return Intl.message(
      'Khối lượng không được bỏ trống',
      name: 'Weight_must_be_filled_in',
      desc: '',
      args: [],
    );
  }

  /// `Khối lượng không hợp lệ`
  String get invalid_weight {
    return Intl.message(
      'Khối lượng không hợp lệ',
      name: 'invalid_weight',
      desc: '',
      args: [],
    );
  }

  /// `Phí thuế`
  String get tax_fee {
    return Intl.message(
      'Phí thuế',
      name: 'tax_fee',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị bán`
  String get sale_value {
    return Intl.message(
      'Giá trị bán',
      name: 'sale_value',
      desc: '',
      args: [],
    );
  }

  /// `Giá vốn`
  String get cost_price {
    return Intl.message(
      'Giá vốn',
      name: 'cost_price',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị vốn`
  String get cost_value {
    return Intl.message(
      'Giá trị vốn',
      name: 'cost_value',
      desc: '',
      args: [],
    );
  }

  /// `Lệnh`
  String get command_type {
    return Intl.message(
      'Lệnh',
      name: 'command_type',
      desc: '',
      args: [],
    );
  }

  /// `Về sổ lệnh`
  String get return_command {
    return Intl.message(
      'Về sổ lệnh',
      name: 'return_command',
      desc: '',
      args: [],
    );
  }

  /// `Về trang chủ`
  String get return_home_page {
    return Intl.message(
      'Về trang chủ',
      name: 'return_home_page',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản đã được gửi về Email của quý khách!`
  String get info_sent_to_email {
    return Intl.message(
      'Thông tin tài khoản đã được gửi về Email của quý khách!',
      name: 'info_sent_to_email',
      desc: '',
      args: [],
    );
  }

  /// `Để chúng tôi bảo vệ tài khoản và các thông tin quan trọng của bạn`
  String get title_change_password {
    return Intl.message(
      'Để chúng tôi bảo vệ tài khoản và các thông tin quan trọng của bạn',
      name: 'title_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận sửa lệnh`
  String get confirm_command_edit {
    return Intl.message(
      'Xác nhận sửa lệnh',
      name: 'confirm_command_edit',
      desc: '',
      args: [],
    );
  }

  /// `Đã lưu pin code `
  String get saved_pin_code {
    return Intl.message(
      'Đã lưu pin code ',
      name: 'saved_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa bộ lọc`
  String get edit_filter {
    return Intl.message(
      'Chỉnh sửa bộ lọc',
      name: 'edit_filter',
      desc: '',
      args: [],
    );
  }

  /// `Tạo bộ lọc`
  String get create_filter {
    return Intl.message(
      'Tạo bộ lọc',
      name: 'create_filter',
      desc: '',
      args: [],
    );
  }

  /// `Áp dụng`
  String get apply {
    return Intl.message(
      'Áp dụng',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Loại`
  String get type {
    return Intl.message(
      'Loại',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Sàn chứng khoán`
  String get stock_exchange {
    return Intl.message(
      'Sàn chứng khoán',
      name: 'stock_exchange',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập danh mục`
  String get Please_provide_a_list {
    return Intl.message(
      'Vui lòng nhập danh mục',
      name: 'Please_provide_a_list',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị không hợp lệ`
  String get invalid_value {
    return Intl.message(
      'Giá trị không hợp lệ',
      name: 'invalid_value',
      desc: '',
      args: [],
    );
  }

  /// `Biểu đồ so sánh dòng tiền tại dùng thời điểm với phiên trước, trung bình 1 tuần. Dữ liệu ngày `
  String get chart_comparing_the_cash {
    return Intl.message(
      'Biểu đồ so sánh dòng tiền tại dùng thời điểm với phiên trước, trung bình 1 tuần. Dữ liệu ngày ',
      name: 'chart_comparing_the_cash',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận hủy lệnh`
  String get order_cancellation_confirmation {
    return Intl.message(
      'Xác nhận hủy lệnh',
      name: 'order_cancellation_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn huỷ lệnh ?`
  String get Are_you_sure_you_want_to_cancel_the_order {
    return Intl.message(
      'Bạn có chắc chắn muốn huỷ lệnh ?',
      name: 'Are_you_sure_you_want_to_cancel_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị`
  String get value {
    return Intl.message(
      'Giá trị',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Top cổ phiếu giao dịch theo ngành`
  String get top_traded_stocks_by_sector {
    return Intl.message(
      'Top cổ phiếu giao dịch theo ngành',
      name: 'top_traded_stocks_by_sector',
      desc: '',
      args: [],
    );
  }

  /// `Tìm ngành...`
  String get find_sector {
    return Intl.message(
      'Tìm ngành...',
      name: 'find_sector',
      desc: '',
      args: [],
    );
  }

  /// `Ngành không hợp lệ`
  String get invalid_industry {
    return Intl.message(
      'Ngành không hợp lệ',
      name: 'invalid_industry',
      desc: '',
      args: [],
    );
  }

  /// `mã cổ phiếu`
  String get stock_symbol {
    return Intl.message(
      'mã cổ phiếu',
      name: 'stock_symbol',
      desc: '',
      args: [],
    );
  }

  /// `Tổ chức`
  String get Institution {
    return Intl.message(
      'Tổ chức',
      name: 'Institution',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt mật khẩu Smart OTP`
  String get Setting_up_Smart_OTP_password {
    return Intl.message(
      'Cài đặt mật khẩu Smart OTP',
      name: 'Setting_up_Smart_OTP_password',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt mật khẩu Smart OTP`
  String get Please_remember_your_SmartOTP_password {
    return Intl.message(
      'Cài đặt mật khẩu Smart OTP',
      name: 'Please_remember_your_SmartOTP_password',
      desc: '',
      args: [],
    );
  }

  /// `Đặt mật khẩu gồm 6 chữ số`
  String get Set_a_password_consisting_of_6_digits {
    return Intl.message(
      'Đặt mật khẩu gồm 6 chữ số',
      name: 'Set_a_password_consisting_of_6_digits',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới`
  String get hint_password {
    return Intl.message(
      'Mật khẩu mới',
      name: 'hint_password',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu mới`
  String get hint_re_password {
    return Intl.message(
      'Nhập lại mật khẩu mới',
      name: 'hint_re_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập lại mật khẩu mới`
  String get validate_null_repassword {
    return Intl.message(
      'Vui lòng nhập lại mật khẩu mới',
      name: 'validate_null_repassword',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu nhập lại không trùng khớp`
  String get validate_same_repassword {
    return Intl.message(
      'Mật khẩu nhập lại không trùng khớp',
      name: 'validate_same_repassword',
      desc: '',
      args: [],
    );
  }

  /// `8 -16 ký tự`
  String get condition_password1 {
    return Intl.message(
      '8 -16 ký tự',
      name: 'condition_password1',
      desc: '',
      args: [],
    );
  }

  /// `1 chữ cái viết hoa`
  String get condition_password2 {
    return Intl.message(
      '1 chữ cái viết hoa',
      name: 'condition_password2',
      desc: '',
      args: [],
    );
  }

  /// `1 chữ số`
  String get condition_password3 {
    return Intl.message(
      '1 chữ số',
      name: 'condition_password3',
      desc: '',
      args: [],
    );
  }

  /// `1 ký tự đặc biệt`
  String get condition_password4 {
    return Intl.message(
      '1 ký tự đặc biệt',
      name: 'condition_password4',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email`
  String get validate_null_email {
    return Intl.message(
      'Vui lòng nhập email',
      name: 'validate_null_email',
      desc: '',
      args: [],
    );
  }

  /// `Email không đúng định dạng`
  String get validate_format_email {
    return Intl.message(
      'Email không đúng định dạng',
      name: 'validate_format_email',
      desc: '',
      args: [],
    );
  }

  /// `TÀI CHÍNH THÔNG MINH`
  String get loading_quote1 {
    return Intl.message(
      'TÀI CHÍNH THÔNG MINH',
      name: 'loading_quote1',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgot_password {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Lưu mật khẩu`
  String get save_password {
    return Intl.message(
      'Lưu mật khẩu',
      name: 'save_password',
      desc: '',
      args: [],
    );
  }

  /// `Chúc mừng quý khách đã thay đổi mật khẩu thành công!`
  String get success_reset_password {
    return Intl.message(
      'Chúc mừng quý khách đã thay đổi mật khẩu thành công!',
      name: 'success_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Đừng lo lắng, sử dụng email bạn đã đăng ký để bắt đầu cài đặt mật khẩu mới cho tài khoản nhé.`
  String get forgot_pasword_quote1 {
    return Intl.message(
      'Đừng lo lắng, sử dụng email bạn đã đăng ký để bắt đầu cài đặt mật khẩu mới cho tài khoản nhé.',
      name: 'forgot_pasword_quote1',
      desc: '',
      args: [],
    );
  }

  /// `TƯƠNG LAI SÁNG TẠO`
  String get loading_quote2 {
    return Intl.message(
      'TƯƠNG LAI SÁNG TẠO',
      name: 'loading_quote2',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại mã?`
  String get Send_the_code_again {
    return Intl.message(
      'Gửi lại mã?',
      name: 'Send_the_code_again',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái lệnh`
  String get Command_status {
    return Intl.message(
      'Trạng thái lệnh',
      name: 'Command_status',
      desc: '',
      args: [],
    );
  }

  /// `Sai mã OTP`
  String get wrong_otp {
    return Intl.message(
      'Sai mã OTP',
      name: 'wrong_otp',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực tài khoản - eKYC`
  String get eKYC_quote {
    return Intl.message(
      'Xác thực tài khoản - eKYC',
      name: 'eKYC_quote',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch chứng khoán`
  String get stock_trade {
    return Intl.message(
      'Giao dịch chứng khoán',
      name: 'stock_trade',
      desc: '',
      args: [],
    );
  }

  /// `Công cụ phân tích`
  String get analysis_tools {
    return Intl.message(
      'Công cụ phân tích',
      name: 'analysis_tools',
      desc: '',
      args: [],
    );
  }

  /// `Thực hiện quyền`
  String get exercise_right {
    return Intl.message(
      'Thực hiện quyền',
      name: 'exercise_right',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển chứng khoán`
  String get transfer_stock {
    return Intl.message(
      'Chuyển chứng khoán',
      name: 'transfer_stock',
      desc: '',
      args: [],
    );
  }

  /// `Sao kê tài khoản`
  String get account_statement {
    return Intl.message(
      'Sao kê tài khoản',
      name: 'account_statement',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn mã CK`
  String get Please_select_a_stock_code {
    return Intl.message(
      'Vui lòng chọn mã CK',
      name: 'Please_select_a_stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Ngày thành lập`
  String get Foundation_Day {
    return Intl.message(
      'Ngày thành lập',
      name: 'Foundation_Day',
      desc: '',
      args: [],
    );
  }

  /// `Mã số thuế`
  String get Tax_code {
    return Intl.message(
      'Mã số thuế',
      name: 'Tax_code',
      desc: '',
      args: [],
    );
  }

  /// `Tên viết tắt`
  String get Abbreviated_name {
    return Intl.message(
      'Tên viết tắt',
      name: 'Abbreviated_name',
      desc: '',
      args: [],
    );
  }

  /// `Người đại diện`
  String get Agent {
    return Intl.message(
      'Người đại diện',
      name: 'Agent',
      desc: '',
      args: [],
    );
  }

  /// `Giá thấp nhất`
  String get Lowest_price {
    return Intl.message(
      'Giá thấp nhất',
      name: 'Lowest_price',
      desc: '',
      args: [],
    );
  }

  /// `Giá cao nhất`
  String get Highest_price {
    return Intl.message(
      'Giá cao nhất',
      name: 'Highest_price',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch đầu tư nước ngoài`
  String get Foreign_investor_transaction {
    return Intl.message(
      'Giao dịch đầu tư nước ngoài',
      name: 'Foreign_investor_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách bot`
  String get Bot_list {
    return Intl.message(
      'Danh sách bot',
      name: 'Bot_list',
      desc: '',
      args: [],
    );
  }

  /// `Bắt đầu`
  String get Start {
    return Intl.message(
      'Bắt đầu',
      name: 'Start',
      desc: '',
      args: [],
    );
  }

  /// `Rủi ro tối đa`
  String get Maximum_risk {
    return Intl.message(
      'Rủi ro tối đa',
      name: 'Maximum_risk',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục của bạn`
  String get Your_portfolio {
    return Intl.message(
      'Danh mục của bạn',
      name: 'Your_portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch tự động`
  String get Automated_trading {
    return Intl.message(
      'Giao dịch tự động',
      name: 'Automated_trading',
      desc: '',
      args: [],
    );
  }

  /// `Lưu bộ lọc`
  String get Save_filter {
    return Intl.message(
      'Lưu bộ lọc',
      name: 'Save_filter',
      desc: '',
      args: [],
    );
  }

  /// `Tên bộ lọc`
  String get Filter_name {
    return Intl.message(
      'Tên bộ lọc',
      name: 'Filter_name',
      desc: '',
      args: [],
    );
  }

  /// `Bộ lọc của tôi`
  String get My_filters {
    return Intl.message(
      'Bộ lọc của tôi',
      name: 'My_filters',
      desc: '',
      args: [],
    );
  }

  /// `Tính năng đang phát triển`
  String get developing_feature {
    return Intl.message(
      'Tính năng đang phát triển',
      name: 'developing_feature',
      desc: '',
      args: [],
    );
  }

  /// `Dễ dàng tìm kiếm ý tưởng đầu tư bằng bộ lọc cổ phiếu`
  String get Easily_find_investment_ideas_using_stock_filters {
    return Intl.message(
      'Dễ dàng tìm kiếm ý tưởng đầu tư bằng bộ lọc cổ phiếu',
      name: 'Easily_find_investment_ideas_using_stock_filters',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn dùng tài khoản khác ?`
  String get Are_you_sure_you_want_to_use_a_different_account {
    return Intl.message(
      'Bạn có chắc chắn muốn dùng tài khoản khác ?',
      name: 'Are_you_sure_you_want_to_use_a_different_account',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xoá tài khoản này?`
  String get are_you_sure_to_delete_this_account {
    return Intl.message(
      'Bạn có chắc chắn muốn xoá tài khoản này?',
      name: 'are_you_sure_to_delete_this_account',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get try_again {
    return Intl.message(
      'Thử lại',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Khối ngoại mua ròng theo ngành`
  String get Foreign_net_buying_by_sector {
    return Intl.message(
      'Khối ngoại mua ròng theo ngành',
      name: 'Foreign_net_buying_by_sector',
      desc: '',
      args: [],
    );
  }

  /// `Tìm theo mã cổ phiếu`
  String get Search_by_stock_code {
    return Intl.message(
      'Tìm theo mã cổ phiếu',
      name: 'Search_by_stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Hủy bỏ`
  String get abort {
    return Intl.message(
      'Hủy bỏ',
      name: 'abort',
      desc: '',
      args: [],
    );
  }

  /// `Cá nhân`
  String get person {
    return Intl.message(
      'Cá nhân',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử`
  String get history {
    return Intl.message(
      'Lịch sử',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Lệnh mở`
  String get Open_command {
    return Intl.message(
      'Lệnh mở',
      name: 'Open_command',
      desc: '',
      args: [],
    );
  }

  /// `Lệnh đóng`
  String get Close_command {
    return Intl.message(
      'Lệnh đóng',
      name: 'Close_command',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết kl`
  String get Detailed_Mass {
    return Intl.message(
      'Chi tiết kl',
      name: 'Detailed_Mass',
      desc: '',
      args: [],
    );
  }

  /// `Đã đóng`
  String get closed {
    return Intl.message(
      'Đã đóng',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Tổng cộng`
  String get Total {
    return Intl.message(
      'Tổng cộng',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất`
  String get Interest_rate {
    return Intl.message(
      'Lãi suất',
      name: 'Interest_rate',
      desc: '',
      args: [],
    );
  }

  /// `Ngày hết hạn`
  String get Expiration_date {
    return Intl.message(
      'Ngày hết hạn',
      name: 'Expiration_date',
      desc: '',
      args: [],
    );
  }

  /// `Lãi`
  String get Profit {
    return Intl.message(
      'Lãi',
      name: 'Profit',
      desc: '',
      args: [],
    );
  }

  /// `Ngày vay`
  String get Loan_date {
    return Intl.message(
      'Ngày vay',
      name: 'Loan_date',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tính lãi`
  String get Interest_calculation_date {
    return Intl.message(
      'Ngày tính lãi',
      name: 'Interest_calculation_date',
      desc: '',
      args: [],
    );
  }

  /// `Số ngày vay`
  String get Loan_duration {
    return Intl.message(
      'Số ngày vay',
      name: 'Loan_duration',
      desc: '',
      args: [],
    );
  }

  /// `Dư nợ gốc`
  String get Principal_balance {
    return Intl.message(
      'Dư nợ gốc',
      name: 'Principal_balance',
      desc: '',
      args: [],
    );
  }

  /// `Đã trả`
  String get Repaid {
    return Intl.message(
      'Đã trả',
      name: 'Repaid',
      desc: '',
      args: [],
    );
  }

  /// `Nợ còn lại`
  String get Outstanding_debt {
    return Intl.message(
      'Nợ còn lại',
      name: 'Outstanding_debt',
      desc: '',
      args: [],
    );
  }

  /// `Tổng nợ còn lại`
  String get Total_remaining_debt {
    return Intl.message(
      'Tổng nợ còn lại',
      name: 'Total_remaining_debt',
      desc: '',
      args: [],
    );
  }

  /// `Tổng lãi`
  String get Total_interest {
    return Intl.message(
      'Tổng lãi',
      name: 'Total_interest',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị TB`
  String get avg_value {
    return Intl.message(
      'Giá trị TB',
      name: 'avg_value',
      desc: '',
      args: [],
    );
  }

  /// `Phát sinh tăng/giảm`
  String get increase_decrease_occurred {
    return Intl.message(
      'Phát sinh tăng/giảm',
      name: 'increase_decrease_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Thành công`
  String get success {
    return Intl.message(
      'Thành công',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký sinh Smart OTP thành công.`
  String get successful_registration_for_smart_otp_generation {
    return Intl.message(
      'Đăng ký sinh Smart OTP thành công.',
      name: 'successful_registration_for_smart_otp_generation',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực cài đặt`
  String get verification_of_installation {
    return Intl.message(
      'Xác thực cài đặt',
      name: 'verification_of_installation',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu SmartOTP`
  String get re_enter_smartOTP_password {
    return Intl.message(
      'Nhập lại mật khẩu SmartOTP',
      name: 're_enter_smartOTP_password',
      desc: '',
      args: [],
    );
  }

  /// ` Nhập lại mật khẩu 6 chữ số`
  String get re_enter_6_digit_password {
    return Intl.message(
      ' Nhập lại mật khẩu 6 chữ số',
      name: 're_enter_6_digit_password',
      desc: '',
      args: [],
    );
  }

  /// `Quý khách vui lòng ghi nhớ mật khẩu SmartOTP`
  String get please_remember_your_smartOTP_password {
    return Intl.message(
      'Quý khách vui lòng ghi nhớ mật khẩu SmartOTP',
      name: 'please_remember_your_smartOTP_password',
      desc: '',
      args: [],
    );
  }

  /// `Thiết lập SmartOTP`
  String get setting_up_smartOTP {
    return Intl.message(
      'Thiết lập SmartOTP',
      name: 'setting_up_smartOTP',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký SmartOTP`
  String get registering_for_smartOTP {
    return Intl.message(
      'Đăng ký SmartOTP',
      name: 'registering_for_smartOTP',
      desc: '',
      args: [],
    );
  }

  /// `Số dư đầu kỳ`
  String get opening_balance {
    return Intl.message(
      'Số dư đầu kỳ',
      name: 'opening_balance',
      desc: '',
      args: [],
    );
  }

  /// `Số dư cuối kỳ`
  String get closing_balance {
    return Intl.message(
      'Số dư cuối kỳ',
      name: 'closing_balance',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị vay`
  String get loan_amount {
    return Intl.message(
      'Giá trị vay',
      name: 'loan_amount',
      desc: '',
      args: [],
    );
  }

  /// `Lãi vay`
  String get loan_interest {
    return Intl.message(
      'Lãi vay',
      name: 'loan_interest',
      desc: '',
      args: [],
    );
  }

  /// `Giá trị danh mục`
  String get portfolio_value {
    return Intl.message(
      'Giá trị danh mục',
      name: 'portfolio_value',
      desc: '',
      args: [],
    );
  }

  /// `Tiền tạm giữ`
  String get held_funds {
    return Intl.message(
      'Tiền tạm giữ',
      name: 'held_funds',
      desc: '',
      args: [],
    );
  }

  /// `Có thể đăng ký`
  String get you_can_register {
    return Intl.message(
      'Có thể đăng ký',
      name: 'you_can_register',
      desc: '',
      args: [],
    );
  }

  /// `Tích lũy tự động`
  String get automatic_accumulation {
    return Intl.message(
      'Tích lũy tự động',
      name: 'automatic_accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Tích lũy ngắn hạn`
  String get short_term_accumulation {
    return Intl.message(
      'Tích lũy ngắn hạn',
      name: 'short_term_accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Gói tích lũy tự động cập nhật dựa trên số dư tiền đạt hạn mức sản phẩm vào cuối ngày giao dịch.`
  String get accumulation_quote1 {
    return Intl.message(
      'Gói tích lũy tự động cập nhật dựa trên số dư tiền đạt hạn mức sản phẩm vào cuối ngày giao dịch.',
      name: 'accumulation_quote1',
      desc: '',
      args: [],
    );
  }

  /// `Số dư tiền bao gồm tiền mặt và tiền bán trong ngày chờ về.`
  String get accumulation_quote2 {
    return Intl.message(
      'Số dư tiền bao gồm tiền mặt và tiền bán trong ngày chờ về.',
      name: 'accumulation_quote2',
      desc: '',
      args: [],
    );
  }

  /// `Số dư tích lũy được tự động tính vào sức mua.`
  String get accumulation_quote3 {
    return Intl.message(
      'Số dư tích lũy được tự động tính vào sức mua.',
      name: 'accumulation_quote3',
      desc: '',
      args: [],
    );
  }

  /// `Tiền tích lũy đã sử dụng cho giao dịch cổ phiếu được tất toán với lãi suất trước hạn.`
  String get accumulation_quote4 {
    return Intl.message(
      'Tiền tích lũy đã sử dụng cho giao dịch cổ phiếu được tất toán với lãi suất trước hạn.',
      name: 'accumulation_quote4',
      desc: '',
      args: [],
    );
  }

  /// `Không thể đăng ký`
  String get you_cannot_register {
    return Intl.message(
      'Không thể đăng ký',
      name: 'you_cannot_register',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin quyền`
  String get permission_information {
    return Intl.message(
      'Thông tin quyền',
      name: 'permission_information',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký quyền mua`
  String get register_the_right_to_buy {
    return Intl.message(
      'Đăng ký quyền mua',
      name: 'register_the_right_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử quyền`
  String get purchase_rights_history {
    return Intl.message(
      'Lịch sử quyền',
      name: 'purchase_rights_history',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái`
  String get status {
    return Intl.message(
      'Trạng thái',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Giá mua`
  String get purchase_price {
    return Intl.message(
      'Giá mua',
      name: 'purchase_price',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền được nhận`
  String get amount_received {
    return Intl.message(
      'Số tiền được nhận',
      name: 'amount_received',
      desc: '',
      args: [],
    );
  }

  /// `Loại quyền`
  String get rights_type {
    return Intl.message(
      'Loại quyền',
      name: 'rights_type',
      desc: '',
      args: [],
    );
  }

  /// `Chia sẻ suy nghĩ của bạn hoặc đặt câu hỏi cho cộng đồng`
  String get share_your_thoughts {
    return Intl.message(
      'Chia sẻ suy nghĩ của bạn hoặc đặt câu hỏi cho cộng đồng',
      name: 'share_your_thoughts',
      desc: '',
      args: [],
    );
  }

  /// `Đăng`
  String get post {
    return Intl.message(
      'Đăng',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Hãy nhập nội dung bài đăng`
  String get please_enter_the_content_of_the_post {
    return Intl.message(
      'Hãy nhập nội dung bài đăng',
      name: 'please_enter_the_content_of_the_post',
      desc: '',
      args: [],
    );
  }

  /// `Tạo bài viết`
  String get create_a_post {
    return Intl.message(
      'Tạo bài viết',
      name: 'create_a_post',
      desc: '',
      args: [],
    );
  }

  /// `Tạo bài viết thành công`
  String get post_created_successfully {
    return Intl.message(
      'Tạo bài viết thành công',
      name: 'post_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Tạo bài viết thất bại, hãy thử lại`
  String get post_creation_failed {
    return Intl.message(
      'Tạo bài viết thất bại, hãy thử lại',
      name: 'post_creation_failed',
      desc: '',
      args: [],
    );
  }

  /// `Chọn chủ đề bài đăng`
  String get choose_the_topic {
    return Intl.message(
      'Chọn chủ đề bài đăng',
      name: 'choose_the_topic',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết bài viết`
  String get article_details {
    return Intl.message(
      'Chi tiết bài viết',
      name: 'article_details',
      desc: '',
      args: [],
    );
  }

  /// `Bình luận`
  String get comment {
    return Intl.message(
      'Bình luận',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Chia sẻ`
  String get share {
    return Intl.message(
      'Chia sẻ',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Sổ tích luỹ`
  String get accumulator_book {
    return Intl.message(
      'Sổ tích luỹ',
      name: 'accumulator_book',
      desc: '',
      args: [],
    );
  }

  /// `Ngày kết thúc`
  String get end_date {
    return Intl.message(
      'Ngày kết thúc',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tích luỹ`
  String get total_accumulation {
    return Intl.message(
      'Tổng tích luỹ',
      name: 'total_accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Tích lũy hôm nay`
  String get accumulate_today {
    return Intl.message(
      'Tích lũy hôm nay',
      name: 'accumulate_today',
      desc: '',
      args: [],
    );
  }

  /// `Kỳ hạn`
  String get period {
    return Intl.message(
      'Kỳ hạn',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất`
  String get profit {
    return Intl.message(
      'Lãi suất',
      name: 'profit',
      desc: '',
      args: [],
    );
  }

  /// `Các gói tích luỹ hiện tại`
  String get accumulate_current_packages {
    return Intl.message(
      'Các gói tích luỹ hiện tại',
      name: 'accumulate_current_packages',
      desc: '',
      args: [],
    );
  }

  /// `Hạn mức tối thiểu`
  String get minimum_limit {
    return Intl.message(
      'Hạn mức tối thiểu',
      name: 'minimum_limit',
      desc: '',
      args: [],
    );
  }

  /// `Hạn mức tối đa`
  String get maximum_limit {
    return Intl.message(
      'Hạn mức tối đa',
      name: 'maximum_limit',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất trước hạn`
  String get early_interest_rate {
    return Intl.message(
      'Lãi suất trước hạn',
      name: 'early_interest_rate',
      desc: '',
      args: [],
    );
  }

  /// `Phương thức gia hạn`
  String get renewal_method {
    return Intl.message(
      'Phương thức gia hạn',
      name: 'renewal_method',
      desc: '',
      args: [],
    );
  }

  /// `Sản phẩm`
  String get product {
    return Intl.message(
      'Sản phẩm',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Lãi dự tính`
  String get expected_profit {
    return Intl.message(
      'Lãi dự tính',
      name: 'expected_profit',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tiền gốc và lãi`
  String get total_principal_and_interest {
    return Intl.message(
      'Tổng tiền gốc và lãi',
      name: 'total_principal_and_interest',
      desc: '',
      args: [],
    );
  }

  /// `Cộng đồng IFIS thường hay chọn`
  String get the_IFIS_community_often_prefers {
    return Intl.message(
      'Cộng đồng IFIS thường hay chọn',
      name: 'the_IFIS_community_often_prefers',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền gốc`
  String get the_principal_amount {
    return Intl.message(
      'Số tiền gốc',
      name: 'the_principal_amount',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký tích lũy`
  String get registration_for_accumulation {
    return Intl.message(
      'Đăng ký tích lũy',
      name: 'registration_for_accumulation',
      desc: '',
      args: [],
    );
  }

  /// `Tất toán`
  String get final_settlement {
    return Intl.message(
      'Tất toán',
      name: 'final_settlement',
      desc: '',
      args: [],
    );
  }

  /// `Mã tích lũy`
  String get accumulation_code {
    return Intl.message(
      'Mã tích lũy',
      name: 'accumulation_code',
      desc: '',
      args: [],
    );
  }

  /// `Ngày bắt đầu`
  String get start_date {
    return Intl.message(
      'Ngày bắt đầu',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `Số quyền được nhận`
  String get quantity_of_rights_received {
    return Intl.message(
      'Số quyền được nhận',
      name: 'quantity_of_rights_received',
      desc: '',
      args: [],
    );
  }

  /// `Ngày chốt đăng ký`
  String get registration_closing_date {
    return Intl.message(
      'Ngày chốt đăng ký',
      name: 'registration_closing_date',
      desc: '',
      args: [],
    );
  }

  /// `Ngày thực hiện dự kiến`
  String get planned_execution_date {
    return Intl.message(
      'Ngày thực hiện dự kiến',
      name: 'planned_execution_date',
      desc: '',
      args: [],
    );
  }

  /// `Số CP được nhận`
  String get number_of_shares_received {
    return Intl.message(
      'Số CP được nhận',
      name: 'number_of_shares_received',
      desc: '',
      args: [],
    );
  }

  /// `Mã CP được nhận`
  String get received_stock_code {
    return Intl.message(
      'Mã CP được nhận',
      name: 'received_stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Số CP còn được mua`
  String get remaining_shares_available_for_purchase {
    return Intl.message(
      'Số CP còn được mua',
      name: 'remaining_shares_available_for_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Mã CP được mua`
  String get purchased_stock_code {
    return Intl.message(
      'Mã CP được mua',
      name: 'purchased_stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Số CP hưởng quyền`
  String get number_of_shares_entitled {
    return Intl.message(
      'Số CP hưởng quyền',
      name: 'number_of_shares_entitled',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký quyền`
  String get register_the_right {
    return Intl.message(
      'Đăng ký quyền',
      name: 'register_the_right',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền phải nộp`
  String get amount_to_be_paid {
    return Intl.message(
      'Số tiền phải nộp',
      name: 'amount_to_be_paid',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu`
  String get reset_password {
    return Intl.message(
      'Đặt lại mật khẩu',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Rủi ro`
  String get risk {
    return Intl.message(
      'Rủi ro',
      name: 'risk',
      desc: '',
      args: [],
    );
  }

  /// `Phổ biến`
  String get popular {
    return Intl.message(
      'Phổ biến',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Top biến động`
  String get top_changes {
    return Intl.message(
      'Top biến động',
      name: 'top_changes',
      desc: '',
      args: [],
    );
  }

  /// `Top khối lượng`
  String get top_volume {
    return Intl.message(
      'Top khối lượng',
      name: 'top_volume',
      desc: '',
      args: [],
    );
  }

  /// `Quyền mua`
  String get right_to_buy {
    return Intl.message(
      'Quyền mua',
      name: 'right_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `Cổ tức tiền`
  String get cash_dividend {
    return Intl.message(
      'Cổ tức tiền',
      name: 'cash_dividend',
      desc: '',
      args: [],
    );
  }

  /// `Cổ tức bằng CP/CP thưởng`
  String get dividends_value {
    return Intl.message(
      'Cổ tức bằng CP/CP thưởng',
      name: 'dividends_value',
      desc: '',
      args: [],
    );
  }

  /// `Hủy đăng ký`
  String get cancel_registration {
    return Intl.message(
      'Hủy đăng ký',
      name: 'cancel_registration',
      desc: '',
      args: [],
    );
  }

  /// `Danh mục đã tồn tại`
  String get Catalog_already_exists {
    return Intl.message(
      'Danh mục đã tồn tại',
      name: 'Catalog_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Đã có bản cập nhật mới`
  String get there_is_new_update {
    return Intl.message(
      'Đã có bản cập nhật mới',
      name: 'there_is_new_update',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng cập nhật để tiếp tục sử dụng ứng dụng`
  String get update_to_continue {
    return Intl.message(
      'Vui lòng cập nhật để tiếp tục sử dụng ứng dụng',
      name: 'update_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Không có dữ liệu`
  String get no_data {
    return Intl.message(
      'Không có dữ liệu',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Số CP đã đăng ký`
  String get registered_share_volume {
    return Intl.message(
      'Số CP đã đăng ký',
      name: 'registered_share_volume',
      desc: '',
      args: [],
    );
  }

  /// `Lãi hiện tại trước hạn`
  String get current_pre_maturity_interest {
    return Intl.message(
      'Lãi hiện tại trước hạn',
      name: 'current_pre_maturity_interest',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi`
  String get change {
    return Intl.message(
      'Thay đổi',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền đã nộp`
  String get amount_paid {
    return Intl.message(
      'Số tiền đã nộp',
      name: 'amount_paid',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian đăng ký`
  String get registration_time {
    return Intl.message(
      'Thời gian đăng ký',
      name: 'registration_time',
      desc: '',
      args: [],
    );
  }

  /// `Cổ phiếu hưởng quyền`
  String get stock_with_rights {
    return Intl.message(
      'Cổ phiếu hưởng quyền',
      name: 'stock_with_rights',
      desc: '',
      args: [],
    );
  }

  /// `Mã tích lũy`
  String get accumulated_code {
    return Intl.message(
      'Mã tích lũy',
      name: 'accumulated_code',
      desc: '',
      args: [],
    );
  }

  /// `Chọn phương thức gia hạn`
  String get choose_renewal_method {
    return Intl.message(
      'Chọn phương thức gia hạn',
      name: 'choose_renewal_method',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số tiền`
  String get total_amount {
    return Intl.message(
      'Tổng số tiền',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Cần thanh toán`
  String get payment_required {
    return Intl.message(
      'Cần thanh toán',
      name: 'payment_required',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số tiền`
  String get input_the_amount {
    return Intl.message(
      'Nhập số tiền',
      name: 'input_the_amount',
      desc: '',
      args: [],
    );
  }

  /// `Không để trông ô này`
  String get please_fill_in_this_field {
    return Intl.message(
      'Không để trông ô này',
      name: 'please_fill_in_this_field',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận tích lũy`
  String get confirm_savings {
    return Intl.message(
      'Xác nhận tích lũy',
      name: 'confirm_savings',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký thành công!`
  String get successfully_registered {
    return Intl.message(
      'Đăng ký thành công!',
      name: 'successfully_registered',
      desc: '',
      args: [],
    );
  }

  /// `Hủy đăng ký thành công!`
  String get successfully_canceled {
    return Intl.message(
      'Hủy đăng ký thành công!',
      name: 'successfully_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận đăng ký`
  String get confirm_registration {
    return Intl.message(
      'Xác nhận đăng ký',
      name: 'confirm_registration',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận hủy đăng ký`
  String get confirm_cancellation {
    return Intl.message(
      'Xác nhận hủy đăng ký',
      name: 'confirm_cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Có lỗi xảy ra!`
  String get an_error_occurred {
    return Intl.message(
      'Có lỗi xảy ra!',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Quyền truy cập bị từ chối`
  String get permission_denied {
    return Intl.message(
      'Quyền truy cập bị từ chối',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký ngay đừng bỏ lỡ`
  String get sign_up_now_dont_miss_it {
    return Intl.message(
      'Đăng ký ngay đừng bỏ lỡ',
      name: 'sign_up_now_dont_miss_it',
      desc: '',
      args: [],
    );
  }

  /// `Linh hoạt`
  String get flexible {
    return Intl.message(
      'Linh hoạt',
      name: 'flexible',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể bắt đầu bất cứ lúc nào`
  String get you_can_begin_whenever_you_want {
    return Intl.message(
      'Bạn có thể bắt đầu bất cứ lúc nào',
      name: 'you_can_begin_whenever_you_want',
      desc: '',
      args: [],
    );
  }

  /// `Đã đăng ký`
  String get registered {
    return Intl.message(
      'Đã đăng ký',
      name: 'registered',
      desc: '',
      args: [],
    );
  }

  /// `Chưa đăng ký`
  String get not_registered {
    return Intl.message(
      'Chưa đăng ký',
      name: 'not_registered',
      desc: '',
      args: [],
    );
  }

  /// `Số ngày gửi`
  String get number_of_days_sent {
    return Intl.message(
      'Số ngày gửi',
      name: 'number_of_days_sent',
      desc: '',
      args: [],
    );
  }

  /// `Thực nhận`
  String get actually_received {
    return Intl.message(
      'Thực nhận',
      name: 'actually_received',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tất toán `
  String get settlement_date {
    return Intl.message(
      'Ngày tất toán ',
      name: 'settlement_date',
      desc: '',
      args: [],
    );
  }

  /// `Lãi tất toán trước hạn`
  String get interest_paid_off_before_maturity {
    return Intl.message(
      'Lãi tất toán trước hạn',
      name: 'interest_paid_off_before_maturity',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết tất toán`
  String get payment_details {
    return Intl.message(
      'Chi tiết tất toán',
      name: 'payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã hoàn thành đăng ký tích lũy`
  String get you_have_completed_the_cumulative_registration {
    return Intl.message(
      'Bạn đã hoàn thành đăng ký tích lũy',
      name: 'you_have_completed_the_cumulative_registration',
      desc: '',
      args: [],
    );
  }

  /// `Quay lại`
  String get come_back {
    return Intl.message(
      'Quay lại',
      name: 'come_back',
      desc: '',
      args: [],
    );
  }

  /// `Xin vui lòng thử lại`
  String get please_try_again {
    return Intl.message(
      'Xin vui lòng thử lại',
      name: 'please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận tất toán`
  String get payment_confirmation {
    return Intl.message(
      'Xác nhận tất toán',
      name: 'payment_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Night mode`
  String get night_mode {
    return Intl.message(
      'Night mode',
      name: 'night_mode',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa xác thực tài khoản`
  String get you_have_not_verified_your_account {
    return Intl.message(
      'Bạn chưa xác thực tài khoản',
      name: 'you_have_not_verified_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Đề xuất`
  String get propose {
    return Intl.message(
      'Đề xuất',
      name: 'propose',
      desc: '',
      args: [],
    );
  }

  /// `Mới nhất`
  String get latest {
    return Intl.message(
      'Mới nhất',
      name: 'latest',
      desc: '',
      args: [],
    );
  }

  /// `Từ khóa, bài viết, người dùng`
  String get hide_suggest {
    return Intl.message(
      'Từ khóa, bài viết, người dùng',
      name: 'hide_suggest',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối đến thị trường chứng khoán sôi động của IFIS ngay nào!`
  String get connect_with_ifis {
    return Intl.message(
      'Kết nối đến thị trường chứng khoán sôi động của IFIS ngay nào!',
      name: 'connect_with_ifis',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ số phái sinh`
  String get derivative_index {
    return Intl.message(
      'Chỉ số phái sinh',
      name: 'derivative_index',
      desc: '',
      args: [],
    );
  }

  /// `Top mã tự doanh mua ròng`
  String get top_self_trading_stocks {
    return Intl.message(
      'Top mã tự doanh mua ròng',
      name: 'top_self_trading_stocks',
      desc: '',
      args: [],
    );
  }

  /// `Màu xanh trên biểu đồ thể hiện khối tự doanh mua ròng. Màu đỏ thể hiện khối tự doanh bán ròng. Dữ liệu ngày`
  String get suggest_infomation {
    return Intl.message(
      'Màu xanh trên biểu đồ thể hiện khối tự doanh mua ròng. Màu đỏ thể hiện khối tự doanh bán ròng. Dữ liệu ngày',
      name: 'suggest_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Tự doanh`
  String get self_employed {
    return Intl.message(
      'Tự doanh',
      name: 'self_employed',
      desc: '',
      args: [],
    );
  }

  /// `Top mã nước ngoài mua ròng`
  String get top_foreign_stocks_with_net_buying {
    return Intl.message(
      'Top mã nước ngoài mua ròng',
      name: 'top_foreign_stocks_with_net_buying',
      desc: '',
      args: [],
    );
  }

  /// `Màu xanh trên biểu đồ thể hiện khối ngoại mua ròng. Màu đỏ thể hiện khối ngoại bán ròng. Dữ liệu bao gồm cả Cổ phiếu và ETF. Dữ liệu ngày`
  String get suggest_infomation_2 {
    return Intl.message(
      'Màu xanh trên biểu đồ thể hiện khối ngoại mua ròng. Màu đỏ thể hiện khối ngoại bán ròng. Dữ liệu bao gồm cả Cổ phiếu và ETF. Dữ liệu ngày',
      name: 'suggest_infomation_2',
      desc: '',
      args: [],
    );
  }

  /// `Top ảnh hưởng đến INDEX`
  String get top_influence_on_INDEX {
    return Intl.message(
      'Top ảnh hưởng đến INDEX',
      name: 'top_influence_on_INDEX',
      desc: '',
      args: [],
    );
  }

  /// `Tổng lãi/lỗ chưa đóng`
  String get total_unclosed_profit_loss {
    return Intl.message(
      'Tổng lãi/lỗ chưa đóng',
      name: 'total_unclosed_profit_loss',
      desc: '',
      args: [],
    );
  }

  /// `Có top mã cổ phiếu dành cho bạn`
  String get there_are_top_stock_codes_for_you {
    return Intl.message(
      'Có top mã cổ phiếu dành cho bạn',
      name: 'there_are_top_stock_codes_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Đầu tư ngay đừng bỏ lỡ`
  String get invest_now_do_not_miss_it {
    return Intl.message(
      'Đầu tư ngay đừng bỏ lỡ',
      name: 'invest_now_do_not_miss_it',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản liên kết`
  String get affiliate_account {
    return Intl.message(
      'Tài khoản liên kết',
      name: 'affiliate_account',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản Demo`
  String get demo_account {
    return Intl.message(
      'Tài khoản Demo',
      name: 'demo_account',
      desc: '',
      args: [],
    );
  }

  /// `KL có thể bán`
  String get sellable_volume {
    return Intl.message(
      'KL có thể bán',
      name: 'sellable_volume',
      desc: '',
      args: [],
    );
  }

  /// `Top ngành ảnh hưởng đến INDEX`
  String get top_industry_affecting_INDEX {
    return Intl.message(
      'Top ngành ảnh hưởng đến INDEX',
      name: 'top_industry_affecting_INDEX',
      desc: '',
      args: [],
    );
  }

  /// `Biểu đồ thể hiện đóng góp của ngành vào INDEX. Dữ liệu ngày`
  String get the_chart_show {
    return Intl.message(
      'Biểu đồ thể hiện đóng góp của ngành vào INDEX. Dữ liệu ngày',
      name: 'the_chart_show',
      desc: '',
      args: [],
    );
  }

  /// `Ngày chốt`
  String get closing_date {
    return Intl.message(
      'Ngày chốt',
      name: 'closing_date',
      desc: '',
      args: [],
    );
  }

  /// `Hạn chốt ĐK`
  String get registration_deadline {
    return Intl.message(
      'Hạn chốt ĐK',
      name: 'registration_deadline',
      desc: '',
      args: [],
    );
  }

  /// `Còn được mua / tiền phải trả`
  String get still_to_be_purchased_payable {
    return Intl.message(
      'Còn được mua / tiền phải trả',
      name: 'still_to_be_purchased_payable',
      desc: '',
      args: [],
    );
  }

  /// `Tất toán thành công!`
  String get successful_settlement {
    return Intl.message(
      'Tất toán thành công!',
      name: 'successful_settlement',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã hoàn thành tất toán`
  String get you_have_completed_the_payment {
    return Intl.message(
      'Bạn đã hoàn thành tất toán',
      name: 'you_have_completed_the_payment',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn tất toán trước hạn ? `
  String get are_you_sure_you_want_to_pay_off_early {
    return Intl.message(
      'Bạn có chắc chắn muốn tất toán trước hạn ? ',
      name: 'are_you_sure_you_want_to_pay_off_early',
      desc: '',
      args: [],
    );
  }

  /// `Sổ tích lũy`
  String get accumulation_book {
    return Intl.message(
      'Sổ tích lũy',
      name: 'accumulation_book',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get amount_of_money {
    return Intl.message(
      'Số tiền',
      name: 'amount_of_money',
      desc: '',
      args: [],
    );
  }

  /// `Nhập từ`
  String get enter_the_word {
    return Intl.message(
      'Nhập từ',
      name: 'enter_the_word',
      desc: '',
      args: [],
    );
  }

  /// `đến`
  String get to {
    return Intl.message(
      'đến',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `năm`
  String get year {
    return Intl.message(
      'năm',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã xóa sổ đăng ký tự động thành công`
  String get you_have_successfully_deleted_the_auto_registry {
    return Intl.message(
      'Bạn đã xóa sổ đăng ký tự động thành công',
      name: 'you_have_successfully_deleted_the_auto_registry',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã hoàn thành đăng ký tích lũy tự động`
  String get you_have_completed_the_automatic_accrual_registration {
    return Intl.message(
      'Bạn đã hoàn thành đăng ký tích lũy tự động',
      name: 'you_have_completed_the_automatic_accrual_registration',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn hủy đăng ký sản phẩm tích lũy tự động ? `
  String
      get are_you_sure_you_want_to_unsubscribe_from_automatic_accrual_products {
    return Intl.message(
      'Bạn có chắc chắn muốn hủy đăng ký sản phẩm tích lũy tự động ? ',
      name:
          'are_you_sure_you_want_to_unsubscribe_from_automatic_accrual_products',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn đăng ký sản phẩm tích lũy tự động ?`
  String get are_you_sure_you_want_to_sign_up_for_automatic_accrual_products {
    return Intl.message(
      'Bạn có chắc chắn muốn đăng ký sản phẩm tích lũy tự động ?',
      name: 'are_you_sure_you_want_to_sign_up_for_automatic_accrual_products',
      desc: '',
      args: [],
    );
  }

  /// `Tổng lãi/lỗ đã đóng`
  String get total_closed_profit_loss {
    return Intl.message(
      'Tổng lãi/lỗ đã đóng',
      name: 'total_closed_profit_loss',
      desc: '',
      args: [],
    );
  }

  /// `Khám phá`
  String get discover {
    return Intl.message(
      'Khám phá',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Tin tức mỗi ngày`
  String get news_every_day {
    return Intl.message(
      'Tin tức mỗi ngày',
      name: 'news_every_day',
      desc: '',
      args: [],
    );
  }

  /// `Làm mới`
  String get refresh {
    return Intl.message(
      'Làm mới',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Bài đăng mới`
  String get new_post {
    return Intl.message(
      'Bài đăng mới',
      name: 'new_post',
      desc: '',
      args: [],
    );
  }

  /// `Đánh dấu là đã đọc`
  String get mark_as_read {
    return Intl.message(
      'Đánh dấu là đã đọc',
      name: 'mark_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Tất cả thông báo trong mục thông báo?`
  String get all_notifications_in_the_notifications_section {
    return Intl.message(
      'Tất cả thông báo trong mục thông báo?',
      name: 'all_notifications_in_the_notifications_section',
      desc: '',
      args: [],
    );
  }

  /// `Dư mua`
  String get excess_purchase {
    return Intl.message(
      'Dư mua',
      name: 'excess_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Dư bán`
  String get oversold {
    return Intl.message(
      'Dư bán',
      name: 'oversold',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử giao dịch`
  String get transaction_history {
    return Intl.message(
      'Lịch sử giao dịch',
      name: 'transaction_history',
      desc: '',
      args: [],
    );
  }

  /// `Hiệu quả tín hiệu`
  String get signal_efficiency {
    return Intl.message(
      'Hiệu quả tín hiệu',
      name: 'signal_efficiency',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Việt`
  String get vietnamese {
    return Intl.message(
      'Tiếng Việt',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Anh`
  String get english {
    return Intl.message(
      'Tiếng Anh',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ qua`
  String get skip {
    return Intl.message(
      'Bỏ qua',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng bạn tới với ứng dụng IFIS.`
  String get welcome_overlay_qoute1 {
    return Intl.message(
      'Chào mừng bạn tới với ứng dụng IFIS.',
      name: 'welcome_overlay_qoute1',
      desc: '',
      args: [],
    );
  }

  /// `Hãy để chúng tôi giới thiệu một vài chức năng cơ bản tới bạn.`
  String get welcome_overlay_qoute2 {
    return Intl.message(
      'Hãy để chúng tôi giới thiệu một vài chức năng cơ bản tới bạn.',
      name: 'welcome_overlay_qoute2',
      desc: '',
      args: [],
    );
  }

  /// `Để đặt lệnh chứng khoán, hãy nhấn vào đây, nhưng trước tiên bạn phải đăng nhập vào tài khoản`
  String get tour_guide1 {
    return Intl.message(
      'Để đặt lệnh chứng khoán, hãy nhấn vào đây, nhưng trước tiên bạn phải đăng nhập vào tài khoản',
      name: 'tour_guide1',
      desc: '',
      args: [],
    );
  }

  /// `Bảng chứa các chỉ số cơ bản của một mã chứng khoán`
  String get tour_guide2 {
    return Intl.message(
      'Bảng chứa các chỉ số cơ bản của một mã chứng khoán',
      name: 'tour_guide2',
      desc: '',
      args: [],
    );
  }

  /// `Sức mua tài khoản của bạn và số lượng tối đa mã chứng khoán hiện tại bạn có thể mua/bán`
  String get tour_guide3 {
    return Intl.message(
      'Sức mua tài khoản của bạn và số lượng tối đa mã chứng khoán hiện tại bạn có thể mua/bán',
      name: 'tour_guide3',
      desc: '',
      args: [],
    );
  }

  /// `Các loại giá có bạn có thể đặt cho mã hiện tại`
  String get tour_guide4 {
    return Intl.message(
      'Các loại giá có bạn có thể đặt cho mã hiện tại',
      name: 'tour_guide4',
      desc: '',
      args: [],
    );
  }

  /// `Tỷ lệ ký quỹ cho lệnh mua mã chứng khoán hiện tại. Click để chọn`
  String get tour_guide5 {
    return Intl.message(
      'Tỷ lệ ký quỹ cho lệnh mua mã chứng khoán hiện tại. Click để chọn',
      name: 'tour_guide5',
      desc: '',
      args: [],
    );
  }

  /// `Sửa giá và khối lượng theo ý của bạn`
  String get tour_guide6 {
    return Intl.message(
      'Sửa giá và khối lượng theo ý của bạn',
      name: 'tour_guide6',
      desc: '',
      args: [],
    );
  }

  /// `Cuối cùng, chọn đặt lệnh mua hoặc lệnh bán`
  String get tour_guide7 {
    return Intl.message(
      'Cuối cùng, chọn đặt lệnh mua hoặc lệnh bán',
      name: 'tour_guide7',
      desc: '',
      args: [],
    );
  }

  /// `Kết thúc`
  String get end {
    return Intl.message(
      'Kết thúc',
      name: 'end',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
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
