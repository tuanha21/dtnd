import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';

class BaseNormalAccountModel implements IAccountModel {
  ///Account Info
  @override
  late final String accCode;
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

  @override
  PortfolioStatus? portfolioStatus;

  @override
  List<AssetChartElementModel>? listAssetChart;

  List<UnexecutedRightModel>? listUnexecutedRight;

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

  BaseNormalAccountModel.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accName = json['accName'];
    accType = json['accType'];
    type = json['type'];
    authen = json['authen'];
    serial = json['serial'];
  }

  @override
  void updateDataFromJson(IAccountResponse data) {
    cashBalance = parse(data.json['cash_balance']);
    debt = parse(data.json['debt']);
    cashAvai = parse(data.json['cash_avai']);
    withdrawalCash = parse(data.json['withdrawal_cash']);
    withdrawalEe = parse(data.json['withdrawal_ee']);
    payment = parse(data.json['payment']);
    tempEe = parse(data.json['temp_ee']);
    apT0 = parse(data.json['ap_t0']);
    apT1 = parse(data.json['ap_t1']);
    apT2 = parse(data.json['ap_t2']);
    arT0 = parse(data.json['ar_t0']);
    arT1 = parse(data.json['ar_t1']);
    arT2 = parse(data.json['ar_t2']);
    collateral = parse(data.json['collateral']);
    sellUnmatch = parse(data.json['sell_unmatch']);
    buyUnmatch = parse(data.json['buy_unmatch']);
    cashBlock = parse(data.json['cash_block']);
    sumAp = parse(data.json['sum_ap']);
    withdraw = parse(data.json['withdraw']);
    depositFee = parse(data.json['deposit_fee']);
    tempeeUsed = parse(data.json['tempee_used']);
    tempeeUsing = parse(data.json['tempee_using']);
    assets = parse(data.json['assets']);
    cashAdvanceAvai = parse(data.json['cash_advance_avai']);
    avaiColla = parse(data.json['avaiColla']);
    cashInout = parse(data.json['cash_inout']);
    cashTempDayOut = parse(data.json['cash_temp_day_out']);
    vsd = parse(data.json['vsd']);
    totalMarket = parse(data.json['total_market']);
    totalCost = parse(data.json['total_cost']);
  }

  num? parse(String string) {
    return num.tryParse(string);
  }
}
