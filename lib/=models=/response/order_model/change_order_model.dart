import 'package:dtnd/=models=/core_response_model.dart';

class ChangeOrderModel implements CoreResponseModel {
  num? orderNo;
  String? msgType;
  String? status;
  String? showPrice;
  String? volume;
  num? pkOrderNo;

  ChangeOrderModel(
      {this.orderNo,
      this.msgType,
      this.status,
      this.showPrice,
      this.volume,
      this.pkOrderNo});

  ChangeOrderModel.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    msgType = json['msg_type'];
    status = json['status'];
    showPrice = json['showPrice'];
    volume = json['volume'];
    pkOrderNo = json['pk_orderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderNo'] = orderNo;
    data['msg_type'] = msgType;
    data['status'] = status;
    data['showPrice'] = showPrice;
    data['volume'] = volume;
    data['pk_orderNo'] = pkOrderNo;
    return data;
  }
}
