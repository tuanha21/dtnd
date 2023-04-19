class CheckAccountSuccessDataModel {
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  String? cCUSTOMERCODE;
  String? cCARDID;
  String? cCUSTMOBILE;
  String? cCUSTEMAIL;

  CheckAccountSuccessDataModel(
      {this.cACCOUNTCODE,
      this.cACCOUNTNAME,
      this.cCUSTOMERCODE,
      this.cCARDID,
      this.cCUSTMOBILE,
      this.cCUSTEMAIL});

  CheckAccountSuccessDataModel.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
    cCARDID = json['C_CARD_ID'];
    cCUSTMOBILE = json['C_CUST_MOBILE'];
    cCUSTEMAIL = json['C_CUST_EMAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = cACCOUNTCODE;
    data['C_CUSTOMER_CODE'] = cCUSTOMERCODE;
    data['C_CARD_ID'] = cCARDID;
    data['C_CUST_MOBILE'] = cCUSTMOBILE;
    data['C_CUST_EMAIL'] = cCUSTEMAIL;

    return data;
  }
}
