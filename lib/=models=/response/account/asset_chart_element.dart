import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/utilities/time_utils.dart';

class AssetChartElementModel implements CoreResponseModel {
  late final String cACCOUNTCODE;
  late final DateTime cTRADINGDATE;
  late final num cCASHBALANCE;
  late final num cLOANBALANCE;
  late final num cSHARECLOSEVALUE;
  late final num cDAYPROFITVALUE;
  late final num cDAYPROFITRATE;
  late final num cPROFITVALUE;
  late final num cEARNEDVALUE;
  late final num cNETVALUE;

  // AssetChartElement(
  //     {required this.cACCOUNTCODE,
  //     required this.cTRADINGDATE,
  //     this.cCASHBALANCE,
  //     this.cLOANBALANCE,
  //     this.cSHARECLOSEVALUE,
  //     this.cDAYPROFITVALUE,
  //     this.cDAYPROFITRATE,
  //     this.cPROFITVALUE,
  //     this.cEARNEDVALUE,
  //     this.cNETVALUE});

  AssetChartElementModel.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cTRADINGDATE = TimeUtilities.commonTimeFormat.parse(json['C_TRADING_DATE']);
    cCASHBALANCE = json['C_CASH_BALANCE'];
    cLOANBALANCE = json['C_LOAN_BALANCE'];
    cSHARECLOSEVALUE = json['C_SHARE_CLOSE_VALUE'];
    cDAYPROFITVALUE = json['C_DAY_PROFIT_VALUE'];
    cDAYPROFITRATE = json['C_DAY_PROFIT_RATE'];
    cPROFITVALUE = json['C_PROFIT_VALUE'];
    cEARNEDVALUE = json['C_EARNED_VALUE'];
    cNETVALUE = json['C_NET_VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_TRADING_DATE'] =
        TimeUtilities.commonTimeFormat.format(cTRADINGDATE);
    data['C_CASH_BALANCE'] = cCASHBALANCE;
    data['C_LOAN_BALANCE'] = cLOANBALANCE;
    data['C_SHARE_CLOSE_VALUE'] = cSHARECLOSEVALUE;
    data['C_DAY_PROFIT_VALUE'] = cDAYPROFITVALUE;
    data['C_DAY_PROFIT_RATE'] = cDAYPROFITRATE;
    data['C_PROFIT_VALUE'] = cPROFITVALUE;
    data['C_EARNED_VALUE'] = cEARNEDVALUE;
    data['C_NET_VALUE'] = cNETVALUE;
    return data;
  }
}
