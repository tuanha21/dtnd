import 'package:dtnd/utilities/logger.dart';

class VAPortfolio {
  late final String _id;
  late final VAPortfolioSetting generalSetting;
  final List<VAPortfolioItem> listStocks = [];

  List<String> get listStockCodes =>
      listStocks.map((e) => e.stockCode).toList();

  VAPortfolio.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    for (Map<String, dynamic> stock in json['stocks']) {
      listStocks.add(VAPortfolioItem.fromJson(stock));
    }
  }
}

class VAPortfolioItem {
  late final String stockCode;
  late final VAPortfolioSetting setting;
  VAPortfolioItem.fromJson(Map<String, dynamic> json) {
    stockCode = json['sc'];
    setting = VAPortfolioSetting.fromJson(json);
  }
}

class VAPortfolioSetting {
  late num rrMax;
  late num buy;
  late num sell;
  late num volumeFix;
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
  String toString() {
    return 'Stocks{rrMax: $rrMax, buy: $buy, sell: $sell, volumeFix: $volumeFix, volumePercent: $volumePercent}';
  }
}
