class StockRankingFinancialIndex {
  double? mKDVDGROWTH1Y;
  double? iNDPRICEBVPST;
  double? iNDROE;
  double? sECEPSGROWTH1Y;
  double? iNDREVGROWTH3Y;
  double? iNDPE;
  double? iNDASSETSTURN;
  double? iNDDPSGROWTH3Y;
  double? sECLIABEQUITY;
  String? sECURITYCODE;
  double? mKDVDPERSEC;
  double? iNDROA;
  double? iNDEPSGROWTH3Y;
  double? sECREVGROWTH1Y;
  double? iNDREVGROWTHQY;
  double? mKREVGROWTH3Y;
  double? sECEPSGROWTHQY;
  double? mKPS;
  double? iNDLIABEQUITY;
  double? mKEPSGROWTH3Y;
  double? mKDPSGROWTH3Y;
  double? mKBVPSTANGIBLE;
  double? iNDOPERATINGMARGIN;
  double? sECBVPSTANGIBLE;
  double? mKROA;
  double? mKLIABEQUITY;
  String? lEVEL4CODE;
  double? mKROE;
  double? iNDBVPSTANGIBLE;
  double? mKMC;
  double? sECREVGROWTHQY;
  double? iNDEPSGROWTHQY;
  double? sECPRICEBVPST;
  double? mKEVPEREBITDA;
  double? sECOPERATINGMARGIN;
  int? sECDVDPERSEC;
  double? mKOPERATINGMARGIN;
  double? mKREVGROWTHQY;
  double? iNDREVGROWTH1Y;
  double? sECEPSGROWTH3Y;
  double? mKEPSGROWTHQY;
  double? iNDDVDPERSEC;
  double? mKPRICEBVPST;
  double? sECPE;
  int? sECDPSGROWTH3Y;
  double? mKASSETSTURN;
  double? mKFCFPERSEC;
  double? mKPE;
  double? sECROA;
  double? sECASSETSTURN;
  double? sECREVGROWTH3Y;
  double? sECROE;
  String? lEVEL2CODE;
  double? iNDEPSGROWTH1Y;
  int? sECDVDGROWTH1Y;
  double? sECPS;
  double? mKREVGROWTH1Y;
  double? iNDDVDGROWTH1Y;
  double? mKEPSGROWTH1Y;
  int? sECROCE;
  double? sECMC;
  double? iNDMC;
  double? iNDLEVERAGE;
  double? sECLEVERAGE;
  double? mKLEVERAGE;
  double? mKROCE;
  double? iNDPS;

  StockRankingFinancialIndex(
      {this.mKDVDGROWTH1Y,
      this.iNDPRICEBVPST,
      this.iNDROE,
      this.sECEPSGROWTH1Y,
      this.iNDREVGROWTH3Y,
      this.iNDPE,
      this.iNDASSETSTURN,
      this.iNDDPSGROWTH3Y,
      this.sECLIABEQUITY,
      this.sECURITYCODE,
      this.mKDVDPERSEC,
      this.iNDROA,
      this.iNDEPSGROWTH3Y,
      this.sECREVGROWTH1Y,
      this.iNDREVGROWTHQY,
      this.mKREVGROWTH3Y,
      this.sECEPSGROWTHQY,
      this.mKPS,
      this.iNDLIABEQUITY,
      this.mKEPSGROWTH3Y,
      this.mKDPSGROWTH3Y,
      this.mKBVPSTANGIBLE,
      this.iNDOPERATINGMARGIN,
      this.sECBVPSTANGIBLE,
      this.mKROA,
      this.mKLIABEQUITY,
      this.lEVEL4CODE,
      this.mKROE,
      this.iNDBVPSTANGIBLE,
      this.mKMC,
      this.sECREVGROWTHQY,
      this.iNDEPSGROWTHQY,
      this.sECPRICEBVPST,
      this.mKEVPEREBITDA,
      this.sECOPERATINGMARGIN,
      this.sECDVDPERSEC,
      this.mKOPERATINGMARGIN,
      this.mKREVGROWTHQY,
      this.iNDREVGROWTH1Y,
      this.sECEPSGROWTH3Y,
      this.mKEPSGROWTHQY,
      this.iNDDVDPERSEC,
      this.mKPRICEBVPST,
      this.sECPE,
      this.sECDPSGROWTH3Y,
      this.mKASSETSTURN,
      this.mKFCFPERSEC,
      this.mKPE,
      this.sECROA,
      this.sECASSETSTURN,
      this.sECREVGROWTH3Y,
      this.sECROE,
      this.lEVEL2CODE,
      this.iNDEPSGROWTH1Y,
      this.sECDVDGROWTH1Y,
      this.sECPS,
      this.mKREVGROWTH1Y,
      this.iNDDVDGROWTH1Y,
      this.mKEPSGROWTH1Y,
      this.sECROCE,
      this.sECMC,
      this.iNDMC,
      this.iNDLEVERAGE,
      this.sECLEVERAGE,
      this.mKLEVERAGE,
      this.mKROCE,
      this.iNDPS});

