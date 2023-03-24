import 'dart:convert';

import 'package:dtnd/data/i_user_service.dart';

enum RequestType { string, cursor, none }

extension RequestTypeX on RequestType {}

class RequestModel {
  String? group;
  String? user;
  String? session;
  String? checksum;
  RequestDataModel? data;

  RequestModel(IUserService userService,
      {this.group, this.data, this.checksum}) {
    user = userService.token.value!.user;
    session = userService.token.value!.sid;
  }

  RequestModel.login({this.group, this.user, this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['user'] = user;
    data['session'] = session ?? "";
    // data['channel'] = "M";
    if (checksum != null) {
      data['checksum'] = checksum;
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() => json.encode(toJson());
}

class RequestDataModel {
  RequestType? type;
  String? cmd;
  String? p1;
  String? p2;
  String? p3;
  String? p4;
  String? p5;
  String? p6;
  String? p7;
  String? p8;
  String? p9;
  String? p10;
  String? p11;
  String? account;
  String? side;
  String? symbol;
  dynamic volume;
  String? price;
  String? advance;
  String? refId;
  String? orderType;
  String? pin;
  String? orderNo;
  dynamic nvol;
  String? nprice;

  RequestDataModel({
    this.type,
    this.cmd,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
    this.p10,
    this.p11,
    this.account,
    this.side,
    this.symbol,
    this.volume,
    this.price,
    this.advance,
    this.refId,
    this.orderType,
    this.pin,
    this.orderNo,
    this.nvol,
    this.nprice,
  });
  RequestDataModel.stringType({
    this.cmd,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
    this.p10,
    this.p11,
    this.account,
    this.side,
    this.symbol,
    this.volume,
    this.price,
    this.advance,
    this.refId,
    this.orderType,
    this.pin,
    this.orderNo,
    this.nvol,
    this.nprice,
  }) : type = RequestType.string;
  RequestDataModel.cursorType({
    this.cmd,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
    this.p10,
    this.p11,
    this.account,
    this.side,
    this.symbol,
    this.volume,
    this.price,
    this.advance,
    this.refId,
    this.orderType,
    this.pin,
    this.orderNo,
    this.nvol,
    this.nprice,
  }) : type = RequestType.cursor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type?.name ?? "";
    data['cmd'] = cmd;
    if (p1 != null) {
      data['p1'] = p1;
    }
    if (p2 != null) {
      data['p2'] = p2;
    }
    if (p3 != null) {
      data['p3'] = p3;
    }
    if (p4 != null) {
      data['p4'] = p4;
    }
    if (p5 != null) {
      data['p5'] = p5;
    }
    if (p6 != null) {
      data['p6'] = p6;
    }
    if (p7 != null) {
      data['p7'] = p7;
    }
    if (p8 != null) {
      data['p8'] = p8;
    }
    if (p9 != null) {
      data['p9'] = p9;
    }
    if (p10 != null) {
      data['p10'] = p10;
    }
    if (p11 != null) {
      data['p11'] = p11;
    }
    if (account != null) {
      data['account'] = account;
    }
    if (side != null) {
      data['side'] = side;
    }
    if (symbol != null) {
      data['symbol'] = symbol;
    }
    if (volume != null) {
      data['volume'] = volume;
    }
    if (price != null) {
      data['price'] = price;
    }
    if (advance != null) {
      data['advance'] = advance;
    }
    if (refId != null) {
      data['refId'] = refId;
    }
    if (orderType != null) {
      data['orderType'] = orderType;
    }
    if (pin != null) {
      data['pin'] = pin;
    }
    if (orderNo != null) {
      data['orderNo'] = orderNo;
    }
    if (nvol != null) {
      data['nvol'] = nvol;
    }
    if (nprice != null) {
      data['nprice'] = nprice;
    }
    return data;
  }
}

class RequestTypeHelper {
  static RequestType fromString(String string) {
    switch (string.toLowerCase()) {
      case "cursor":
        return RequestType.cursor;
      default:
        return RequestType.string;
    }
  }
}
