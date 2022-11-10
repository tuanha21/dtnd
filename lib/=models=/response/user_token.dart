// class UserToken {
//   String? oID;
//   int? rc;
//   String? rs;
//   UserToken? loginData;

//   UserToken({this.oID, this.rc, this.rs, this.loginData});

//   UserToken.fromJson(Map<String, dynamic> json) {
//     oID = json['oID'];
//     rc = json['rc'];
//     rs = json['rs'];
//     loginData = json['loginData'] != null
//         ? UserToken.fromJson(json['loginData'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['oID'] = oID;
//     data['rc'] = rc;
//     data['rs'] = rs;
//     if (loginData != null) {
//       data['loginData'] = loginData!.toJson();
//     }
//     return data;
//   }
// }

class UserToken {
  late final String user;
  late final String name;
  late final String sid;
  late final String address;
  late final String defaultAcc;
  late final num iFlag;
  late final num countLoginFail;
  late final String authenType;
  late final String? iP;
  late final String authenFlag;
  late final String customerCode;

  UserToken({
    required this.user,
    required this.name,
    required this.sid,
    required this.address,
    required this.defaultAcc,
    required this.iFlag,
    required this.countLoginFail,
    required this.authenType,
    required this.iP,
    required this.authenFlag,
    required this.customerCode,
  });

  UserToken.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    sid = json['sid'];
    address = json['address'];
    defaultAcc = json['defaultAcc'];
    iFlag = json['iFlag'];
    countLoginFail = json['CountLoginFail'];
    authenType = json['AuthenType'];
    iP = json['IP'];
    authenFlag = json['AuthenFlag'];
    customerCode = json['CustomerCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['name'] = name;
    data['sid'] = sid;
    data['address'] = address;
    data['defaultAcc'] = defaultAcc;
    data['iFlag'] = iFlag;
    data['CountLoginFail'] = countLoginFail;
    data['AuthenType'] = authenType;
    data['IP'] = iP;
    data['AuthenFlag'] = authenFlag;
    data['CustomerCode'] = customerCode;
    return data;
  }
}
