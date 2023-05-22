class ContractModel {
  String? id;
  String? customerCode;
  String? accountCode;
  String? contractCode;
  String? openDate;
  String? expiredDate;
  String? termCode;
  String? termName;
  num? capital;
  num? liquid;
  num? currentValue;
  num? fee;
  num? currentFee;
  num? feeRate;
  num? otherFeeRate;
  num? feeBase;
  String? content;

  ContractModel(
      {this.id,
      this.customerCode,
      this.accountCode,
      this.contractCode,
      this.openDate,
      this.expiredDate,
      this.termCode,
      this.termName,
      this.capital,
      this.liquid,
      this.currentValue,
      this.fee,
      this.currentFee,
      this.feeRate,
      this.otherFeeRate,
      this.feeBase,
      this.content});

  ContractModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['PK_CONTRACT_BORROW'];
    customerCode = json['C_CUSTOMER_CODE'];
    accountCode = json['C_ACCOUNT_CODE'];
    contractCode = json['C_CONTRACT_CODE'];
    openDate = json['C_OPEN_DATE'];
    expiredDate = json['C_EXPIRE_DATE'];
    termCode = json['C_TERM'];
    termName = json['C_TERM_NAME'];
    capital = json['C_CAPITAL'];
    liquid = json['C_LIQUID_VALUE'];
    currentValue = json['C_CURRENT_VALUE'];
    fee = json['C_FEE'];
    currentFee = json['C_CURRENT_FEE'];
    feeRate = json['C_FEE_RATE'];
    otherFeeRate = json['C_OTHER_FEE_RATE'];
    feeBase = json['C_FEE_BASE'];
    content = json['C_CONTENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_CONTRACT_BORROW'] = id;
    data['C_CUSTOMER_CODE'] = customerCode;
    data['C_ACCOUNT_CODE'] = accountCode;
    data['C_OPEN_DATE'] = openDate;
    data['C_EXPIRE_DATE'] = expiredDate;
    data['C_TERM'] = termCode;
    data['C_TERM_NAME'] = termName;
    data['C_CAPITAL'] = capital;
    data['C_LIQUID_VALUE'] = liquid;
    data['C_CURRENT_VALUE'] = currentValue;
    data['C_FEE'] = fee;
    data['C_CURRENT_FEE'] = currentFee;
    data['C_FEE_RATE'] = feeRate;
    data['C_OTHER_FEE_RATE'] = otherFeeRate;
    data['C_FEE_BASE'] = feeBase;
    data['C_CONTENT'] = content;

    return data;
  }

  @override
  String toString() {
    return 'Contract';
  }
}
