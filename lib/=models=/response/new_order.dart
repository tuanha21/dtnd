class NewOrderResponse {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  NewOrderResponseData? data;

  NewOrderResponse({this.cmd, this.oID, this.rc, this.rs, this.data});

  NewOrderResponse.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = NewOrderResponseData.fromJson(json['data'].first);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NewOrderResponseData {
  String? symbol;
  String? shareStatus;
  String? status;
  String? msgType;
  String? showPrice;
  String? orderTime;
  String? type;
  String? accountCode;
  int? orderNo;
  String? market;
  int? matchVolume;
  String? side;
  String? volume;
  String? pkOrderNo;
  String? channel;
  String? refID;
  String? group;
  String? autoType;
  String? product;

  NewOrderResponseData(
      {this.symbol,
      this.shareStatus,
      this.status,
      this.msgType,
      this.showPrice,
      this.orderTime,
      this.type,
      this.accountCode,
      this.orderNo,
      this.market,
      this.matchVolume,
      this.side,
      this.volume,
      this.pkOrderNo,
      this.channel,
      this.refID,
      this.group,
      this.autoType,
      this.product});

  NewOrderResponseData.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    shareStatus = json['shareStatus'];
    status = json['status'];
    msgType = json['msg_type'];
    showPrice = json['showPrice'];
    orderTime = json['orderTime'];
    type = json['type'];
    accountCode = json['accountCode'];
    orderNo = json['orderNo'];
    market = json['market'];
    matchVolume = json['matchVolume'];
    side = json['side'];
    volume = json['volume'];
    pkOrderNo = json['pk_orderNo'];
    channel = json['channel'];
    refID = json['refID'];
    group = json['group'];
    autoType = json['autoType'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['shareStatus'] = shareStatus;
    data['status'] = status;
    data['msg_type'] = msgType;
    data['showPrice'] = showPrice;
    data['orderTime'] = orderTime;
    data['type'] = type;
    data['accountCode'] = accountCode;
    data['orderNo'] = orderNo;
    data['market'] = market;
    data['matchVolume'] = matchVolume;
    data['side'] = side;
    data['volume'] = volume;
    data['pk_orderNo'] = pkOrderNo;
    data['channel'] = channel;
    data['refID'] = refID;
    data['group'] = group;
    data['autoType'] = autoType;
    data['product'] = product;
    return data;
  }
}
