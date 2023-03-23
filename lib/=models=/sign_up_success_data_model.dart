class SignUpSuccessDataModel {
  String? cACCOUNTCODE;
  String? cOPENDATE;
  String? cAUTHENTYPE;
  String? cACCOUNTDEFAULT;
  String? cPASSWORD;
  String? cTRADINGPASS;
  String? cPHONENUMBER;
  num? cISLOCK;
  num? cISADMIN;
  num? cRESETFLAG;

  SignUpSuccessDataModel(
      {this.cACCOUNTCODE,
      this.cOPENDATE,
      this.cAUTHENTYPE,
      this.cACCOUNTDEFAULT,
      this.cPASSWORD,
      this.cTRADINGPASS,
      this.cPHONENUMBER,
      this.cISLOCK,
      this.cISADMIN,
      this.cRESETFLAG});

  SignUpSuccessDataModel.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cOPENDATE = json['C_OPEN_DATE'];
    cAUTHENTYPE = json['C_AUTHEN_TYPE'];
    cACCOUNTDEFAULT = json['C_ACCOUNT_DEFAULT'];
    cPASSWORD = json['C_PASSWORD'];
    cTRADINGPASS = json['C_TRADING_PASS'];
    cPHONENUMBER = json['C_PHONE_NUMBER'];
    cISLOCK = json['C_IS_LOCK'];
    cISADMIN = json['C_IS_ADMIN'];
    cRESETFLAG = json['C_RESET_FLAG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_OPEN_DATE'] = cOPENDATE;
    data['C_AUTHEN_TYPE'] = cAUTHENTYPE;
    data['C_ACCOUNT_DEFAULT'] = cACCOUNTDEFAULT;
    data['C_PASSWORD'] = cPASSWORD;
    data['C_TRADING_PASS'] = cTRADINGPASS;
    data['C_PHONE_NUMBER'] = cPHONENUMBER;
    data['C_IS_LOCK'] = cISLOCK;
    data['C_IS_ADMIN'] = cISADMIN;
    data['C_RESET_FLAG'] = cRESETFLAG;
    return data;
  }
}
