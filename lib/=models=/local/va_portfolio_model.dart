import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'va_portfolio_model.g.dart';

@HiveType(typeId: 7)
class VAPortfolio extends HiveObject {
  @HiveField(0)
  late final VAPortfolioSetting generalSetting;

  @HiveField(1)
  late final List<VAPortfolioItem> listStocks;

  List<String> get listStockCodes => listStocks.map((e) => e.code).toList();

  VAPortfolio(this.generalSetting, {List<VAPortfolioItem>? listStocks}) {
    if (listStocks?.isNotEmpty ?? false) {
      this.listStocks = listStocks!;
    } else {
      this.listStocks = [];
    }
  }

  VAPortfolio.fromJson(Map<String, dynamic> json) {
    listStocks = <VAPortfolioItem>[];
    for (Map<String, dynamic> stock in json['stocks']) {
      listStocks.add(VAPortfolioItem.fromJson(stock));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generalSetting'] = generalSetting.toJson();
    data['datas'] = [for (var element in listStocks) element.toJson()];

    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VAPortfolio &&
            runtimeType == other.runtimeType &&
            listEquals(listStocks, other.listStocks);
  }

  @override
  int get hashCode => generalSetting.hashCode + listStocks.hashCode;
}

@HiveType(typeId: 6)
class VAPortfolioItem extends HiveObject {
  @HiveField(0)
  late final String code;

  @HiveField(1)
  late final VAPortfolioSetting setting;

  VAPortfolioItem(this.code, this.setting);

  VAPortfolioItem.fromJson(Map<String, dynamic> json) {
    code = json['sc'];
    setting = VAPortfolioSetting.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = setting.toJson();
    data['sc'] = code;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VAPortfolioItem &&
            runtimeType == other.runtimeType &&
            code == other.code &&
            setting == other.setting;
  }

  @override
  int get hashCode => code.hashCode + setting.hashCode;
}

@HiveType(typeId: 5)
class VAPortfolioSetting extends HiveObject {
  @HiveField(0)
  late num rrMax;

  @HiveField(1)
  late num buy;

  @HiveField(2)
  late num sell;

  @HiveField(3)
  late num volumeFix;

  @HiveField(4)
  late num volumePercent;

  VAPortfolioSetting(
      this.rrMax, this.buy, this.sell, this.volumeFix, this.volumePercent);

  VAPortfolioSetting? clone() {
    try {
      return VAPortfolioSetting(rrMax, buy, sell, volumeFix, volumePercent);
    } catch (e) {
      logger.e(e.toString());
    }
    return null;
  }

  VAPortfolioSetting.defaultSetting() {
    rrMax = 15;
    buy = 80;
    sell = 80;
    volumeFix = 1500;
    volumePercent = 20;
  }

  VAPortfolioSetting.fromJson(Map<String, dynamic> json) {
    rrMax = json['rrMax'];
    buy = json['buy'];
    sell = json['sell'];
    volumeFix = json['volumeFix'];
    volumePercent = json['volumePercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rrMax'] = rrMax;
    data['buy'] = buy;
    data['sell'] = sell;
    data['volumeFix'] = volumeFix;
    data['volumePercent'] = volumePercent;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VAPortfolioSetting &&
            runtimeType == other.runtimeType &&
            rrMax == other.rrMax &&
            buy == other.buy &&
            sell == other.sell &&
            volumeFix == other.volumeFix &&
            volumePercent == other.volumePercent;
  }

  @override
  int get hashCode =>
      rrMax.hashCode +
      buy.hashCode +
      sell.hashCode +
      volumeFix.hashCode +
      volumePercent.hashCode;

  @override
  String toString() {
    return 'Stocks{rrMax: $rrMax, buy: $buy, sell: $sell, volumeFix: $volumeFix, volumePercent: $volumePercent}';
  }
}
