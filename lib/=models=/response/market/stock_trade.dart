import 'package:intl/intl.dart';

/// Reduce [StockData] for simple line chart
class StockTrade {
  num? lastPrice;
  num? lastVol;
  String? change;
  String? timeServer;

  DateTime? get dateTime {
    if (timeServer == null) return null;
    return DateFormat("hh:mm:ss").parse(timeServer!);
  }

  StockTrade({
    this.lastPrice,
    this.lastVol,
    this.change,
    this.timeServer,
  });

  StockTrade.fromJson(Map<String, dynamic> json) {
    lastPrice = json['lastPrice'];
    lastVol = json['lastVol'];
    change = json['change'];
    timeServer = json['timeServer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastPrice'] = lastPrice;
    data['lastVol'] = lastVol;
    data['change'] = change;
    data['timeServer'] = timeServer;
    return data;
  }
}
