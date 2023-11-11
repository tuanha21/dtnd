import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/stock_status.dart';

class DebtModel extends StockStatus implements CoreResponseModel {
  String? cLOANID;
  String? cACCOUNTCODE;
  String? cBANKCODE;
  num? cLOANIN;
  num? cLOANOUT;
  num? cFEEIN;
  num? cFEEOUT;
  num? loan;
  num? fee;
  num? cINTERESTRATE;
  String? cDELIVERDATE;
  String? interestDate;
  num? cCOUNTDAY;
  String? expireDate;

  DebtModel(
      {this.cLOANID,
      this.cACCOUNTCODE,
      this.cBANKCODE,
      this.cLOANIN,
      this.cLOANOUT,
      this.cFEEIN,
      this.cFEEOUT,
      this.loan,
      this.fee,
      this.cINTERESTRATE,
      this.cDELIVERDATE,
      this.interestDate,
      this.cCOUNTDAY,
      this.expireDate});

  DebtModel.fromJson(Map<String, dynamic> json) {
    cLOANID = json['C_LOAN_ID'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cBANKCODE = json['C_BANK_CODE'];
    cLOANIN = json['C_LOAN_IN'];
    cLOANOUT = json['C_LOAN_OUT'];
    cFEEIN = json['C_FEE_IN'];
    cFEEOUT = json['C_FEE_OUT'];
    loan = json['C_LOAN'];
    fee = json['C_FEE'];
    cINTERESTRATE = json['C_INTEREST_RATE'];
    cDELIVERDATE = json['C_DELIVER_DATE'];
    interestDate = json['C_INTEREST_DATE'];
    cCOUNTDAY = json['C_COUNT_DAY'];
    expireDate = json['C_EXPIRE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_LOAN_ID'] = cLOANID;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_BANK_CODE'] = cBANKCODE;
    data['C_LOAN_IN'] = cLOANIN;
    data['C_LOAN_OUT'] = cLOANOUT;
    data['C_FEE_IN'] = cFEEIN;
    data['C_FEE_OUT'] = cFEEOUT;
    data['C_LOAN'] = loan;
    data['C_FEE'] = fee;
    data['C_INTEREST_RATE'] = cINTERESTRATE;
    data['C_DELIVER_DATE'] = cDELIVERDATE;
    data['C_INTEREST_DATE'] = interestDate;
    data['C_COUNT_DAY'] = cCOUNTDAY;
    data['C_EXPIRE_DATE'] = expireDate;
    return data;
  }

  @override
  SStatus get sstatus => throw UnimplementedError();
}
