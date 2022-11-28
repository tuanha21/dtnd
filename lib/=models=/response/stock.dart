import 'package:dtnd/=models=/exchange.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'stock.g.dart';

@HiveType(typeId: 2)
class Stock {
  @HiveField(0)
  late final String stockCode;
  @HiveField(1)
  late final Exchange? postTo;
  @HiveField(2)
  late final String? nameVn;
  @HiveField(3)
  late final String? nameEn;
  @HiveField(4)
  late final String? nameShort;

  Stock({
    required this.stockCode,
    this.postTo,
    this.nameVn,
    this.nameEn,
    this.nameShort,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    stockCode = json['stock_code'];
    postTo = ExchangeHelper.fromString(json['post_to']);
    nameVn = json['name_vn'];
    nameEn = json['name_en'] == "null" ? json['name_vn'] : json['name_en'];
    nameShort = json['name_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stock_code'] = stockCode;
    data['post_to'] = postTo?.name;
    data['name_vn'] = nameVn;
    data['name_en'] = nameEn;
    data['name_short'] = nameShort;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is Stock && stockCode == other.stockCode) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => stockCode.hashCode;
}
