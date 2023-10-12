import 'dart:ui';

import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");

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
  List<WorldIndexData>? historyData;

  num? get openPoint {
    try {
      return lASTPOINT! + num.parse(cHANGE!);
    } catch (e) {
      return null;
    }
  }

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

  Future<List<WorldIndexData>?> getHistoryData(
      INetworkService networkService) async {
    if (historyData != null) {
      return historyData;
    }
    final body = {
      "symbolId": "$iDSYMBOL",
      "period": "oneYear",
    };
    historyData = await networkService.getWorldIndexData(body);
    return historyData;
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

class WorldIndexData {
  DateTime? dateTime;
  num? value;

  WorldIndexData.fromJson(Map<String, dynamic> json) {
    dateTime = dateFormat.parse(json["dateTime"]);
    try {
      value = json["value"];
    } catch (e) {
      logger.e(e);
    }
  }
}
