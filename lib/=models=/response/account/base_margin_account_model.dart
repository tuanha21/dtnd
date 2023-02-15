import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/utilities/logger.dart';

import 'portfolio_status_model.dart';

class BaseMarginAccountModel implements IAccountModel {
  ///Account Info
  @override
  late final String accCode;
  String? accName;
  String? accType;
  String? type;
  String? authen;
  String? serial;

  /// Account Status
  num? assets;
  num? imKH;
  num? h;
  num? equity;
  num? cashBalance;
  num? collateral;
  num? lmv;
  num? lmv0;
  num? debt;
  num? ee;
  num? ee50;
  num? ee60;
  num? ee70;
  num? mr;
  num? mrEe;
  num? sumAp;
  num? withdraw;
  num? debtExpire;
  num? withdrawalCash;
  num? withdrawalFull;
  num? overDraft;
  num? withdrawal;
  num? cashAvai;
  num? withdrawalEe;
  num? imKh;
  num? tempEe;
  num? marginRatio;
  num? marginRatioUb;
  num? assetsUb;
  num? buyUnmatch;
  num? buyMr;
  num? sellUnmatch;
  num? service;
  num? action;
  num? callLmv;
  num? sellLmv;
  num? apT0;
  num? apT1;
  num? apT2;
  num? arT0;
  num? arT1;
  num? arT2;
  num? loanFee;
  num? a1;
  num? a3;
  num? a2;
  num? a4;
  num? a5;
  num? a6;
  num? a7;
  num? eeIncApp;
  num? temp2;
  num? cashBlock;
  num? cashTempDayOut;
  num? depositFee;
  num? tdck;
  num? totalAsset;
  num? totalEquity;
  num? cashAdvanceAvai;
  num? maxRate;
  num? group;
  num? payment;
  num? totalMarket;
  num? totalCost;

  @override
  PortfolioStatus? portfolioStatus;

  BaseMarginAccountModel(
      {this.assets,
      this.imKH,
      this.h,
      this.equity,
      this.cashBalance,
      this.collateral,
      this.lmv,
      this.lmv0,
      this.debt,
      this.ee,
      this.ee50,
      this.ee60,
      this.ee70,
      this.mr,
      this.mrEe,
      this.sumAp,
      this.withdraw,
      this.debtExpire,
      this.withdrawalCash,
      this.withdrawalFull,
      this.overDraft,
      this.withdrawal,
      this.cashAvai,
      this.withdrawalEe,
      this.imKh,
      this.tempEe,
      this.marginRatio,
      this.marginRatioUb,
      this.assetsUb,
      this.buyUnmatch,
      this.buyMr,
      this.sellUnmatch,
      this.service,
      this.action,
      this.callLmv,
      this.sellLmv,
      this.apT0,
      this.apT1,
      this.apT2,
      this.arT0,
      this.arT1,
      this.arT2,
      this.loanFee,
      this.a1,
      this.a3,
      this.a2,
      this.a4,
      this.a5,
      this.a6,
      this.a7,
      this.eeIncApp,
      this.temp2,
      this.cashBlock,
      this.cashTempDayOut,
      this.depositFee,
      this.tdck,
      this.totalAsset,
      this.totalEquity,
      this.cashAdvanceAvai,
      this.maxRate,
      this.group,
      this.payment,
      this.totalMarket,
      this.totalCost});

  BaseMarginAccountModel.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accName = json['accName'];
    accType = json['accType'];
    type = json['type'];
    authen = json['authen'];
    serial = json['serial'];
  }

  @override
  void updateData(IAccountResponse data) {
    logger.v(data.json);
    assets = parse(data.json['assets']);
    imKH = parse(data.json['imKH']);
    h = parse(data.json['h']);
    equity = parse(data.json['equity']);
    cashBalance = parse(data.json['cash_balance']);
    collateral = parse(data.json['collateral']);
    lmv = parse(data.json['lmv']);
    lmv0 = parse(data.json['lmv_0']);
    debt = parse(data.json['debt']);
    ee = parse(data.json['ee']);
    ee50 = parse(data.json['ee_50']);
    ee60 = parse(data.json['ee_60']);
    ee70 = parse(data.json['ee_70']);
    mr = parse(data.json['mr']);
    mrEe = parse(data.json['mr_ee']);
    sumAp = parse(data.json['sum_ap']);
    withdraw = parse(data.json['withdraw']);
    debtExpire = parse(data.json['debtExpire']);
    withdrawalCash = parse(data.json['withdrawal_cash']);
    withdrawalFull = parse(data.json['withdrawal_full']);
    overDraft = parse(data.json['overDraft']);
    withdrawal = parse(data.json['withdrawal']);
    cashAvai = parse(data.json['cash_avai']);
    withdrawalEe = parse(data.json['withdrawal_ee']);
    imKh = parse(data.json['im_kh']);
    tempEe = parse(data.json['temp_ee']);
    marginRatio = parse(data.json['margin_ratio']);
    marginRatioUb = parse(data.json['margin_ratio_ub']);
    assetsUb = parse(data.json['assets_ub']);
    buyUnmatch = parse(data.json['buy_unmatch']);
    buyMr = parse(data.json['buy_mr']);
    sellUnmatch = parse(data.json['sell_unmatch']);
    service = parse(data.json['service']);
    action = parse(data.json['action']);
    callLmv = parse(data.json['call_lmv']);
    sellLmv = parse(data.json['sell_lmv']);
    apT0 = parse(data.json['ap_t0']);
    apT1 = parse(data.json['ap_t1']);
    apT2 = parse(data.json['ap_t2']);
    arT0 = parse(data.json['ar_t0']);
    arT1 = parse(data.json['ar_t1']);
    arT2 = parse(data.json['ar_t2']);
    loanFee = parse(data.json['loan_fee']);
    a1 = parse(data.json['a1']);
    a3 = parse(data.json['a3']);
    a2 = parse(data.json['a2']);
    a4 = parse(data.json['a4']);
    a5 = parse(data.json['a5']);
    a6 = parse(data.json['a6']);
    a7 = parse(data.json['a7']);
    eeIncApp = parse(data.json['ee_inc_app']);
    temp2 = parse(data.json['temp2']);
    cashBlock = parse(data.json['cash_block']);
    cashTempDayOut = parse(data.json['cash_temp_day_out']);
    depositFee = parse(data.json['deposit_fee']);
    tdck = parse(data.json['tdck']);
    totalAsset = parse(data.json['total_asset']);
    totalEquity = parse(data.json['total_equity']);
    cashAdvanceAvai = parse(data.json['cash_advance_avai']);
    maxRate = parse(data.json['max_rate']);
    group = parse(data.json['group']);
    payment = parse(data.json['payment']);
    totalMarket = parse(data.json['total_market']);
    totalCost = parse(data.json['total_cost']);
  }

  num? parse(String string) {
    return num.tryParse(string);
  }
}

class BaseMarginAccountResponse implements IAccountResponse {
  @override
  late final Map<String, dynamic> json;

  BaseMarginAccountResponse.fromJson(this.json);

  num? parse(String string) {
    return num.tryParse(string);
  }
}