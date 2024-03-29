class SingleContract {
  String? pKCONTRACTBORROW;
  String? cCUSTOMERCODE;
  String? cACCOUNTCODE;
  String? cCONTRACTCODE;
  String? cOPENDATE;
  String? cEXPIREDATE;
  String? cTERM;
  String? cTERMNAME;
  num? cCAPITAL;
  num? cLIQUIDVALUE;
  num? cCURRENTVALUE;
  num? cFEE;
  num? cCURRENTFEE;
  num? cFEERATE;
  num? cOTHERFEERATE;
  num? cFEEBASE;
  String? cCONTENT;
  String? cSTATUS;
  String? cSTATUSNAME;
  String? cCHANNEL;
  String? cCHANNELNAME;
  num? cCURRENTDAY;
  num? cLIQUIDRATE;
  num? cLIQUIDFEE;
  String? cEXTENTTYPE;
  String? cEXTENTNAME;

  SingleContract(
      {this.pKCONTRACTBORROW,
      this.cCUSTOMERCODE,
      this.cACCOUNTCODE,
      this.cCONTRACTCODE,
      this.cOPENDATE,
      this.cEXPIREDATE,
      this.cTERM,
      this.cTERMNAME,
      this.cCAPITAL,
      this.cLIQUIDVALUE,
      this.cCURRENTVALUE,
      this.cFEE,
      this.cCURRENTFEE,
      this.cFEERATE,
      this.cOTHERFEERATE,
      this.cFEEBASE,
      this.cCONTENT,
      this.cSTATUS,
      this.cSTATUSNAME,
      this.cCHANNEL,
      this.cCHANNELNAME,
      this.cCURRENTDAY,
      this.cLIQUIDRATE,
      this.cLIQUIDFEE,
      this.cEXTENTTYPE,
      this.cEXTENTNAME});

  SingleContract.fromJson(Map<String, dynamic> json) {
    pKCONTRACTBORROW = json['PK_CONTRACT_BORROW'];
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cCONTRACTCODE = json['C_CONTRACT_CODE'];
    cOPENDATE = json['C_OPEN_DATE'];
    cEXPIREDATE = json['C_EXPIRE_DATE'];
    cTERM = json['C_TERM'];
    cTERMNAME = json['C_TERM_NAME'];
    cCAPITAL = json['C_CAPITAL'];
    cLIQUIDVALUE = json['C_LIQUID_VALUE'];
    cCURRENTVALUE = json['C_CURRENT_VALUE'];
    cFEE = json['C_FEE'];
    cCURRENTFEE = json['C_CURRENT_FEE'];
    cFEERATE = json['C_FEE_RATE'];
    cOTHERFEERATE = json['C_OTHER_FEE_RATE'];
    cFEEBASE = json['C_FEE_BASE'];
    cCONTENT = json['C_CONTENT'];
    cSTATUS = json['C_STATUS'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cCHANNEL = json['C_CHANNEL'];
    cCHANNELNAME = json['C_CHANNEL_NAME'];
    cCURRENTDAY = json['C_CURRENT_DAY'];
    cLIQUIDRATE = json['C_LIQUID_RATE'];
    cLIQUIDFEE = json['C_LIQUID_FEE'];
    cEXTENTTYPE = json['C_EXTENT_TYPE'];
    cEXTENTNAME = json['C_EXTENT_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_CONTRACT_BORROW'] = pKCONTRACTBORROW;
    data['C_CUSTOMER_CODE'] = cCUSTOMERCODE;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_CONTRACT_CODE'] = cCONTRACTCODE;
    data['C_OPEN_DATE'] = cOPENDATE;
    data['C_EXPIRE_DATE'] = cEXPIREDATE;
    data['C_TERM'] = cTERM;
    data['C_TERM_NAME'] = cTERMNAME;
    data['C_CAPITAL'] = cCAPITAL;
    data['C_LIQUID_VALUE'] = cLIQUIDVALUE;
    data['C_CURRENT_VALUE'] = cCURRENTVALUE;
    data['C_FEE'] = cFEE;
    data['C_CURRENT_FEE'] = cCURRENTFEE;
    data['C_FEE_RATE'] = cFEERATE;
    data['C_OTHER_FEE_RATE'] = cOTHERFEERATE;
    data['C_FEE_BASE'] = cFEEBASE;
    data['C_CONTENT'] = cCONTENT;
    data['C_STATUS'] = cSTATUS;
    data['C_STATUS_NAME'] = cSTATUSNAME;
    data['C_CHANNEL'] = cCHANNEL;
    data['C_CHANNEL_NAME'] = cCHANNELNAME;
    data['C_CURRENT_DAY'] = cCURRENTDAY;
    data['C_LIQUID_RATE'] = cLIQUIDRATE;
    data['C_LIQUID_FEE'] = cLIQUIDFEE;
    data['C_EXTENT_TYPE'] = cEXTENTTYPE;
    data['C_EXTENT_NAME'] = cEXTENTNAME;
    return data;
  }

  @override
  String toString() {
    return 'SingleContract{pKCONTRACTBORROW: $pKCONTRACTBORROW, cCUSTOMERCODE: $cCUSTOMERCODE, cACCOUNTCODE: $cACCOUNTCODE, cCONTRACTCODE: $cCONTRACTCODE, cOPENDATE: $cOPENDATE, cEXPIREDATE: $cEXPIREDATE, cTERM: $cTERM, cTERMNAME: $cTERMNAME, cCAPITAL: $cCAPITAL, cLIQUIDVALUE: $cLIQUIDVALUE, cCURRENTVALUE: $cCURRENTVALUE, cFEE: $cFEE, cCURRENTFEE: $cCURRENTFEE, cFEERATE: $cFEERATE, cOTHERFEERATE: $cOTHERFEERATE, cFEEBASE: $cFEEBASE, cCONTENT: $cCONTENT, cSTATUS: $cSTATUS, cSTATUSNAME: $cSTATUSNAME, cCHANNEL: $cCHANNEL, cCHANNELNAME: $cCHANNELNAME, cCURRENTDAY: $cCURRENTDAY, cLIQUIDRATE: $cLIQUIDRATE, cLIQUIDFEE: $cLIQUIDFEE, cEXTENTTYPE: $cEXTENTTYPE, cEXTENTNAME: $cEXTENTNAME}';
  }
}
