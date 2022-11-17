import 'package:intl/intl.dart';

final DateFormat indexChartDataTimeFormat = DateFormat("HH:mm:ss");

class IndexChartData {
  DateTime? time;
  num? oIndex;
  late num cIndex;
  late num vol;
  num? value;

  IndexChartData(
      {this.time,
      this.oIndex,
      required this.cIndex,
      required this.vol,
      this.value});

  IndexChartData.fromJson(Map<String, dynamic> json) {
    time = indexChartDataTimeFormat.parse(json['time']);
    oIndex = json['oIndex'];
    cIndex = json['cIndex'];
    vol = json['vol'];
    value = json['value'];
    assert(vol > 0, "Vol = 0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = indexChartDataTimeFormat.format(time!);
    data['oIndex'] = oIndex;
    data['cIndex'] = cIndex;
    data['vol'] = vol;
    data['value'] = value;
    return data;
  }
}
