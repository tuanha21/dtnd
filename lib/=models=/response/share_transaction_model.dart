import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/stock_status.dart';

class ShareTransactionModel extends StockStatus implements CoreResponseModel {
  String? cTRANSACTIONNO;
  String? cTRANSACTIONDATE;
  String? cDUEDATE;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  String? cSHARESTATUS;
  String? cSTATUSNAME;
  num? cSHAREIN;
  num? cSHAREOUT;
  String? cCONTENT;

  num get change {
    return (cSHAREIN ?? 0) - (cSHAREOUT ?? 0);
  }

  @override
  SStatus get sstatus {
    switch (change.compareTo(0)) {
      case 1:
        return SStatus.up;
      case -1:
        return SStatus.down;
      default:
        return SStatus.ref;
    }
  }

  ShareTransactionModel.fromJson(Map<String, dynamic> json) {
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHARESTATUS = json['C_SHARE_STATUS'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSHAREIN = json['C_SHARE_IN'];
    cSHAREOUT = json['C_SHARE_OUT'];
    cCONTENT = json['C_CONTENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_TRANSACTION_NO'] = cTRANSACTIONNO;
    data['C_TRANSACTION_DATE'] = cTRANSACTIONDATE;
    data['C_DUE_DATE'] = cDUEDATE;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_SHARE_CODE'] = cSHARECODE;
    data['C_SHARE_STATUS'] = cSHARESTATUS;
    data['C_STATUS_NAME'] = cSTATUSNAME;
    data['C_SHARE_IN'] = cSHAREIN;
    data['C_SHARE_OUT'] = cSHAREOUT;
    data['C_CONTENT'] = cCONTENT;
    return data;
  }
}
