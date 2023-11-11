import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/stock_status.dart';

class CashTransactionModel {
  late final TotalCashTransactionModel total;
  late final List<CashTransactionHistoryModel> listHistory;
  CashTransactionModel(this.total, this.listHistory);
}

class TotalCashTransactionModel {
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  num? cCASHFISRTBALANCE;
  num? cCASHCLOSEBALANCE;
  num? cCASHBLOCK;

  TotalCashTransactionModel.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cCASHFISRTBALANCE = json['C_CASH_FISRT_BALANCE'];
    cCASHCLOSEBALANCE = json['C_CASH_CLOSE_BALANCE'];
    cCASHBLOCK = json['C_CASH_BLOCK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = cACCOUNTNAME;
    data['C_CASH_FISRT_BALANCE'] = cCASHFISRTBALANCE;
    data['C_CASH_CLOSE_BALANCE'] = cCASHCLOSEBALANCE;
    data['C_CASH_BLOCK'] = cCASHBLOCK;
    return data;
  }
}

class CashTransactionHistoryModel extends StockStatus
    implements CoreResponseModel {
  String? cACCOUNTCODE;
  String? cTRANSACTIONDATE;
  String? cTRANSACTIONNO;
  num? cCASHIN;
  num? cCASHOUT;
  String? cCONTENT;
  num? cORDER;

  CashTransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cCASHIN = json['C_CASH_IN'];
    cCASHOUT = json['C_CASH_OUT'];
    cCONTENT = json['C_CONTENT'];
    cORDER = json['C_ORDER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_TRANSACTION_DATE'] = cTRANSACTIONDATE;
    data['C_TRANSACTION_NO'] = cTRANSACTIONNO;
    data['C_CASH_IN'] = cCASHIN;
    data['C_CASH_OUT'] = cCASHOUT;
    data['C_CONTENT'] = cCONTENT;
    data['C_ORDER'] = cORDER;
    return data;
  }

  num get change {
    return (cCASHIN ?? 0) - (cCASHOUT ?? 0);
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
}
