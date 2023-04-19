import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';

class BaseMarginAccountModel extends IAccountModel {
  ///Account Info
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

  List<UnexecutedRightModel> get listUnexecutedBuyRight {
    if (listUnexecutedRight?.isEmpty ?? true) {
      return [];
    }
    final List<UnexecutedRightModel> result = [];
    for (var right in listUnexecutedRight!) {
      if (right.cRIGHTBUYFLAG != 0) {
        result.add(right);
      }
    }
    return result;
  }

  BaseMarginAccountModel.fromJson(Map<String, dynamic> json)
      : super(accCode: json['accCode']) {
    accName = json['accName'];
    accType = json['accType'];
    type = json['type'];
    authen = json['authen'];
    serial = json['serial'];
  }

  @override
  void updateDataFromJson(IAccountResponse? jsonData) {
    if (jsonData != null) {
      assets = parse(jsonData.json['assets']);
      imKH = parse(jsonData.json['imKH']);
      h = parse(jsonData.json['h']);
      equity = parse(jsonData.json['equity']);
      cashBalance = parse(jsonData.json['cash_balance']);
      collateral = parse(jsonData.json['collateral']);
      lmv = parse(jsonData.json['lmv']);
      lmv0 = parse(jsonData.json['lmv_0']);
      debt = parse(jsonData.json['debt']);
      ee = parse(jsonData.json['ee']);
      ee50 = parse(jsonData.json['ee_50']);
      ee60 = parse(jsonData.json['ee_60']);
      ee70 = parse(jsonData.json['ee_70']);
      mr = parse(jsonData.json['mr']);
      mrEe = parse(jsonData.json['mr_ee']);
      sumAp = parse(jsonData.json['sum_ap']);
      withdraw = parse(jsonData.json['withdraw']);
      debtExpire = parse(jsonData.json['debtExpire']);
      withdrawalCash = parse(jsonData.json['withdrawal_cash']);
      withdrawalFull = parse(jsonData.json['withdrawal_full']);
      overDraft = parse(jsonData.json['overDraft']);
      withdrawal = parse(jsonData.json['withdrawal']);
      cashAvai = parse(jsonData.json['cash_avai']);
      withdrawalEe = parse(jsonData.json['withdrawal_ee']);
      imKh = parse(jsonData.json['im_kh']);
      tempEe = parse(jsonData.json['temp_ee']);
      marginRatio = parse(jsonData.json['margin_ratio']);
      marginRatioUb = parse(jsonData.json['margin_ratio_ub']);
      assetsUb = parse(jsonData.json['assets_ub']);
      buyUnmatch = parse(jsonData.json['buy_unmatch']);
      buyMr = parse(jsonData.json['buy_mr']);
      sellUnmatch = parse(jsonData.json['sell_unmatch']);
      service = parse(jsonData.json['service']);
      action = parse(jsonData.json['action']);
      callLmv = parse(jsonData.json['call_lmv']);
      sellLmv = parse(jsonData.json['sell_lmv']);
      apT0 = parse(jsonData.json['ap_t0']);
      apT1 = parse(jsonData.json['ap_t1']);
      apT2 = parse(jsonData.json['ap_t2']);
      arT0 = parse(jsonData.json['ar_t0']);
      arT1 = parse(jsonData.json['ar_t1']);
      arT2 = parse(jsonData.json['ar_t2']);
      loanFee = parse(jsonData.json['loan_fee']);
      a1 = parse(jsonData.json['a1']);
      a3 = parse(jsonData.json['a3']);
      a2 = parse(jsonData.json['a2']);
      a4 = parse(jsonData.json['a4']);
      a5 = parse(jsonData.json['a5']);
      a6 = parse(jsonData.json['a6']);
      a7 = parse(jsonData.json['a7']);
      eeIncApp = parse(jsonData.json['ee_inc_app']);
      temp2 = parse(jsonData.json['temp2']);
      cashBlock = parse(jsonData.json['cash_block']);
      cashTempDayOut = parse(jsonData.json['cash_temp_day_out']);
      depositFee = parse(jsonData.json['deposit_fee']);
      tdck = parse(jsonData.json['tdck']);
      totalAsset = parse(jsonData.json['total_asset']);
      totalEquity = parse(jsonData.json['total_equity']);
      cashAdvanceAvai = parse(jsonData.json['cash_advance_avai']);
      maxRate = parse(jsonData.json['max_rate']);
      group = parse(jsonData.json['group']);
      payment = parse(jsonData.json['payment']);
      totalMarket = parse(jsonData.json['total_market']);
      totalCost = parse(jsonData.json['total_cost']);
    }
  }

  num? parse(String string) {
    return num.tryParse(string);
  }
}
