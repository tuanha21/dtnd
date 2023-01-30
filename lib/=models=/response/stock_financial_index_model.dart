import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat("MM/dd/yyyy HH:mm:ss");

class StockFinancialIndex {
  num? tOTLIAB;
  num? cFOPERSEC;
  num? nETDEBTPERASSETS1;
  late final DateTime rEPORTDATE;
  num? ePS;
  num? nETFIXEDASSETS;
  num? rECTURN;
  num? aLTMANSCORE;
  String? sECURITYCODE;
  num? bOOKVALUE;
  num? cURRRATIO;
  num? oPERATINGINC;
  num? qUICKRATIO;
  num? nONCURRASSETS;
  num? dVDCOVERATERATE;
  num? dEBTPERASSETS1;
  num? dVDGROWTH;
  num? rOA;
  num? fCF;
  num? gRMARGIN;
  num? rOE;
  num? dEBTPERASSETS;
  num? cFFINANCING;
  num? dVDPERSEC;
  num? rOWORDER;
  num? ePSGROWTH;
  num? gRPROFIT;
  num? lEVERAGE;
  num? fCFPERSEC;
  num? cASHPERASSETS;
  num? eXPONSEC;
  String? tOTLIABPERASSETS;
  num? cASHANDEQUIVALENT;
  num? pIOTROSKISCORE;
  num? cFOPERATING;
  num? pAYTURN;
  num? aLGOSCORE;
  num? cASHRATIO;
  num? oPERATINGMARGIN;
  num? nETINC;
  num? cAPIAL;
  num? nETDEBT;
  String? tOTEQUITYPERASSETS;
  num? dEPOSITINSBVANDCRINS;
  num? cASHPERASSETS1;
  String? lEVEL2CODE;
  num? iNTCOVERAGE;
  num? nONCURRLIAB;
  num? dEPOSITFROMSBVCRINS;
  num? nETDEBTPERASSETS;
  num? bENEISHSCORE;
  num? tOTASSETS;
  num? cFINVESTING;
  num? aSSETSTURN;
  num? cURRASSETS;
  num? tOTEQUITY;
  num? iNVENTORYTURN;
  num? mAGICSCORE;
  num? nETREV;
  num? nETMARGIN;
  num? eXPENSE;
  num? rOCE;
  num? cURRLIAB;

  StockFinancialIndex(
      {this.tOTLIAB,
      this.cFOPERSEC,
      this.nETDEBTPERASSETS1,
      required this.rEPORTDATE,
      this.ePS,
      this.nETFIXEDASSETS,
      this.rECTURN,
      this.aLTMANSCORE,
      this.sECURITYCODE,
      this.bOOKVALUE,
      this.cURRRATIO,
      this.oPERATINGINC,
      this.qUICKRATIO,
      this.nONCURRASSETS,
      this.dVDCOVERATERATE,
      this.dEBTPERASSETS1,
      this.dVDGROWTH,
      this.rOA,
      this.fCF,
      this.gRMARGIN,
      this.rOE,
      this.dEBTPERASSETS,
      this.cFFINANCING,
      this.dVDPERSEC,
      this.rOWORDER,
      this.ePSGROWTH,
      this.gRPROFIT,
      this.lEVERAGE,
      this.fCFPERSEC,
      this.cASHPERASSETS,
      this.eXPONSEC,
      this.tOTLIABPERASSETS,
      this.cASHANDEQUIVALENT,
      this.pIOTROSKISCORE,
      this.cFOPERATING,
      this.pAYTURN,
      this.aLGOSCORE,
      this.cASHRATIO,
      this.oPERATINGMARGIN,
      this.nETINC,
      this.cAPIAL,
      this.nETDEBT,
      this.tOTEQUITYPERASSETS,
      this.dEPOSITINSBVANDCRINS,
      this.cASHPERASSETS1,
      this.lEVEL2CODE,
      this.iNTCOVERAGE,
      this.nONCURRLIAB,
      this.dEPOSITFROMSBVCRINS,
      this.nETDEBTPERASSETS,
      this.bENEISHSCORE,
      this.tOTASSETS,
      this.cFINVESTING,
      this.aSSETSTURN,
      this.cURRASSETS,
      this.tOTEQUITY,
      this.iNVENTORYTURN,
      this.mAGICSCORE,
      this.nETREV,
      this.nETMARGIN,
      this.eXPENSE,
      this.rOCE,
      this.cURRLIAB});

