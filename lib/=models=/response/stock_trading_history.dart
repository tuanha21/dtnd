class StockTradingHistory {
  List<num>? t;
  List<num>? c;
  List<num>? o;
  List<num>? h;
  List<num>? l;
  List<num>? v;
  String? s;

  StockTradingHistory({this.t, this.c, this.o, this.h, this.l, this.v, this.s});

  StockTradingHistory.kChartData() {
    final now = DateTime.now();
    t = [now.millisecondsSinceEpoch / 1000];
    c = [1];
    o = [1];
    h = [1];
    l = [1];
    v = [0];
  }

  StockTradingHistory.fromJson(Map<String, dynamic> json) {
    t = json['t'].cast<num>();
    c = json['c'].cast<num>();
    o = json['o'].cast<num>();
    h = json['h'].cast<num>();
    l = json['l'].cast<num>();
    v = json['v'].cast<num>();
    s = json['s'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t'] = t;
    data['c'] = c;
    data['o'] = o;
    data['h'] = h;
    data['l'] = l;
    data['v'] = v;
    data['s'] = s;
    return data;
  }
}
