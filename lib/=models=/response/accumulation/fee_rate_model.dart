class FeeRateModel {
  String? id;
  String? productCode;
  String? productName;
  String? termCode;
  String? termName;
  num? capMin;
  num? capMax;
  num? feeRate;
  num? liquidRate;
  String? content;

  FeeRateModel({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.termCode,
    required this.termName,
    required this.capMin,
    required this.capMax,
    required this.feeRate,
    required this.liquidRate,
    required this.content,
  });

  FeeRateModel.fromJson(Map<String, dynamic> json) {
    id = json['PK_MM_FEE_RATE'];
    productCode = json['C_PRODUCT_CODE'];
    productName = json['C_PRODUCT_NAME'];
    termCode = json['C_TERM_CODE'];
    termName = json['C_TERM_NAME'];
    capMin = json['C_CAP_MIN'];
    capMax = json['C_CAP_MAX'];
    feeRate = json['C_FEE_RATE'];
    liquidRate = json['C_LIQUID_RATE'];
    content = json['C_CONTENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_MM_FEE_RATE'] = id;
    data['C_PRODUCT_CODE'] = productCode;
    data['C_PRODUCT_NAME'] = productName;
    data['C_TERM_CODE'] = termCode;
    data['C_TERM_NAME'] = termName;
    data['C_CAP_MIN'] = capMin;
    data['C_CAP_MAX'] = capMax;
    data['C_FEE_RATE'] = feeRate;
    data['C_LIQUID_RATE'] = liquidRate;
    data['C_CONTENT'] = content;

    return data;
  }

  @override
  String toString() {
    return 'FeeRate';
  }
}
