class SCashBalance {
  String? accCode;
  String? accType;
  String? sym;
  String? ee;
  String? marginratio;
  String? imCk;
  String? pp;
  String? volumeAvaiable;
  String? balance;
  String? color;
  String? accName;

  SCashBalance({
    this.accCode,
    this.accType,
    this.sym,
    this.ee,
    this.marginratio,
    this.imCk,
    this.pp,
    this.volumeAvaiable,
    this.balance,
    this.color,
    this.accName,
  });

  SCashBalance.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accType = json['accType'];
    sym = json['sym'];
    ee = json['ee'];
    marginratio = json['marginratio'];
    imCk = json['im_ck'];
    pp = json['pp'];
    volumeAvaiable = json['volumeAvaiable'];
    balance = json['balance'];
    color = json['color'];
    accName = json['accName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['accType'] = accType;
    data['sym'] = sym;
    data['ee'] = ee;
    data['marginratio'] = marginratio;
    data['im_ck'] = imCk;
    data['pp'] = pp;
    data['volumeAvaiable'] = volumeAvaiable;
    data['balance'] = balance;
    data['color'] = color;
    data['accName'] = accName;
    return data;
  }
}
