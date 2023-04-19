import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';

class BaseNormalAccountModel extends IAccountModel {
  ///Account Info
  String? accName;
  String? accType;
  String? type;
  String? authen;
  String? serial;

  /// Account Status
  num? cashBalance;
  num? debt;
  num? cashAvai;
  num? withdrawalCash;
  num? withdrawalEe;
  num? payment;
  num? tempEe;
  num? apT0;
  num? apT1;
  num? apT2;
  num? arT0;
  num? arT1;
  num? arT2;
  num? collateral;
  num? sellUnmatch;
  num? buyUnmatch;
  num? cashBlock;
  num? sumAp;
  num? withdraw;
  num? depositFee;
  num? tempeeUsed;
  num? tempeeUsing;
  num? assets;
  num? cashAdvanceAvai;
  num? avaiColla;
  num? cashInout;
  num? cashTempDayOut;
  num? vsd;
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

  BaseNormalAccountModel.fromJson(Map<String, dynamic> json)
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
      cashBalance = parse(jsonData.json['cash_balance']);
      debt = parse(jsonData.json['debt']);
      cashAvai = parse(jsonData.json['cash_avai']);
      withdrawalCash = parse(jsonData.json['withdrawal_cash']);
      withdrawalEe = parse(jsonData.json['withdrawal_ee']);
      payment = parse(jsonData.json['payment']);
      tempEe = parse(jsonData.json['temp_ee']);
      apT0 = parse(jsonData.json['ap_t0']);
      apT1 = parse(jsonData.json['ap_t1']);
      apT2 = parse(jsonData.json['ap_t2']);
      arT0 = parse(jsonData.json['ar_t0']);
      arT1 = parse(jsonData.json['ar_t1']);
      arT2 = parse(jsonData.json['ar_t2']);
      collateral = parse(jsonData.json['collateral']);
      sellUnmatch = parse(jsonData.json['sell_unmatch']);
      buyUnmatch = parse(jsonData.json['buy_unmatch']);
      cashBlock = parse(jsonData.json['cash_block']);
      sumAp = parse(jsonData.json['sum_ap']);
      withdraw = parse(jsonData.json['withdraw']);
      depositFee = parse(jsonData.json['deposit_fee']);
      tempeeUsed = parse(jsonData.json['tempee_used']);
      tempeeUsing = parse(jsonData.json['tempee_using']);
      assets = parse(jsonData.json['assets']);
      cashAdvanceAvai = parse(jsonData.json['cash_advance_avai']);
      avaiColla = parse(jsonData.json['avaiColla']);
      cashInout = parse(jsonData.json['cash_inout']);
      cashTempDayOut = parse(jsonData.json['cash_temp_day_out']);
      vsd = parse(jsonData.json['vsd']);
      totalMarket = parse(jsonData.json['total_market']);
      totalCost = parse(jsonData.json['total_cost']);
    }
  }

  num? parse(String string) {
    return num.tryParse(string);
  }
}