  StockFinancialIndex.fromJson(Map<String, dynamic> json) {
    tOTLIAB = json['TOT_LIAB'];
    cFOPERSEC = json['CFO_PER_SEC'];
    nETDEBTPERASSETS1 = json['NET_DEBT_PER_ASSETS1'];
    rEPORTDATE = _dateFormat.parse(json['REPORT_DATE']);
    ePS = json['EPS'];
    nETFIXEDASSETS = json['NET_FIXED_ASSETS'];
    rECTURN = json['REC_TURN'];
    aLTMANSCORE = json['ALTMAN_SCORE'];
    sECURITYCODE = json['SECURITY_CODE'];
    bOOKVALUE = json['BOOK_VALUE'];
    cURRRATIO = json['CURR_RATIO'];
    oPERATINGINC = json['OPERATING_INC'];
    qUICKRATIO = json['QUICK_RATIO'];
    nONCURRASSETS = json['NON_CURR_ASSETS'];
    dVDCOVERATERATE = json['DVD_COVERATE_RATE'];
    dEBTPERASSETS1 = json['DEBT_PER_ASSETS1'];
    dVDGROWTH = json['DVD_GROWTH'];
    rOA = json['ROA'];
    fCF = json['FCF'];
    gRMARGIN = json['GR_MARGIN'];
    rOE = json['ROE'];
    dEBTPERASSETS = json['DEBT_PER_ASSETS'];
    cFFINANCING = json['CF_FINANCING'];
    dVDPERSEC = json['DVD_PER_SEC'];
    rOWORDER = json['ROW_ORDER'];
    ePSGROWTH = json['EPS_GROWTH'];
    gRPROFIT = json['GR_PROFIT'];
    lEVERAGE = json['LEVERAGE'];
    fCFPERSEC = json['FCF_PER_SEC'];
    cASHPERASSETS = json['CASH_PER_ASSETS'];
    eXPONSEC = json['EXP_ON_SEC'];
    tOTLIABPERASSETS = json['TOT_LIAB_PER_ASSETS'];
    cASHANDEQUIVALENT = json['CASH_AND_EQUIVALENT'];
    pIOTROSKISCORE = json['PIOTROSKI_SCORE'];
    cFOPERATING = json['CF_OPERATING'];
    pAYTURN = json['PAY_TURN'];
    aLGOSCORE = json['ALGO_SCORE'];
    cASHRATIO = json['CASH_RATIO'];
    oPERATINGMARGIN = json['OPERATING_MARGIN'];
    nETINC = json['NET_INC'];
    cAPIAL = json['CAPIAL'];
    nETDEBT = json['NET_DEBT'];
    tOTEQUITYPERASSETS = json['TOT_EQUITY_PER_ASSETS'];
    dEPOSITINSBVANDCRINS = json['DEPOSIT_IN_SBV_AND_CRINS'];
    cASHPERASSETS1 = json['CASH_PER_ASSETS1'];
    lEVEL2CODE = json['LEVEL2_CODE'];
    iNTCOVERAGE = json['INT_COVERAGE'];
    nONCURRLIAB = json['NON_CURR_LIAB'];
    dEPOSITFROMSBVCRINS = json['DEPOSIT_FROM_SBV_CRINS'];
    nETDEBTPERASSETS = json['NET_DEBT_PER_ASSETS'];
    bENEISHSCORE = json['BENEISH_SCORE'];
    tOTASSETS = json['TOT_ASSETS'];
    cFINVESTING = json['CF_INVESTING'];
    aSSETSTURN = json['ASSETS_TURN'];
    cURRASSETS = json['CURR_ASSETS'];
    tOTEQUITY = json['TOT_EQUITY'];
    iNVENTORYTURN = json['INVENTORY_TURN'];
    mAGICSCORE = json['MAGIC_SCORE'];
    nETREV = json['NET_REV'];
    nETMARGIN = json['NET_MARGIN'];
    eXPENSE = json['EXPENSE'];
    rOCE = json['ROCE'];
    cURRLIAB = json['CURR_LIAB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TOT_LIAB'] = tOTLIAB;
    data['CFO_PER_SEC'] = cFOPERSEC;
    data['NET_DEBT_PER_ASSETS1'] = nETDEBTPERASSETS1;
    data['REPORT_DATE'] = rEPORTDATE;
    data['EPS'] = ePS;
    data['NET_FIXED_ASSETS'] = nETFIXEDASSETS;
    data['REC_TURN'] = rECTURN;
    data['ALTMAN_SCORE'] = aLTMANSCORE;
    data['SECURITY_CODE'] = sECURITYCODE;
    data['BOOK_VALUE'] = bOOKVALUE;
    data['CURR_RATIO'] = cURRRATIO;
    data['OPERATING_INC'] = oPERATINGINC;
    data['QUICK_RATIO'] = qUICKRATIO;
    data['NON_CURR_ASSETS'] = nONCURRASSETS;
    data['DVD_COVERATE_RATE'] = dVDCOVERATERATE;
    data['DEBT_PER_ASSETS1'] = dEBTPERASSETS1;
    data['DVD_GROWTH'] = dVDGROWTH;
    data['ROA'] = rOA;
    data['FCF'] = fCF;
    data['GR_MARGIN'] = gRMARGIN;
    data['ROE'] = rOE;
    data['DEBT_PER_ASSETS'] = dEBTPERASSETS;
    data['CF_FINANCING'] = cFFINANCING;
    data['DVD_PER_SEC'] = dVDPERSEC;
    data['ROW_ORDER'] = rOWORDER;
    data['EPS_GROWTH'] = ePSGROWTH;
    data['GR_PROFIT'] = gRPROFIT;
    data['LEVERAGE'] = lEVERAGE;
    data['FCF_PER_SEC'] = fCFPERSEC;
    data['CASH_PER_ASSETS'] = cASHPERASSETS;
    data['EXP_ON_SEC'] = eXPONSEC;
    data['TOT_LIAB_PER_ASSETS'] = tOTLIABPERASSETS;
    data['CASH_AND_EQUIVALENT'] = cASHANDEQUIVALENT;
    data['PIOTROSKI_SCORE'] = pIOTROSKISCORE;
    data['CF_OPERATING'] = cFOPERATING;
    data['PAY_TURN'] = pAYTURN;
    data['ALGO_SCORE'] = aLGOSCORE;
    data['CASH_RATIO'] = cASHRATIO;
    data['OPERATING_MARGIN'] = oPERATINGMARGIN;
    data['NET_INC'] = nETINC;
    data['CAPIAL'] = cAPIAL;
    data['NET_DEBT'] = nETDEBT;
    data['TOT_EQUITY_PER_ASSETS'] = tOTEQUITYPERASSETS;
    data['DEPOSIT_IN_SBV_AND_CRINS'] = dEPOSITINSBVANDCRINS;
    data['CASH_PER_ASSETS1'] = cASHPERASSETS1;
    data['LEVEL2_CODE'] = lEVEL2CODE;
    data['INT_COVERAGE'] = iNTCOVERAGE;
    data['NON_CURR_LIAB'] = nONCURRLIAB;
    data['DEPOSIT_FROM_SBV_CRINS'] = dEPOSITFROMSBVCRINS;
    data['NET_DEBT_PER_ASSETS'] = nETDEBTPERASSETS;
    data['BENEISH_SCORE'] = bENEISHSCORE;
    data['TOT_ASSETS'] = tOTASSETS;
    data['CF_INVESTING'] = cFINVESTING;
    data['ASSETS_TURN'] = aSSETSTURN;
    data['CURR_ASSETS'] = cURRASSETS;
    data['TOT_EQUITY'] = tOTEQUITY;
    data['INVENTORY_TURN'] = iNVENTORYTURN;
    data['MAGIC_SCORE'] = mAGICSCORE;
    data['NET_REV'] = nETREV;
    data['NET_MARGIN'] = nETMARGIN;
    data['EXPENSE'] = eXPENSE;
    data['ROCE'] = rOCE;
    data['CURR_LIAB'] = cURRLIAB;
    return data;
  }
}