  StockRankingFinancialIndex.fromJson(Map<String, dynamic> json) {
    mKDVDGROWTH1Y = json['MK_DVD_GROWTH_1Y'];
    iNDPRICEBVPST = json['IND_PRICE_BVPST'];
    iNDROE = json['IND_ROE'];
    sECEPSGROWTH1Y = json['SEC_EPS_GROWTH_1Y'];
    iNDREVGROWTH3Y = json['IND_REV_GROWTH_3Y'];
    iNDPE = json['IND_PE'];
    iNDASSETSTURN = json['IND_ASSETS_TURN'];
    iNDDPSGROWTH3Y = json['IND_DPS_GROWTH_3Y'];
    sECLIABEQUITY = json['SEC_LIAB_EQUITY'];
    sECURITYCODE = json['SECURITY_CODE'];
    mKDVDPERSEC = json['MK_DVD_PER_SEC'];
    iNDROA = json['IND_ROA'];
    iNDEPSGROWTH3Y = json['IND_EPS_GROWTH_3Y'];
    sECREVGROWTH1Y = json['SEC_REV_GROWTH_1Y'];
    iNDREVGROWTHQY = json['IND_REV_GROWTH_QY'];
    mKREVGROWTH3Y = json['MK_REV_GROWTH_3Y'];
    sECEPSGROWTHQY = json['SEC_EPS_GROWTH_QY'];
    mKPS = json['MK_PS'];
    iNDLIABEQUITY = json['IND_LIAB_EQUITY'];
    mKEPSGROWTH3Y = json['MK_EPS_GROWTH_3Y'];
    mKDPSGROWTH3Y = json['MK_DPS_GROWTH_3Y'];
    mKBVPSTANGIBLE = json['MK_BVPS_TANGIBLE'];
    iNDOPERATINGMARGIN = json['IND_OPERATING_MARGIN'];
    sECBVPSTANGIBLE = json['SEC_BVPS_TANGIBLE'];
    mKROA = json['MK_ROA'];
    mKLIABEQUITY = json['MK_LIAB_EQUITY'];
    lEVEL4CODE = json['LEVEL4_CODE'];
    mKROE = json['MK_ROE'];
    iNDBVPSTANGIBLE = json['IND_BVPS_TANGIBLE'];
    mKMC = json['MK_MC'];
    sECREVGROWTHQY = json['SEC_REV_GROWTH_QY'];
    iNDEPSGROWTHQY = json['IND_EPS_GROWTH_QY'];
    sECPRICEBVPST = json['SEC_PRICE_BVPST'];
    mKEVPEREBITDA = json['MK_EV_PER_EBITDA'];
    sECOPERATINGMARGIN = json['SEC_OPERATING_MARGIN'];
    sECDVDPERSEC = json['SEC_DVD_PER_SEC'];
    mKOPERATINGMARGIN = json['MK_OPERATING_MARGIN'];
    mKREVGROWTHQY = json['MK_REV_GROWTH_QY'];
    iNDREVGROWTH1Y = json['IND_REV_GROWTH_1Y'];
    sECEPSGROWTH3Y = json['SEC_EPS_GROWTH_3Y'];
    mKEPSGROWTHQY = json['MK_EPS_GROWTH_QY'];
    iNDDVDPERSEC = json['IND_DVD_PER_SEC'];
    mKPRICEBVPST = json['MK_PRICE_BVPST'];
    sECPE = json['SEC_PE'];
    sECDPSGROWTH3Y = json['SEC_DPS_GROWTH_3Y'];
    mKASSETSTURN = json['MK_ASSETS_TURN'];
    mKFCFPERSEC = json['MK_FCF_PER_SEC'];
    mKPE = json['MK_PE'];
    sECROA = json['SEC_ROA'];
    sECASSETSTURN = json['SEC_ASSETS_TURN'];
    sECREVGROWTH3Y = json['SEC_REV_GROWTH_3Y'];
    sECROE = json['SEC_ROE'];
    lEVEL2CODE = json['LEVEL2_CODE'];
    iNDEPSGROWTH1Y = json['IND_EPS_GROWTH_1Y'];
    sECDVDGROWTH1Y = json['SEC_DVD_GROWTH_1Y'];
    sECPS = json['SEC_PS'];
    mKREVGROWTH1Y = json['MK_REV_GROWTH_1Y'];
    iNDDVDGROWTH1Y = json['IND_DVD_GROWTH_1Y'];
    mKEPSGROWTH1Y = json['MK_EPS_GROWTH_1Y'];
    sECROCE = json['SEC_ROCE'];
    sECMC = json['SEC_MC'];
    iNDMC = json['IND_MC'];
    iNDLEVERAGE = json['IND_LEVERAGE'];
    sECLEVERAGE = json['SEC_LEVERAGE'];
    mKLEVERAGE = json['MK_LEVERAGE'];
    mKROCE = json['MK_ROCE'];
    iNDPS = json['IND_PS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MK_DVD_GROWTH_1Y'] = mKDVDGROWTH1Y;
    data['IND_PRICE_BVPST'] = iNDPRICEBVPST;
    data['IND_ROE'] = iNDROE;
    data['SEC_EPS_GROWTH_1Y'] = sECEPSGROWTH1Y;
    data['IND_REV_GROWTH_3Y'] = iNDREVGROWTH3Y;
    data['IND_PE'] = iNDPE;
    data['IND_ASSETS_TURN'] = iNDASSETSTURN;
    data['IND_DPS_GROWTH_3Y'] = iNDDPSGROWTH3Y;
    data['SEC_LIAB_EQUITY'] = sECLIABEQUITY;
    data['SECURITY_CODE'] = sECURITYCODE;
    data['MK_DVD_PER_SEC'] = mKDVDPERSEC;
    data['IND_ROA'] = iNDROA;
    data['IND_EPS_GROWTH_3Y'] = iNDEPSGROWTH3Y;
    data['SEC_REV_GROWTH_1Y'] = sECREVGROWTH1Y;
    data['IND_REV_GROWTH_QY'] = iNDREVGROWTHQY;
    data['MK_REV_GROWTH_3Y'] = mKREVGROWTH3Y;
    data['SEC_EPS_GROWTH_QY'] = sECEPSGROWTHQY;
    data['MK_PS'] = mKPS;
    data['IND_LIAB_EQUITY'] = iNDLIABEQUITY;
    data['MK_EPS_GROWTH_3Y'] = mKEPSGROWTH3Y;
    data['MK_DPS_GROWTH_3Y'] = mKDPSGROWTH3Y;
    data['MK_BVPS_TANGIBLE'] = mKBVPSTANGIBLE;
    data['IND_OPERATING_MARGIN'] = iNDOPERATINGMARGIN;
    data['SEC_BVPS_TANGIBLE'] = sECBVPSTANGIBLE;
    data['MK_ROA'] = mKROA;
    data['MK_LIAB_EQUITY'] = mKLIABEQUITY;
    data['LEVEL4_CODE'] = lEVEL4CODE;
    data['MK_ROE'] = mKROE;
    data['IND_BVPS_TANGIBLE'] = iNDBVPSTANGIBLE;
    data['MK_MC'] = mKMC;
    data['SEC_REV_GROWTH_QY'] = sECREVGROWTHQY;
    data['IND_EPS_GROWTH_QY'] = iNDEPSGROWTHQY;
    data['SEC_PRICE_BVPST'] = sECPRICEBVPST;
    data['MK_EV_PER_EBITDA'] = mKEVPEREBITDA;
    data['SEC_OPERATING_MARGIN'] = sECOPERATINGMARGIN;
    data['SEC_DVD_PER_SEC'] = sECDVDPERSEC;
    data['MK_OPERATING_MARGIN'] = mKOPERATINGMARGIN;
    data['MK_REV_GROWTH_QY'] = mKREVGROWTHQY;
    data['IND_REV_GROWTH_1Y'] = iNDREVGROWTH1Y;
    data['SEC_EPS_GROWTH_3Y'] = sECEPSGROWTH3Y;
    data['MK_EPS_GROWTH_QY'] = mKEPSGROWTHQY;
    data['IND_DVD_PER_SEC'] = iNDDVDPERSEC;
    data['MK_PRICE_BVPST'] = mKPRICEBVPST;
    data['SEC_PE'] = sECPE;
    data['SEC_DPS_GROWTH_3Y'] = sECDPSGROWTH3Y;
    data['MK_ASSETS_TURN'] = mKASSETSTURN;
    data['MK_FCF_PER_SEC'] = mKFCFPERSEC;
    data['MK_PE'] = mKPE;
    data['SEC_ROA'] = sECROA;
    data['SEC_ASSETS_TURN'] = sECASSETSTURN;
    data['SEC_REV_GROWTH_3Y'] = sECREVGROWTH3Y;
    data['SEC_ROE'] = sECROE;
    data['LEVEL2_CODE'] = lEVEL2CODE;
    data['IND_EPS_GROWTH_1Y'] = iNDEPSGROWTH1Y;
    data['SEC_DVD_GROWTH_1Y'] = sECDVDGROWTH1Y;
    data['SEC_PS'] = sECPS;
    data['MK_REV_GROWTH_1Y'] = mKREVGROWTH1Y;
    data['IND_DVD_GROWTH_1Y'] = iNDDVDGROWTH1Y;
    data['MK_EPS_GROWTH_1Y'] = mKEPSGROWTH1Y;
    data['SEC_ROCE'] = sECROCE;
    data['SEC_MC'] = sECMC;
    data['IND_MC'] = iNDMC;
    data['IND_LEVERAGE'] = iNDLEVERAGE;
    data['SEC_LEVERAGE'] = sECLEVERAGE;
    data['MK_LEVERAGE'] = mKLEVERAGE;
    data['MK_ROCE'] = mKROCE;
    data['IND_PS'] = iNDPS;
    return data;
  }
}
