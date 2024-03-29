import 'dart:ui';

import 'package:dtnd/=models=/stock_status.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:get/get.dart';

enum IndexStatus {
  opening,
  intermission,
  closed,
}

extension IndexStatusX on IndexStatus {
  Color get color {
    switch (this) {
      case IndexStatus.opening:
        return AppColors.semantic_01;
      case IndexStatus.intermission:
        return AppColors.semantic_02;
      default:
        return AppColors.semantic_03;
    }
  }
}

class IndexDetail extends StockStatus {
  final int id = 1101;
  late final int mc;
  final Rx<num?> cIndex = Rxn<num>();
  final Rx<num?> oIndex = Rxn<num>();
  final Rx<num?> vol = Rxn<num>();
  final Rx<num?> value = Rxn<num>();
  final Rx<String?> time = Rxn();
  final Rx<IndexStatus> status = Rx<IndexStatus>(IndexStatus.closed);
  final Rx<num?> accVol = Rxn<num>();
  final Rx<List<String>?> ot = Rxn();

  @override
  SStatus get sstatus {
    try {
      final num current = cIndex.value ?? 0;
      final num open = oIndex.value ?? 0;
      if (current == 0 || open == 0 || current == open) {
        return SStatus.ref;
      }
      if (current > open) return SStatus.up;
      if (current < open) return SStatus.down;
      return SStatus.ref;
    } catch (e) {
      return SStatus.ref;
    }
  }

  num get change => num.tryParse(ot.value?.first ?? "0") ?? 0;

  String get changePc => ot.value?.elementAt(1) ?? "0%";

  num get upQuant => num.tryParse(ot.value?.elementAt(3) ?? "0") ?? 0;

  num get downQuant => num.tryParse(ot.value?.elementAt(4) ?? "0") ?? 0;

  num get refQuant => num.tryParse(ot.value?.elementAt(5) ?? "0") ?? 0;

  void changeIndexStatus(String? stt) {
    IndexStatus nextStt;
    switch (stt) {
      case "O":
        nextStt = IndexStatus.opening;
        break;
      case "P":
        nextStt = IndexStatus.opening;
        break;
      case "A":
        nextStt = IndexStatus.opening;
        break;
      case "Undefined":
        nextStt = IndexStatus.opening;
        break;
      case "undefined":
        nextStt = IndexStatus.opening;
        break;
      case "I":
        nextStt = IndexStatus.intermission;
        break;
      case "C":
        nextStt = IndexStatus.closed;
        break;
      default:
        nextStt = IndexStatus.closed;
    }
    if (status.value != nextStt) {
      status.value = nextStt;
    }
    return;
  }

  IndexDetail({
    required this.mc,
    num? cIndex,
    num? oIndex,
    num? vol,
    num? value,
    String? time,
    String? status,
    num? accVol,
    List<String>? ot,
  }) {
    this.cIndex.value = cIndex;
    this.oIndex.value = oIndex;
    this.vol.value = vol;
    this.value.value = value;
    this.time.value = time;
    changeIndexStatus(status);
    this.accVol.value = accVol;
    this.ot.value = ot;
  }

  IndexDetail.fromResponse(IndexDetailResponse data) {
    mc = data.mc;
    cIndex.value = data.cIndex;
    oIndex.value = data.oIndex;
    vol.value = data.vol;
    value.value = data.value;
    time.value = data.time;
    changeIndexStatus(data.status);
    accVol.value = data.accVol;
    ot.value = data.ot;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mc'] = mc;
    data['cIndex'] = cIndex.value;
    data['oIndex'] = oIndex.value;
    data['vol'] = vol.value;
    data['value'] = value.value;
    data['time'] = time.value;
    data['status'] = status.value;
    data['accVol'] = accVol.value;
    data['ot'] = ot.value;
    return data;
  }
}

class IndexDetailResponse {
  final int id = 1101;
  late final int mc;
  num? cIndex;
  num? oIndex;
  num? vol;
  num? value;
  String? time;

  String? status;
  num? accVol;
  List<String>? ot;

  String get valueString {
    if (value == null) return "0";
    try {
      return "${NumUtils.formatInteger((value! / 1000))} tỷ";
    } catch (e) {
      return "0";
    }
  }

  String get statusVN {
    if (status == null) return "";
    if (mc == 10 || mc == 11) {
      if (status?.toUpperCase() == "O") return "Mở cửa";
      if (status?.toUpperCase() == "P") return "ATO";
      if (status?.toUpperCase() == "I") return "Nghỉ trưa";
      if (status?.toUpperCase() == "A") return "ATC";
      if (status?.toUpperCase() == "C" || status?.toUpperCase() == "K") {
        return "Đóng cửa";
      }
      return "Đóng cửa";
    }
    if (mc == 2) {
      if (status?.toUpperCase() == "O") return "Mở cửa";
      if (status?.toUpperCase() == "I") return "Nghỉ trưa";
      if (status?.toUpperCase() == "A") return "ATC";
      if (status?.toUpperCase() == "C" || status?.toUpperCase() == "K") {
        return "Đóng cửa";
      }
      return "Đóng cửa";
    }
    if (mc == 3) {
      if (status?.toUpperCase() == "O") return "Mở cửa";
      if (status?.toUpperCase() == "I") return "Nghỉ trưa";
      return "Đóng cửa";
    }

    return "";
  }

  IndexDetailResponse(
      {required this.mc,
      this.cIndex,
      this.oIndex,
      this.vol,
      this.value,
      this.time,
      this.status,
      this.accVol,
      this.ot});

  IndexDetailResponse.fromJson(Map<String, dynamic> json) {
    mc = int.parse(json['mc'].toString());
    cIndex = json['cIndex'];
    oIndex = json['oIndex'];
    vol = json['vol'];
    value = json['value'];
    time = json['time'];
    status = json['status'];
    accVol = json['accVol'];
    ot = json['ot'].split('|');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mc'] = mc;
    data['cIndex'] = cIndex;
    data['oIndex'] = oIndex;
    data['vol'] = vol;
    data['value'] = value;
    data['time'] = time;
    data['status'] = status;
    data['accVol'] = accVol;
    data['ot'] = ot;
    return data;
  }
}
