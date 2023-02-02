import 'dart:ui';

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';

class WorldIndexModel {
  String? nAME;
  num? lASTPOINT;
  String? cHANGE;
  String? pERCENTCHANGE;
  Color? cOLOR;
  num? iSSHOW;
  num? sTT;
  int? iDSYMBOL;
  num? iSDEFAULT;

  WorldIndexModel(
      {this.nAME,
      this.lASTPOINT,
      this.cHANGE,
      this.pERCENTCHANGE,
      this.cOLOR,
      this.iSSHOW,
      this.sTT,
      this.iDSYMBOL,
      this.iSDEFAULT});

  WorldIndexModel.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    lASTPOINT = num.parse(json['LAST_POINT'].replaceAll(",", "") ?? 0);
    cHANGE = json['CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    switch (json['COLOR']) {
      case "green":
        cOLOR = AppColors.semantic_01;
        break;
      case "red":
        cOLOR = AppColors.semantic_03;
        break;
      default:
        cOLOR = AppColors.semantic_02;
    }
    iSSHOW = json['IS_SHOW'];
    sTT = json['STT'];
    iDSYMBOL = json['ID_SYMBOL'];
    iSDEFAULT = json['IS_DEFAULT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAME'] = nAME;
    data['LAST_POINT'] = lASTPOINT;
    data['CHANGE'] = cHANGE;
    data['PERCENT_CHANGE'] = pERCENTCHANGE;
    data['COLOR'] = cOLOR;
    data['IS_SHOW'] = iSSHOW;
    data['STT'] = sTT;
    data['ID_SYMBOL'] = iDSYMBOL;
    data['IS_DEFAULT'] = iSDEFAULT;
    return data;
  }
}
