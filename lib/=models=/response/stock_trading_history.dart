class StockTradingHistory {
  final List<num> t = [];
  final List<DateTime> time = [];
  final List<num> c = [];
  final List<num> o = [];
  final List<num> h = [];
  final List<num> l = [];
  final List<num> v = [];
  late final String s;
  late final DateTime lastUpdatedTime;

  StockTradingHistory.nullChartData({num? defaultValue}) {
    lastUpdatedTime = DateTime.now();
    t.add(lastUpdatedTime.millisecondsSinceEpoch / 1000);
    c.add(1);
    o.add(defaultValue ?? 1);
    h.add(1);
    l.add(1);
    v.add(0);
  }

  StockTradingHistory.oneChartData({num? defaultValue}) {
    lastUpdatedTime = DateTime.now();
    t.addAll([
      lastUpdatedTime.millisecondsSinceEpoch / 1000,
      lastUpdatedTime.millisecondsSinceEpoch / 1000
    ]);
    c.add(1);
    o.addAll([defaultValue ?? 1, defaultValue ?? 1]);
    h.add(1);
    l.add(1);
    v.add(0);
  }

  StockTradingHistory.fromJson(Map<String, dynamic> json) {
    lastUpdatedTime = DateTime.now();
    t.addAll(json['t'].cast<num>());
    if (t.isNotEmpty) {
      final List<DateTime> list = [];
      for (num militime in t) {
        final int epoc = militime.toInt() * 1000;
        final datetime = DateTime.fromMillisecondsSinceEpoch(epoc);
        time.add(datetime);
      }
    }

    c.addAll(json['c'].cast<num>());
    o.addAll(json['o'].cast<num>());
    h.addAll(json['h'].cast<num>());
    l.addAll(json['l'].cast<num>());
    v.addAll(json['v'].cast<num>());
    s = json['s'] ?? "";
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
