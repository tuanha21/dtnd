import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/utilities/logger.dart';

class ListAccountModel implements CoreResponseModel {
  late final String accCode;
  String? accName;
  String? accType;
  String? type;
  String? authen;
  String? serial;

  ListAccountModel(
      {required this.accCode,
      this.accName,
      this.accType,
      this.type,
      this.authen,
      this.serial});

  ListAccountModel.fromJson(Map<String, dynamic> json) {
    logger.v(json);
    accCode = json['accCode'];
    accName = json['accName'];
    accType = json['accType'];
    type = json['type'];
    authen = json['authen'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['accName'] = accName;
    data['accType'] = accType;
    data['type'] = type;
    data['authen'] = authen;
    data['serial'] = serial;
    return data;
  }
}
