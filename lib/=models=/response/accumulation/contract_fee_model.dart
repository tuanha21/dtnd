class ContractFee {
  String? cOPENDATE;
  String? cTERMCODE;
  String? cEXPIREDATE;
  num? cCASHVALUE;
  num? cFEEVALUE;

  ContractFee(
      {this.cOPENDATE,
        this.cTERMCODE,
        this.cEXPIREDATE,
        this.cCASHVALUE,
        this.cFEEVALUE});

  ContractFee.fromJson(Map<String, dynamic> json) {
    cOPENDATE = json['C_OPEN_DATE'];
    cTERMCODE = json['C_TERM_CODE'];
    cEXPIREDATE = json['C_EXPIRE_DATE'];
    cCASHVALUE = json['C_CASH_VALUE'];
    cFEEVALUE = json['C_FEE_VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_OPEN_DATE'] = cOPENDATE;
    data['C_TERM_CODE'] = cTERMCODE;
    data['C_EXPIRE_DATE'] = cEXPIREDATE;
    data['C_CASH_VALUE'] = cCASHVALUE;
    data['C_FEE_VALUE'] = cFEEVALUE;
    return data;
  }

  @override
  String toString() {
    return 'ContractFee{cOPENDATE: $cOPENDATE, cTERMCODE: $cTERMCODE, cEXPIREDATE: $cEXPIREDATE, cCASHVALUE: $cCASHVALUE, cFEEVALUE: $cFEEVALUE}';
  }
}