class ShareHolders {
  String? securityCode;
  String? name;
  String? nameEn;
  num? currentHeld;
  num? heldPct;

  ShareHolders(
      {this.securityCode,
      this.name,
      this.nameEn,
      this.currentHeld,
      this.heldPct});

  ShareHolders.fromJson(Map<String, dynamic> json) {
    securityCode = json['securityCode'];
    name = json['name'];
    nameEn = json['nameEn'];
    currentHeld = json['currentHeld'];
    heldPct = json['heldPct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['securityCode'] = securityCode;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['currentHeld'] = currentHeld;
    data['heldPct'] = heldPct;
    return data;
  }
}
