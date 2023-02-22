class StockFilter {
  String? sECURITYCODE;
  String? eXCHANGECODE;
  String? iNDUSTRYCODE;
  String? iNDUSTRYNAME;
  String? iNDUSTRYNAMEEN;
  String? iNDUSTRYNAMECN;
  String? iNDUSTRYNAMEKR;
  String? iNDUSTRYNAMEJP;
  double? pPERMAX52W;
  double? pPERMIN52W;
  double? sTDP1Y;
  num? mC;
  num? eV;
  num? tOTALVOL;
  num? aVGVOL5D;
  num? aVGVOL10D;
  num? aVGVOL20D;
  num? aVGVOL30D;
  num? aVGVOL60D;
  num? aVGVOLYTD;
  num? aVGVOL1Y;
  num? tOTALVAL;
  num? aVGVAL5D;
  num? aVGVAL10D;
  num? aVGVAL20D;
  num? aVGVAL30D;
  num? aVGVAL60D;
  num? aVGVALYTD;
  num? aVGVAL1Y;
  num? vOLPER5D;
  num? vOLPER10D;
  num? vOLPER20D;
  num? vALPER5D;
  num? vALPER10D;
  num? vALPER20D;
  num? fBUYVALUE;
  num? fSELLVALUE;
  num? fNETBUYVALUE;
  num? aVGFNETBUY5D;
  num? aVGFNETBUY10D;
  num? aVGFNETBUY20D;
  num? aVGFNETBUY30D;
  num? aVGFNETBUY60D;
  num? aVGFNETBUYYTD;
  num? aVGFNETBUY1Y;
  num? fBUYVOLUME;
  num? fSELLVOLUME;
  num? fNETBUYVOLUME;
  num? aVGFNETBUYVOL5D;
  num? aVGFNETBUYVOL10D;
  num? aVGFNETBUYVOL20D;
  num? aVGFNETBUYVOL30D;
  num? aVGFNETBUYVOL60D;
  num? aVGFNETBUYVOLYTD;
  num? aVGFNETBUYVOL1Y;
  num? pIBUYVALUE;
  num? pISELLVALUE;
  num? pINETBUYVALUE;
  num? pISELLVALPER5D;
  num? pISELLVALPER10D;
  num? pISELLVALPER20D;
  num? aVGPINETBUY5D;
  num? aVGPINETBUY10D;
  num? aVGPINETBUY20D;
  num? aVGPINETBUY30D;
  num? aVGPINETBUY60D;
  num? aVGPINETBUYYTD;
  num? aVGPINETBUY1Y;
  num? pIBUYVOLUME;
  num? pISELLVOLUME;
  num? pINETBUYVOLUME;
  num? aVGPINETBUYVOL5D;
  num? aVGPINETBUYVOL10D;
  num? aVGPINETBUYVOL20D;
  num? aVGPINETBUYVOL30D;
  num? aVGPINETBUYVOL60D;
  num? aVGPINETBUYVOLYTD;
  num? aVGPINETBUYVOL1Y;
  num? pPER20D;
  num? pPER50D;
  num? pPER130D;
  num? pPER200D;
  num? pCHANGE1W;
  num? pCHANGE1M;
  num? pCHANGE3M;
  num? pCHANGE6M;
  num? pCHANGE1Y;
  num? rS1W;
  num? rS1M;
  num? rS3M;
  num? rS6M;
  num? rS1Y;
  num? vOL10DVS3M;
  num? pE;
  num? pB;
  num? pS;
  num? nETDEBTPERMC;
  num? dVDPERP;
  num? pPERFCF;
  num? eVPEREBITDA;
  num? eVPEREBIT;
  num? rOA;
  num? rOE;
  num? nETMARGIN;
  num? rOCE;
  num? cURRRATIO;
  num? qUICKRATIO;
  num? cASHRATIO;
  num? dEBTPERASSETS;
  num? lEVERAGE;
  num? iNTCOVERAGE;
  num? fCFPERLTDEBT;
  num? lTDEBTPERASSETS;
  num? cASHPERASSETS;
  num? nETDEBTPEREQUITY;
  num? nETDEBTPERTANGIBLEEQUITY;
  num? tANGIBLEASSETSPEREQUITY;
  num? nETDEBTPERTANGIBLEASSETS;
  num? nETINCGROWTH;
  num? ePSGROWTH;
  num? oPERATINGINCGROWTH;
  num? nETINCGROWTH1;
  num? rEVGROWTH1;
  num? rEVGROWTH1Y;
  num? gRPROFITGROWTH;
  num? oPERATINGINCGROWTH1;
  num? gRPROFITGROWTH1;
  num? aSSETSTURN;
  num? iNVENTORYTURN;
  num? rECTURN;
  num? pAYTURN;
  num? mSCORE;
  num? fSCORE;
  num? zSCORE;
  num? cSCORE;
  num? aLGOSCORE;
  num? mBSSCORE;
  num? dVDGROWTH;
  num? dVDPAIDRATE;
  num? oPERATINGMARGIN;
  num? rECTURN1;
  num? gRMARGIN;
  num? rOIC;
  num? oPERATINGMARGIN1;
  num? bFTAXMARGIN;
  num? cASHTURN;
  num? dEBTPERCAPITAL;
  num? dEBTPEREQUITY;
  num? iNVENTORYDAYS;
  num? rECDAYS;
  num? pAYDAYS;
  num? fIXEDASSETSTURN;
  num? rECTURN2;
  num? cAPITALTURN;
  num? ePS;
  num? dVD1Y;
  num? rSI14;
  num? aDI14;
  num? mACD12269;
  num? bBAND202;
  num? pPERSMA10;
  num? sTOCHASTIC1433;
  num? sTOCHASTICRSI14;
  num? aTR14;
  num? wILLIAMR14;
  num? mFI14;
  num? mAENVELOPES2025;
  num? pPEREMA10;
  num? pPERDEMA10;
  num? pPERWMA10;
  num? sMA5PERSMA20;
  num? eMA5PEREMA20;
  num? dEMA5PERDEMA20;
  num? wMA5PERWMA20;

  StockFilter(
      {this.sECURITYCODE,
        this.eXCHANGECODE,
        this.iNDUSTRYCODE,
        this.iNDUSTRYNAME,
        this.iNDUSTRYNAMEEN,
        this.iNDUSTRYNAMECN,
        this.iNDUSTRYNAMEKR,
        this.iNDUSTRYNAMEJP,
        this.pPERMAX52W,
        this.pPERMIN52W,
        this.sTDP1Y,
        this.mC,
        this.eV,
        this.tOTALVOL,
        this.aVGVOL5D,
        this.aVGVOL10D,
        this.aVGVOL20D,
        this.aVGVOL30D,
        this.aVGVOL60D,
        this.aVGVOLYTD,
        this.aVGVOL1Y,
        this.tOTALVAL,
        this.aVGVAL5D,
        this.aVGVAL10D,
        this.aVGVAL20D,
        this.aVGVAL30D,
        this.aVGVAL60D,
        this.aVGVALYTD,
        this.aVGVAL1Y,
        this.vOLPER5D,
        this.vOLPER10D,
        this.vOLPER20D,
        this.vALPER5D,
        this.vALPER10D,
        this.vALPER20D,
        this.fBUYVALUE,
        this.fSELLVALUE,
        this.fNETBUYVALUE,
        this.aVGFNETBUY5D,
        this.aVGFNETBUY10D,
        this.aVGFNETBUY20D,
        this.aVGFNETBUY30D,
        this.aVGFNETBUY60D,
        this.aVGFNETBUYYTD,
        this.aVGFNETBUY1Y,
        this.fBUYVOLUME,
        this.fSELLVOLUME,
        this.fNETBUYVOLUME,
        this.aVGFNETBUYVOL5D,
        this.aVGFNETBUYVOL10D,
        this.aVGFNETBUYVOL20D,
        this.aVGFNETBUYVOL30D,
        this.aVGFNETBUYVOL60D,
        this.aVGFNETBUYVOLYTD,
        this.aVGFNETBUYVOL1Y,
        this.pIBUYVALUE,
        this.pISELLVALUE,
        this.pINETBUYVALUE,
        this.pISELLVALPER5D,
        this.pISELLVALPER10D,
        this.pISELLVALPER20D,
        this.aVGPINETBUY5D,
        this.aVGPINETBUY10D,
        this.aVGPINETBUY20D,
        this.aVGPINETBUY30D,
        this.aVGPINETBUY60D,
        this.aVGPINETBUYYTD,
        this.aVGPINETBUY1Y,
        this.pIBUYVOLUME,
        this.pISELLVOLUME,
        this.pINETBUYVOLUME,
        this.aVGPINETBUYVOL5D,
        this.aVGPINETBUYVOL10D,
        this.aVGPINETBUYVOL20D,
        this.aVGPINETBUYVOL30D,
        this.aVGPINETBUYVOL60D,
        this.aVGPINETBUYVOLYTD,
        this.aVGPINETBUYVOL1Y,
        this.pPER20D,
        this.pPER50D,
        this.pPER130D,
        this.pPER200D,
        this.pCHANGE1W,
        this.pCHANGE1M,
        this.pCHANGE3M,
        this.pCHANGE6M,
        this.pCHANGE1Y,
        this.rS1W,
        this.rS1M,
        this.rS3M,
        this.rS6M,
        this.rS1Y,
        this.vOL10DVS3M,
        this.pE,
        this.pB,
        this.pS,
        this.nETDEBTPERMC,
        this.dVDPERP,
        this.pPERFCF,
        this.eVPEREBITDA,
        this.eVPEREBIT,
        this.rOA,
        this.rOE,
        this.nETMARGIN,
        this.rOCE,
        this.cURRRATIO,
        this.qUICKRATIO,
        this.cASHRATIO,
        this.dEBTPERASSETS,
        this.lEVERAGE,
        this.iNTCOVERAGE,
        this.fCFPERLTDEBT,
        this.lTDEBTPERASSETS,
        this.cASHPERASSETS,
        this.nETDEBTPEREQUITY,
        this.nETDEBTPERTANGIBLEEQUITY,
        this.tANGIBLEASSETSPEREQUITY,
        this.nETDEBTPERTANGIBLEASSETS,
        this.nETINCGROWTH,
        this.ePSGROWTH,
        this.oPERATINGINCGROWTH,
        this.nETINCGROWTH1,
        this.rEVGROWTH1,
        this.rEVGROWTH1Y,
        this.gRPROFITGROWTH,
        this.oPERATINGINCGROWTH1,
        this.gRPROFITGROWTH1,
        this.aSSETSTURN,
        this.iNVENTORYTURN,
        this.rECTURN,
        this.pAYTURN,
        this.mSCORE,
        this.fSCORE,
        this.zSCORE,
        this.cSCORE,
        this.aLGOSCORE,
        this.mBSSCORE,
        this.dVDGROWTH,
        this.dVDPAIDRATE,
        this.oPERATINGMARGIN,
        this.rECTURN1,
        this.gRMARGIN,
        this.rOIC,
        this.oPERATINGMARGIN1,
        this.bFTAXMARGIN,
        this.cASHTURN,
        this.dEBTPERCAPITAL,
        this.dEBTPEREQUITY,
        this.iNVENTORYDAYS,
        this.rECDAYS,
        this.pAYDAYS,
        this.fIXEDASSETSTURN,
        this.rECTURN2,
        this.cAPITALTURN,
        this.ePS,
        this.dVD1Y,
        this.rSI14,
        this.aDI14,
        this.mACD12269,
        this.bBAND202,
        this.pPERSMA10,
        this.sTOCHASTIC1433,
        this.sTOCHASTICRSI14,
        this.aTR14,
        this.wILLIAMR14,
        this.mFI14,
        this.mAENVELOPES2025,
        this.pPEREMA10,
        this.pPERDEMA10,
        this.pPERWMA10,
        this.sMA5PERSMA20,
        this.eMA5PEREMA20,
        this.dEMA5PERDEMA20,
        this.wMA5PERWMA20});

  StockFilter.fromJson(Map<String, dynamic> json) {
    sECURITYCODE = json['SECURITY_CODE'];
    eXCHANGECODE = json['EXCHANGE_CODE'];
    iNDUSTRYCODE = json['INDUSTRY_CODE'];
    iNDUSTRYNAME = json['INDUSTRY_NAME'];
    iNDUSTRYNAMEEN = json['INDUSTRY_NAME_EN'];
    iNDUSTRYNAMECN = json['INDUSTRY_NAME_CN'];
    iNDUSTRYNAMEKR = json['INDUSTRY_NAME_KR'];
    iNDUSTRYNAMEJP = json['INDUSTRY_NAME_JP'];
    pPERMAX52W = json['P_PER_MAX_52W'];
    pPERMIN52W = json['P_PER_MIN_52W'];
    sTDP1Y = json['STD_P_1Y'];
    mC = json['MC'];
    eV = json['EV'];
    tOTALVOL = json['TOTAL_VOL'];
    aVGVOL5D = json['AVG_VOL_5D'];
    aVGVOL10D = json['AVG_VOL_10D'];
    aVGVOL20D = json['AVG_VOL_20D'];
    aVGVOL30D = json['AVG_VOL_30D'];
    aVGVOL60D = json['AVG_VOL_60D'];
    aVGVOLYTD = json['AVG_VOL_YTD'];
    aVGVOL1Y = json['AVG_VOL_1Y'];
    tOTALVAL = json['TOTAL_VAL'];
    aVGVAL5D = json['AVG_VAL_5D'];
    aVGVAL10D = json['AVG_VAL_10D'];
    aVGVAL20D = json['AVG_VAL_20D'];
    aVGVAL30D = json['AVG_VAL_30D'];
    aVGVAL60D = json['AVG_VAL_60D'];
    aVGVALYTD = json['AVG_VAL_YTD'];
    aVGVAL1Y = json['AVG_VAL_1Y'];
    vOLPER5D = json['VOL_PER_5D'];
    vOLPER10D = json['VOL_PER_10D'];
    vOLPER20D = json['VOL_PER_20D'];
    vALPER5D = json['VAL_PER_5D'];
    vALPER10D = json['VAL_PER_10D'];
    vALPER20D = json['VAL_PER_20D'];
    fBUYVALUE = json['F_BUY_VALUE'];
    fSELLVALUE = json['F_SELL_VALUE'];
    fNETBUYVALUE = json['F_NET_BUY_VALUE'];
    aVGFNETBUY5D = json['AVG_F_NET_BUY_5D'];
    aVGFNETBUY10D = json['AVG_F_NET_BUY_10D'];
    aVGFNETBUY20D = json['AVG_F_NET_BUY_20D'];
    aVGFNETBUY30D = json['AVG_F_NET_BUY_30D'];
    aVGFNETBUY60D = json['AVG_F_NET_BUY_60D'];
    aVGFNETBUYYTD = json['AVG_F_NET_BUY_YTD'];
    aVGFNETBUY1Y = json['AVG_F_NET_BUY_1Y'];
    fBUYVOLUME = json['F_BUY_VOLUME'];
    fSELLVOLUME = json['F_SELL_VOLUME'];
    fNETBUYVOLUME = json['F_NET_BUY_VOLUME'];
    aVGFNETBUYVOL5D = json['AVG_F_NET_BUY_VOL_5D'];
    aVGFNETBUYVOL10D = json['AVG_F_NET_BUY_VOL_10D'];
    aVGFNETBUYVOL20D = json['AVG_F_NET_BUY_VOL_20D'];
    aVGFNETBUYVOL30D = json['AVG_F_NET_BUY_VOL_30D'];
    aVGFNETBUYVOL60D = json['AVG_F_NET_BUY_VOL_60D'];
    aVGFNETBUYVOLYTD = json['AVG_F_NET_BUY_VOL_YTD'];
    aVGFNETBUYVOL1Y = json['AVG_F_NET_BUY_VOL_1Y'];
    pIBUYVALUE = json['PI_BUY_VALUE'];
    pISELLVALUE = json['PI_SELL_VALUE'];
    pINETBUYVALUE = json['PI_NET_BUY_VALUE'];
    pISELLVALPER5D = json['PI_SELL_VAL_PER_5D'];
    pISELLVALPER10D = json['PI_SELL_VAL_PER_10D'];
    pISELLVALPER20D = json['PI_SELL_VAL_PER_20D'];
    aVGPINETBUY5D = json['AVG_PI_NET_BUY_5D'];
    aVGPINETBUY10D = json['AVG_PI_NET_BUY_10D'];
    aVGPINETBUY20D = json['AVG_PI_NET_BUY_20D'];
    aVGPINETBUY30D = json['AVG_PI_NET_BUY_30D'];
    aVGPINETBUY60D = json['AVG_PI_NET_BUY_60D'];
    aVGPINETBUYYTD = json['AVG_PI_NET_BUY_YTD'];
    aVGPINETBUY1Y = json['AVG_PI_NET_BUY_1Y'];
    pIBUYVOLUME = json['PI_BUY_VOLUME'];
    pISELLVOLUME = json['PI_SELL_VOLUME'];
    pINETBUYVOLUME = json['PI_NET_BUY_VOLUME'];
    aVGPINETBUYVOL5D = json['AVG_PI_NET_BUY_VOL_5D'];
    aVGPINETBUYVOL10D = json['AVG_PI_NET_BUY_VOL_10D'];
    aVGPINETBUYVOL20D = json['AVG_PI_NET_BUY_VOL_20D'];
    aVGPINETBUYVOL30D = json['AVG_PI_NET_BUY_VOL_30D'];
    aVGPINETBUYVOL60D = json['AVG_PI_NET_BUY_VOL_60D'];
    aVGPINETBUYVOLYTD = json['AVG_PI_NET_BUY_VOL_YTD'];
    aVGPINETBUYVOL1Y = json['AVG_PI_NET_BUY_VOL_1Y'];
    pPER20D = json['P_PER_20D'];
    pPER50D = json['P_PER_50D'];
    pPER130D = json['P_PER_130D'];
    pPER200D = json['P_PER_200D'];
    pCHANGE1W = json['P_CHANGE_1W'];
    pCHANGE1M = json['P_CHANGE_1M'];
    pCHANGE3M = json['P_CHANGE_3M'];
    pCHANGE6M = json['P_CHANGE_6M'];
    pCHANGE1Y = json['P_CHANGE_1Y'];
    rS1W = json['RS1W'];
    rS1M = json['RS1M'];
    rS3M = json['RS3M'];
    rS6M = json['RS6M'];
    rS1Y = json['RS1Y'];
    vOL10DVS3M = json['VOL_10D_VS_3M'];
    pE = json['PE'];
    pB = json['PB'];
    pS = json['PS'];
    nETDEBTPERMC = json['NET_DEBT_PER_MC'];
    dVDPERP = json['DVD_PER_P'];
    pPERFCF = json['P_PER_FCF'];
    eVPEREBITDA = json['EV_PER_EBITDA'];
    eVPEREBIT = json['EV_PER_EBIT'];
    rOA = json['ROA'];
    rOE = json['ROE'];
    nETMARGIN = json['NET_MARGIN'];
    rOCE = json['ROCE'];
    cURRRATIO = json['CURR_RATIO'];
    qUICKRATIO = json['QUICK_RATIO'];
    cASHRATIO = json['CASH_RATIO'];
    dEBTPERASSETS = json['DEBT_PER_ASSETS'];
    lEVERAGE = json['LEVERAGE'];
    iNTCOVERAGE = json['INT_COVERAGE'];
    fCFPERLTDEBT = json['FCF_PER_LT_DEBT'];
    lTDEBTPERASSETS = json['LT_DEBT_PER_ASSETS'];
    cASHPERASSETS = json['CASH_PER_ASSETS'];
    nETDEBTPEREQUITY = json['NET_DEBT_PER_EQUITY'];
    nETDEBTPERTANGIBLEEQUITY = json['NET_DEBT_PER_TANGIBLE_EQUITY'];
    tANGIBLEASSETSPEREQUITY = json['TANGIBLE_ASSETS_PER_EQUITY'];
    nETDEBTPERTANGIBLEASSETS = json['NET_DEBT_PER_TANGIBLE_ASSETS'];
    nETINCGROWTH = json['NET_INC_GROWTH'];
    ePSGROWTH = json['EPS_GROWTH'];
    oPERATINGINCGROWTH = json['OPERATING_INC_GROWTH'];
    nETINCGROWTH1 = json['NET_INC_GROWTH1'];
    rEVGROWTH1 = json['REV_GROWTH1'];
    rEVGROWTH1Y = json['REV_GROWTH_1Y'];
    gRPROFITGROWTH = json['GR_PROFIT_GROWTH'];
    oPERATINGINCGROWTH1 = json['OPERATING_INC_GROWTH1'];
    gRPROFITGROWTH1 = json['GR_PROFIT_GROWTH1'];
    aSSETSTURN = json['ASSETS_TURN'];
    iNVENTORYTURN = json['INVENTORY_TURN'];
    rECTURN = json['REC_TURN'];
    pAYTURN = json['PAY_TURN'];
    mSCORE = json['M_SCORE'];
    fSCORE = json['F_SCORE'];
    zSCORE = json['Z_SCORE'];
    cSCORE = json['C_SCORE'];
    aLGOSCORE = json['ALGO_SCORE'];
    mBSSCORE = json['MBS_SCORE'];
    dVDGROWTH = json['DVD_GROWTH'];
    dVDPAIDRATE = json['DVD_PAID_RATE'];
    oPERATINGMARGIN = json['OPERATING_MARGIN'];
    rECTURN1 = json['REC_TURN1'];
    gRMARGIN = json['GR_MARGIN'];
    rOIC = json['ROIC'];
    oPERATINGMARGIN1 = json['OPERATING_MARGIN1'];
    bFTAXMARGIN = json['BF_TAX_MARGIN'];
    cASHTURN = json['CASH_TURN'];
    dEBTPERCAPITAL = json['DEBT_PER_CAPITAL'];
    dEBTPEREQUITY = json['DEBT_PER_EQUITY'];
    iNVENTORYDAYS = json['INVENTORY_DAYS'];
    rECDAYS = json['REC_DAYS'];
    pAYDAYS = json['PAY_DAYS'];
    fIXEDASSETSTURN = json['FIXED_ASSETS_TURN'];
    rECTURN2 = json['REC_TURN2'];
    cAPITALTURN = json['CAPITAL_TURN'];
    ePS = json['EPS'];
    dVD1Y = json['DVD_1Y'];
    rSI14 = json['RSI_14'];
    aDI14 = json['ADI_14'];
    mACD12269 = json['MACD_12_26_9'];
    bBAND202 = json['BBAND_20_2'];
    pPERSMA10 = json['P_PER_SMA10'];
    sTOCHASTIC1433 = json['STOCHASTIC_14_3_3'];
    sTOCHASTICRSI14 = json['STOCHASTIC_RSI_14'];
    aTR14 = json['ATR_14'];
    wILLIAMR14 = json['WILLIAMR_14'];
    mFI14 = json['MFI_14'];
    mAENVELOPES2025 = json['MA_ENVELOPES_20_25'];
    pPEREMA10 = json['P_PER_EMA10'];
    pPERDEMA10 = json['P_PER_DEMA10'];
    pPERWMA10 = json['P_PER_WMA10'];
    sMA5PERSMA20 = json['SMA5_PER_SMA20'];
    eMA5PEREMA20 = json['EMA5_PER_EMA20'];
    dEMA5PERDEMA20 = json['DEMA5_PER_DEMA20'];
    wMA5PERWMA20 = json['WMA5_PER_WMA20'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SECURITY_CODE'] = sECURITYCODE;
    data['EXCHANGE_CODE'] = eXCHANGECODE;
    data['INDUSTRY_CODE'] = iNDUSTRYCODE;
    data['INDUSTRY_NAME'] = iNDUSTRYNAME;
    data['INDUSTRY_NAME_EN'] = iNDUSTRYNAMEEN;
    data['INDUSTRY_NAME_CN'] = iNDUSTRYNAMECN;
    data['INDUSTRY_NAME_KR'] = iNDUSTRYNAMEKR;
    data['INDUSTRY_NAME_JP'] = iNDUSTRYNAMEJP;
    data['P_PER_MAX_52W'] = pPERMAX52W;
    data['P_PER_MIN_52W'] = pPERMIN52W;
    data['STD_P_1Y'] = sTDP1Y;
    data['MC'] = mC;
    data['EV'] = eV;
    data['TOTAL_VOL'] = tOTALVOL;
    data['AVG_VOL_5D'] = aVGVOL5D;
    data['AVG_VOL_10D'] = aVGVOL10D;
    data['AVG_VOL_20D'] = aVGVOL20D;
    data['AVG_VOL_30D'] = aVGVOL30D;
    data['AVG_VOL_60D'] = aVGVOL60D;
    data['AVG_VOL_YTD'] = aVGVOLYTD;
    data['AVG_VOL_1Y'] = aVGVOL1Y;
    data['TOTAL_VAL'] = tOTALVAL;
    data['AVG_VAL_5D'] = aVGVAL5D;
    data['AVG_VAL_10D'] = aVGVAL10D;
    data['AVG_VAL_20D'] = aVGVAL20D;
    data['AVG_VAL_30D'] = aVGVAL30D;
    data['AVG_VAL_60D'] = aVGVAL60D;
    data['AVG_VAL_YTD'] = aVGVALYTD;
    data['AVG_VAL_1Y'] = aVGVAL1Y;
    data['VOL_PER_5D'] = vOLPER5D;
    data['VOL_PER_10D'] = vOLPER10D;
    data['VOL_PER_20D'] = vOLPER20D;
    data['VAL_PER_5D'] = vALPER5D;
    data['VAL_PER_10D'] = vALPER10D;
    data['VAL_PER_20D'] = vALPER20D;
    data['F_BUY_VALUE'] = fBUYVALUE;
    data['F_SELL_VALUE'] = fSELLVALUE;
    data['F_NET_BUY_VALUE'] = fNETBUYVALUE;
    data['AVG_F_NET_BUY_5D'] = aVGFNETBUY5D;
    data['AVG_F_NET_BUY_10D'] = aVGFNETBUY10D;
    data['AVG_F_NET_BUY_20D'] = aVGFNETBUY20D;
    data['AVG_F_NET_BUY_30D'] = aVGFNETBUY30D;
    data['AVG_F_NET_BUY_60D'] = aVGFNETBUY60D;
    data['AVG_F_NET_BUY_YTD'] = aVGFNETBUYYTD;
    data['AVG_F_NET_BUY_1Y'] = aVGFNETBUY1Y;
    data['F_BUY_VOLUME'] = fBUYVOLUME;
    data['F_SELL_VOLUME'] = fSELLVOLUME;
    data['F_NET_BUY_VOLUME'] = fNETBUYVOLUME;
    data['AVG_F_NET_BUY_VOL_5D'] = aVGFNETBUYVOL5D;
    data['AVG_F_NET_BUY_VOL_10D'] = aVGFNETBUYVOL10D;
    data['AVG_F_NET_BUY_VOL_20D'] = aVGFNETBUYVOL20D;
    data['AVG_F_NET_BUY_VOL_30D'] = aVGFNETBUYVOL30D;
    data['AVG_F_NET_BUY_VOL_60D'] = aVGFNETBUYVOL60D;
    data['AVG_F_NET_BUY_VOL_YTD'] = aVGFNETBUYVOLYTD;
    data['AVG_F_NET_BUY_VOL_1Y'] = aVGFNETBUYVOL1Y;
    data['PI_BUY_VALUE'] = pIBUYVALUE;
    data['PI_SELL_VALUE'] = pISELLVALUE;
    data['PI_NET_BUY_VALUE'] = pINETBUYVALUE;
    data['PI_SELL_VAL_PER_5D'] = pISELLVALPER5D;
    data['PI_SELL_VAL_PER_10D'] = pISELLVALPER10D;
    data['PI_SELL_VAL_PER_20D'] = pISELLVALPER20D;
    data['AVG_PI_NET_BUY_5D'] = aVGPINETBUY5D;
    data['AVG_PI_NET_BUY_10D'] = aVGPINETBUY10D;
    data['AVG_PI_NET_BUY_20D'] = aVGPINETBUY20D;
    data['AVG_PI_NET_BUY_30D'] = aVGPINETBUY30D;
    data['AVG_PI_NET_BUY_60D'] = aVGPINETBUY60D;
    data['AVG_PI_NET_BUY_YTD'] = aVGPINETBUYYTD;
    data['AVG_PI_NET_BUY_1Y'] = aVGPINETBUY1Y;
    data['PI_BUY_VOLUME'] = pIBUYVOLUME;
    data['PI_SELL_VOLUME'] = pISELLVOLUME;
    data['PI_NET_BUY_VOLUME'] = pINETBUYVOLUME;
    data['AVG_PI_NET_BUY_VOL_5D'] = aVGPINETBUYVOL5D;
    data['AVG_PI_NET_BUY_VOL_10D'] = aVGPINETBUYVOL10D;
    data['AVG_PI_NET_BUY_VOL_20D'] = aVGPINETBUYVOL20D;
    data['AVG_PI_NET_BUY_VOL_30D'] = aVGPINETBUYVOL30D;
    data['AVG_PI_NET_BUY_VOL_60D'] = aVGPINETBUYVOL60D;
    data['AVG_PI_NET_BUY_VOL_YTD'] = aVGPINETBUYVOLYTD;
    data['AVG_PI_NET_BUY_VOL_1Y'] = aVGPINETBUYVOL1Y;
    data['P_PER_20D'] = pPER20D;
    data['P_PER_50D'] = pPER50D;
    data['P_PER_130D'] = pPER130D;
    data['P_PER_200D'] = pPER200D;
    data['P_CHANGE_1W'] = pCHANGE1W;
    data['P_CHANGE_1M'] = pCHANGE1M;
    data['P_CHANGE_3M'] = pCHANGE3M;
    data['P_CHANGE_6M'] = pCHANGE6M;
    data['P_CHANGE_1Y'] = pCHANGE1Y;
    data['RS1W'] = rS1W;
    data['RS1M'] = rS1M;
    data['RS3M'] = rS3M;
    data['RS6M'] = rS6M;
    data['RS1Y'] = rS1Y;
    data['VOL_10D_VS_3M'] = vOL10DVS3M;
    data['PE'] = pE;
    data['PB'] = pB;
    data['PS'] = pS;
    data['NET_DEBT_PER_MC'] = nETDEBTPERMC;
    data['DVD_PER_P'] = dVDPERP;
    data['P_PER_FCF'] = pPERFCF;
    data['EV_PER_EBITDA'] = eVPEREBITDA;
    data['EV_PER_EBIT'] = eVPEREBIT;
    data['ROA'] = rOA;
    data['ROE'] = rOE;
    data['NET_MARGIN'] = nETMARGIN;
    data['ROCE'] = rOCE;
    data['CURR_RATIO'] = cURRRATIO;
    data['QUICK_RATIO'] = qUICKRATIO;
    data['CASH_RATIO'] = cASHRATIO;
    data['DEBT_PER_ASSETS'] = dEBTPERASSETS;
    data['LEVERAGE'] = lEVERAGE;
    data['INT_COVERAGE'] = iNTCOVERAGE;
    data['FCF_PER_LT_DEBT'] = fCFPERLTDEBT;
    data['LT_DEBT_PER_ASSETS'] = lTDEBTPERASSETS;
    data['CASH_PER_ASSETS'] = cASHPERASSETS;
    data['NET_DEBT_PER_EQUITY'] = nETDEBTPEREQUITY;
    data['NET_DEBT_PER_TANGIBLE_EQUITY'] = nETDEBTPERTANGIBLEEQUITY;
    data['TANGIBLE_ASSETS_PER_EQUITY'] = tANGIBLEASSETSPEREQUITY;
    data['NET_DEBT_PER_TANGIBLE_ASSETS'] = nETDEBTPERTANGIBLEASSETS;
    data['NET_INC_GROWTH'] = nETINCGROWTH;
    data['EPS_GROWTH'] = ePSGROWTH;
    data['OPERATING_INC_GROWTH'] = oPERATINGINCGROWTH;
    data['NET_INC_GROWTH1'] = nETINCGROWTH1;
    data['REV_GROWTH1'] = rEVGROWTH1;
    data['REV_GROWTH_1Y'] = rEVGROWTH1Y;
    data['GR_PROFIT_GROWTH'] = gRPROFITGROWTH;
    data['OPERATING_INC_GROWTH1'] = oPERATINGINCGROWTH1;
    data['GR_PROFIT_GROWTH1'] = gRPROFITGROWTH1;
    data['ASSETS_TURN'] = aSSETSTURN;
    data['INVENTORY_TURN'] = iNVENTORYTURN;
    data['REC_TURN'] = rECTURN;
    data['PAY_TURN'] = pAYTURN;
    data['M_SCORE'] = mSCORE;
    data['F_SCORE'] = fSCORE;
    data['Z_SCORE'] = zSCORE;
    data['C_SCORE'] = cSCORE;
    data['ALGO_SCORE'] = aLGOSCORE;
    data['MBS_SCORE'] = mBSSCORE;
    data['DVD_GROWTH'] = dVDGROWTH;
    data['DVD_PAID_RATE'] = dVDPAIDRATE;
    data['OPERATING_MARGIN'] = oPERATINGMARGIN;
    data['REC_TURN1'] = rECTURN1;
    data['GR_MARGIN'] = gRMARGIN;
    data['ROIC'] = rOIC;
    data['OPERATING_MARGIN1'] = oPERATINGMARGIN1;
    data['BF_TAX_MARGIN'] = bFTAXMARGIN;
    data['CASH_TURN'] = cASHTURN;
    data['DEBT_PER_CAPITAL'] = dEBTPERCAPITAL;
    data['DEBT_PER_EQUITY'] = dEBTPEREQUITY;
    data['INVENTORY_DAYS'] = iNVENTORYDAYS;
    data['REC_DAYS'] = rECDAYS;
    data['PAY_DAYS'] = pAYDAYS;
    data['FIXED_ASSETS_TURN'] = fIXEDASSETSTURN;
    data['REC_TURN2'] = rECTURN2;
    data['CAPITAL_TURN'] = cAPITALTURN;
    data['EPS'] = ePS;
    data['DVD_1Y'] = dVD1Y;
    data['RSI_14'] = rSI14;
    data['ADI_14'] = aDI14;
    data['MACD_12_26_9'] = mACD12269;
    data['BBAND_20_2'] = bBAND202;
    data['P_PER_SMA10'] = pPERSMA10;
    data['STOCHASTIC_14_3_3'] = sTOCHASTIC1433;
    data['STOCHASTIC_RSI_14'] = sTOCHASTICRSI14;
    data['ATR_14'] = aTR14;
    data['WILLIAMR_14'] = wILLIAMR14;
    data['MFI_14'] = mFI14;
    data['MA_ENVELOPES_20_25'] = mAENVELOPES2025;
    data['P_PER_EMA10'] = pPEREMA10;
    data['P_PER_DEMA10'] = pPERDEMA10;
    data['P_PER_WMA10'] = pPERWMA10;
    data['SMA5_PER_SMA20'] = sMA5PERSMA20;
    data['EMA5_PER_EMA20'] = eMA5PEREMA20;
    data['DEMA5_PER_DEMA20'] = dEMA5PERDEMA20;
    data['WMA5_PER_WMA20'] = wMA5PERWMA20;
    return data;
  }
}
