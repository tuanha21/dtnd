class SocketStockChangeModel {
  num? id;
  late final String sym;
  num? lastPrice;
  num? lastVol;
  String? cl;
  String? change;
  String? changePc;
  num? totalVol;
  String? time;
  num? hp;
  String? ch;
  num? lp;
  String? lc;
  num? ap;
  String? ca;

  SocketStockChangeModel({
    this.id,
    required this.sym,
    this.lastPrice,
    this.lastVol,
    this.cl,
    this.change,
    this.changePc,
    this.totalVol,
    this.time,
    this.hp,
    this.ch,
    this.lp,
    this.lc,
    this.ap,
    this.ca,
  });

  SocketStockChangeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    lastPrice = json['lastPrice'];
    lastVol = json['lastVol'];
    cl = json['cl'];
    change = json['change'];
    changePc = json['changePc'];
    totalVol = json['totalVol'];
    time = json['time'];
    hp = json['hp'];
    ch = json['ch'];
    lp = json['lp'];
    lc = json['lc'];
    ap = json['ap'];
    ca = json['ca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sym'] = sym;
    data['lastPrice'] = lastPrice;
    data['lastVol'] = lastVol;
    data['cl'] = cl;
    data['change'] = change;
    data['changePc'] = changePc;
    data['totalVol'] = totalVol;
    data['time'] = time;
    data['hp'] = hp;
    data['ch'] = ch;
    data['lp'] = lp;
    data['lc'] = lc;
    data['ap'] = ap;
    data['ca'] = ca;
    return data;
  }
}
