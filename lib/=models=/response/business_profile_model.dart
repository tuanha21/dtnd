class BusinnessProfileModel {
  late final String profile;
  late final String profileEn;

  BusinnessProfileModel({required this.profile, required this.profileEn});

  BusinnessProfileModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] ?? "";
    profileEn = json['profileEn'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile;
    data['profileEn'] = profileEn;
    return data;
  }
}

class BusinnessLeaderModel {
  String? securityCode;
  String? fullName;
  String? fullNameEn;
  String? position;
  String? positionEn;
  num? personalHeld;
  num? personalHeldPct;

  BusinnessLeaderModel(
      {this.securityCode,
      this.fullName,
      this.fullNameEn,
      this.position,
      this.positionEn,
      this.personalHeld,
      this.personalHeldPct});

  BusinnessLeaderModel.fromJson(Map<String, dynamic> json) {
    securityCode = json['securityCode'];
    fullName = json['fullName'];
    fullNameEn = json['fullNameEn'];
    position = json['position'];
    positionEn = json['positionEn'];
    personalHeld =
        num.parse(num.parse(json['personalHeld'] ?? "0").toString());
    personalHeldPct =
        num.parse(num.parse(json['personalHeldPct'] ?? "0").toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['securityCode'] = securityCode;
    data['fullName'] = fullName;
    data['fullNameEn'] = fullNameEn;
    data['position'] = position;
    data['positionEn'] = positionEn;
    data['personalHeld'] = personalHeld;
    data['personalHeldPct'] = personalHeldPct;
    return data;
  }
}
