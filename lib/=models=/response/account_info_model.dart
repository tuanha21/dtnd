import 'package:dtnd/=models=/core_response_model.dart';

class UserInfo implements CoreResponseModel {
  late final String cCUSTOMERCODE;
  late final String cCUSTFULLNAME;
  late final String cIDISSUEDATE;
  late final String cIDEXPIREDATE;
  late final String cIDISSUEPLACE;
  late final String cCUSTEMAIL;
  late final String cCUSTTEL;
  late final String cAUTHENSIGN;
  late final String authenType;
  late final String cCONTACTADDRESS;
  late final String cCUSTMOBILE;
  late final String cCARDID;
  late final String cCUSTRESEDENCEADDRESS;
  late final String cMARKETINGID;
  late final String cMKTNAME;
  late final String cSIGNIMG;
  late final String? cFACEIMG;
  late final String cFRONTCARD;
  late final double cBONUSINFO;

  UserInfo({
    required this.cCUSTOMERCODE,
    required this.cCUSTFULLNAME,
    required this.cIDISSUEDATE,
    required this.cIDEXPIREDATE,
    required this.cIDISSUEPLACE,
    required this.cCUSTEMAIL,
    required this.cCUSTTEL,
    required this.cAUTHENSIGN,
    required this.authenType,
    required this.cCONTACTADDRESS,
    required this.cCUSTMOBILE,
    required this.cCARDID,
    required this.cCUSTRESEDENCEADDRESS,
    required this.cMARKETINGID,
    required this.cMKTNAME,
    required this.cSIGNIMG,
    required this.cFACEIMG,
    required this.cFRONTCARD,
    required this.cBONUSINFO,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'] ?? "";
    cCUSTFULLNAME = json['C_CUST_FULL_NAME'] ?? "";
    cIDISSUEDATE = json['C_ID_ISSUE_DATE'] ?? "";
    cIDEXPIREDATE = json['C_ID_EXPIRE_DATE'] ?? "";
    cIDISSUEPLACE = json['C_ID_ISSUE_PLACE'] ?? "";
    cCUSTEMAIL = json['C_CUST_EMAIL'] ?? "";
    cCUSTTEL = json['C_CUST_TEL'] ?? "";
    cAUTHENSIGN = json['C_AUTHEN_SIGN'] ?? "";
    authenType = json['C_AUTHEN_SIGN'] ?? "";
    cCONTACTADDRESS = json['C_CONTACT_ADDRESS'] ?? "";
    // if (cCONTACTADDRESS == "null") {
    //   cCONTACTADDRESS = "";
    // }
    cCUSTMOBILE = json['C_CUST_MOBILE'] ?? "";
    cCARDID = json['C_CARD_ID'] ?? "";
    cCUSTRESEDENCEADDRESS = json['C_CUST_RESEDENCE_ADDRESS'] ?? "";
    cMARKETINGID = json['C_MARKETING_ID'] ?? "";
    cMKTNAME = json['C_MKT_NAME'] ?? "";
    cSIGNIMG = json['C_SIGN_IMG'] ?? "";
    cFACEIMG = json['C_FACE_IMG'] == "null" ? null : json['C_FACE_IMG'];
    cFRONTCARD = json['C_FRONT_CARD'] ?? "";
    cBONUSINFO = json['C_BONUS_INFO'] ?? 0;
  }

  // UserInfo.constant() {
  //   cCUSTOMERCODE = "005C666666";
  //   cCUSTFULLNAME = "Nguyễn Trung Kiên";
  //   cIDISSUEDATE = "07/09/2015";
  //   cIDEXPIREDATE = "hfjkahsjkhjkad";
  //   cIDISSUEPLACE = "CỤC TRƯỞNG CỤC CẢNH SÁT";
  //   cCUSTEMAIL = "dat9d3@gmail.com";
  //   cCUSTTEL = "hfjkahsjkhjkad";
  //   cAUTHENSIGN = "hfjkahsjkhjkad";
  //   authenType = "hfjkahsjkhjkad";
  //   cCONTACTADDRESS = "Chùa Hàng, Dư Hàng, Lê Chân, Hải Phòng";
  //   if (cCONTACTADDRESS == "null") {
  //     cCONTACTADDRESS = "hfjkahsjkhjkad";
  //   }
  //   cCUSTMOBILE = "0989999999";
  //   cCARDID = "031200003055";
  //   cCUSTRESEDENCEADDRESS = "hfjkahsjkhjkad";
  //   cMARKETINGID = "hfjkahsjkhjkad";
  //   cMKTNAME = "hfjkahsjkhjkad";
  //   cSIGNIMG = "hfjkahsjkhjkad";
  //   cFACEIMG = "hfjkahsjkhjkad";
  //   cFRONTCARD = "hfjkahsjkhjkad";
  //   cBONUSINFO = 0;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_CUSTOMER_CODE'] = cCUSTOMERCODE;
    data['C_CUST_FULL_NAME'] = cCUSTFULLNAME;
    data['C_ID_ISSUE_DATE'] = cIDISSUEDATE;
    data['C_ID_EXPIRE_DATE'] = cIDEXPIREDATE;
    data['C_ID_ISSUE_PLACE'] = cIDISSUEPLACE;
    data['C_CUST_EMAIL'] = cCUSTEMAIL;
    data['C_CUST_TEL'] = cCUSTTEL;
    data['C_AUTHEN_SIGN'] = cAUTHENSIGN;
    data['C_CONTACT_ADDRESS'] = cCONTACTADDRESS;
    data['C_CUST_MOBILE'] = cCUSTMOBILE;
    data['C_CARD_ID'] = cCARDID;
    data['C_CUST_RESEDENCE_ADDRESS'] = cCUSTRESEDENCEADDRESS;
    data['C_MARKETING_ID'] = cMARKETINGID;
    data['C_MKT_NAME'] = cMKTNAME;
    data['C_SIGN_IMG'] = cSIGNIMG;
    data['C_FACE_IMG'] = cFACEIMG;
    data['C_FRONT_CARD'] = cFRONTCARD;
    return data;
  }
}
