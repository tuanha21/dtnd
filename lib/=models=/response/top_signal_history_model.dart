import 'package:dtnd/=models=/stock_status.dart';
import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat("HH:mm:ss dd/MM/yyyy");

class TopSignalHistoryModel extends StockStatus {
  late final String shareCode;
  String? buyDateString;
  String? sellDateString;
  String? type;
  num? buyPrice;
  num? sellPrice;
  num? pc;
  num? t;

  DateTime? get buyTime {
    if (buyDateString == null) {
      return null;
    }
    try {
      return _dateFormat.parseLoose(buyDateString!);
    } catch (e) {
      return null;
    }
  }

  DateTime? get sellTime {
    if (sellDateString == null) {
      return null;
    }
    try {
      return _dateFormat.parseLoose(sellDateString!);
    } catch (e) {
      return null;
    }
  }

  TopSignalHistoryModel.fromJson(Map<String, dynamic> json) {
    shareCode = json['C_SHARE_CODE'];
    buyDateString = json['C_BUY_DATE'];
    sellDateString = json['C_SELL_DATE'];
    type = json['C_TYPE'];
    buyPrice = json['C_BUY_PRICE'];
    sellPrice = json['C_SELL_PRICE'];
    pc = json['C_PC'];
    t = json['T'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_SHARE_CODE'] = shareCode;
    data['C_BUY_DATE'] = buyDateString;
    data['C_SELL_DATE'] = sellDateString;
    data['C_TYPE'] = type;
    data['C_BUY_PRICE'] = buyPrice;
    data['C_SELL_PRICE'] = sellPrice;
    data['C_PC'] = pc;
    data['T'] = t;
    return data;
  }

  @override
  SStatus get sstatus {
    final percent = pc ?? 0;
    if (percent > 0) {
      return SStatus.up;
    } else if (percent < 0) {
      return SStatus.down;
    } else {
      return SStatus.ref;
    }
  }
}
