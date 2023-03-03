import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:intl/intl.dart';

class BaseOrderModel extends CoreResponseModel implements IOrderModel {
  @override
  late final String id;

  @override
  late final String orderAccount;

  @override
  late final OrderStatus orderStatus;

  @override
  late final DateTime orderTime;

  @override
  late final String symbol;

  num? orderNo;
  late final Side side;
  String? volume;
  String? showPrice;
  String? orderPrice;
  num? matchVolume;
  String? status;
  String? channel;
  String? group;
  String? cancelTime;
  String? info;
  String? maxPrice;
  String? matchValue;
  String? quote;
  String? autoType;
  String? product;
  String? condition;
  String? result;
  String? activeTime;
  String? sendTime;
  num? reVol;

  @override
  num? get matchPrice {
    try {
      num matchValueParse = double.parse(matchValue ?? "0");
      num matchVolParse = matchVolume ?? 0;
      if (matchValueParse > 0) {
        return matchValueParse / (matchVolParse * 1000);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  BaseOrderModel.fromJson(Map<String, dynamic> json) {
    try {
      orderNo = num.parse(json['orderNo']);
      id = json['pk_orderNo'];
      orderTime = DateFormat("HH:mm:ss").parseStrict(json['orderTime']);
      orderAccount = json['accountCode'];
      side = SideHelper.fromString(json['side']);
      symbol = json['symbol'];
      volume = json['volume'];
      showPrice = json['showPrice'];
      orderPrice = json['orderPrice'];
      matchVolume = num.parse(json['matchVolume'] ?? "0");
      status = json['status'];
      channel = json['channel'];
      group = json['group'];
      cancelTime = json['cancelTime'];
      info = json['info'];
      maxPrice = json['maxPrice'];
      matchValue = json['matchValue'];
      quote = json['quote'];
      autoType = json['autoType'];
      product = json['product'];
      condition = json['condition'];
      result = json['result'];
      activeTime = json['active_time'];
      sendTime = json['send_time'];
      orderStatus = _getStatusOrder(json['status']);
      reVol = num.parse(volume ?? "0") - (matchVolume ?? 0);
    } catch (e) {
      logger.e(e);
    }
  }

  OrderStatus _getStatusOrder(String status) {
    var pStatus = status;
    var pMatchVolume = matchVolume ?? 0;
    var pVolume = volume ?? "0";

    if ((pStatus == "PMC" || pStatus == "PCM" || pStatus == "PWM") &&
        (pMatchVolume) < int.parse(pVolume)) {
      return OrderStatus.partialMatch; // "MATCH_PARTIAL";
    }
    if ((pStatus == "PMC" || pStatus == "PCM") &&
        (pMatchVolume) == int.parse(pVolume)) {
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }

    if ((pStatus == "PMX" || pStatus == "PMWX") && (pMatchVolume) > 0) {
      return OrderStatus.partialMatchCanceled; // "MATCH_PARTIAL_CANCELED";
    }
    if (pStatus == "PM" && (pMatchVolume) < int.parse(pVolume)) {
      return OrderStatus.partialMatch; // "MATCH_PARTIAL";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "M") {
      //return "MATCH_FULL"
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }
    if (pStatus == "PM") {
      // return "MATCH_FULL"
      return OrderStatus.fullMatch; // "MATCH_FULL";
    }
    if (pStatus == "PW" || pStatus == "PMW") {
      // return  "MATCH_PENDING"
      return OrderStatus.pendingCanceled; // "MATCH_PENDING";
    }
    if (pStatus == "PC") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
      // if (pQuote == "Y") {
      //   return "Chờ khớp"; // "MATCH_PENDING";
      // } else {
      //   return "Đã sửa"; // "EDIT_PENDING"
      // } // Ba Ly bao sua thanh cho khop, neu sua lai thi la con cho'
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "X") {
      return OrderStatus.canceled; // "CANCELED";
    }
    if (pStatus == "P") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "C") {
      return OrderStatus.pendingMatch; // "MATCH_PENDING";
    }
    return OrderStatus.unidentified;
  }

  // String getStatusOrder(String status) {
  //   var pStatus = status;
  //   var pMatchVolume = matchVolume ?? 0;
  //   var pVolume = volume ?? "0";

  //   if ((pStatus == "PMC" || pStatus == "PCM" || pStatus == "PWM") &&
  //       (pMatchVolume) < int.parse(pVolume)) {
  //     return "Khớp 1 phần"; // "MATCH_PARTIAL";
  //   }
  //   if ((pStatus == "PMC" || pStatus == "PCM") &&
  //       (pMatchVolume) == int.parse(pVolume)) {
  //     return "Đã khớp"; // "MATCH_FULL";
  //   }

  //   if ((pStatus == "PMX" || pStatus == "PMWX") && (pMatchVolume) > 0) {
  //     return "Khớp 1 phần đã hủy"; // "MATCH_PARTIAL_CANCELED";
  //   }
  //   if (pStatus == "PM" && (pMatchVolume) < int.parse(pVolume)) {
  //     return "Khớp 1 phần"; // "MATCH_PARTIAL";
  //   }
  //   if (pStatus.substring(pStatus.length - 1, pStatus.length) == "M") {
  //     //return "MATCH_FULL"
  //     return "Đã khớp"; // "MATCH_FULL";
  //   }
  //   if (pStatus == "PM") {
  //     // return "MATCH_FULL"
  //     return "Đã khớp"; // "MATCH_FULL";
  //   }
  //   if (pStatus == "PW" || pStatus == "PMW") {
  //     // return  "MATCH_PENDING"
  //     return "Chờ hủy"; // "MATCH_PENDING";
  //   }
  //   if (pStatus == "PC") {
  //     return "Chờ khớp"; // "MATCH_PENDING";
  //     // if (pQuote == "Y") {
  //     //   return "Chờ khớp"; // "MATCH_PENDING";
  //     // } else {
  //     //   return "Đã sửa"; // "EDIT_PENDING"
  //     // } // Ba Ly bao sua thanh cho khop, neu sua lai thi la con cho'
  //   }
  //   if (pStatus.substring(pStatus.length - 1, pStatus.length) == "X") {
  //     return "Đã hủy"; // "CANCELED";
  //   }
  //   if (pStatus == "P") {
  //     return "Chờ khớp"; // "MATCH_PENDING";
  //   }
  //   if (pStatus.substring(pStatus.length - 1, pStatus.length) == "C") {
  //     return "Chờ khớp"; // "MATCH_PENDING";
  //   }
  //   return pStatus;
  // }
}
