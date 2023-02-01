import 'package:intl/intl.dart';

class IndexBoard {
  String? time;
  double? indexValue;
  num? indexRefPrice;
  num? indexVolume;
  num? fGBuyValue;
  num? advances;
  num? declines;
  num? noChanges;
  num? totalBuyActivelyValues;

  DateTime? get dateTime {
    if (time == null) return null;
    return DateFormat("hh:mm:ss").parse(time!);
  }


  IndexBoard(
      {this.time,
      this.indexValue,
      this.indexRefPrice,
      this.indexVolume,
      this.fGBuyValue,
      this.advances,
      this.declines,
      this.noChanges,
      this.totalBuyActivelyValues});

  IndexBoard.fromJson(Map<String, dynamic> json) {
    time = json['Time'];
    indexValue = json['IndexValue'];
    indexRefPrice = json['IndexRefPrice'];
    indexVolume = json['IndexVolume'];
    fGBuyValue = json['FGBuyValue'];
    advances = json['Advances'];
    declines = json['Declines'];
    noChanges = json['NoChanges'];
    totalBuyActivelyValues = json['TotalBuyActivelyValues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Time'] = time;
    data['IndexValue'] = indexValue;
    data['IndexRefPrice'] = indexRefPrice;
    data['IndexVolume'] = indexVolume;
    data['FGBuyValue'] = fGBuyValue;
    data['Advances'] = advances;
    data['Declines'] = declines;
    data['NoChanges'] = noChanges;
    data['TotalBuyActivelyValues'] = totalBuyActivelyValues;
    return data;
  }
}
