import 'dart:ui';

import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/logic/stock_status.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';

class PortfolioStatus {
  String? symbol;

  String? account;
  num? value;
  num? marketValue;
  num? gainLossValue;
  num? gl;
  num totalVol = 0;
  String? gainLossPer;
  String? relized;
  String? plg;
  List<PorfolioStock>? porfolioStocks;

  String get prefix {
    if (gainLossValue == null) {
      return "";
    }
    if (gainLossValue! > 0) {
      return "+";
    }
    if (gainLossValue! < 0) {
      return "-";
    }
    return "";
  }

  String get prefixIcon {
    if (gainLossValue == null) {
      return AppImages.prefix_ref_icon;
    }
    if (gainLossValue! > 0) {
      return AppImages.prefix_up_icon;
    }
    if (gainLossValue! < 0) {
      return AppImages.prefix_down_icon;
    }
    return AppImages.prefix_ref_icon;
  }

  Color get color {
    if (gainLossValue == null) {
      return AppColors.semantic_02;
    }
    if (gainLossValue! > 0) {
      return AppColors.semantic_01;
    }
    if (gainLossValue! < 0) {
      return AppColors.semantic_03;
    }
    return AppColors.semantic_02;
  }

  PortfolioStatus({
    this.symbol,
    this.account,
    this.value,
    this.marketValue,
    this.gainLossValue,
    this.gl,
    this.gainLossPer,
    this.relized,
    this.plg,
    this.porfolioStocks,
  });

  PortfolioStatus.fromPorfolioStock(List<PorfolioStock> list) {
    if (list.length < 2) {
      return;
    }
    final total = list.first;
    symbol = total.symbol;
    account = total.account;
    value = total.value;
    marketValue = total.marketValue;
    gainLossValue = total.gainLossValue;
    gl = total.gl;
    gainLossPer = total.gainLossPer;
    relized = total.relized;
    plg = total.plg;
    if (list.length > 1) {
      porfolioStocks = list.sublist(1, list.length);
    }
    if (porfolioStocks != null && porfolioStocks!.length > 1) {
      for (PorfolioStock porfolioStock in porfolioStocks!) {
        totalVol += (porfolioStock.actualVol ?? 0);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['account'] = account;
    data['value'] = value;
    data['market_value'] = marketValue;
    data['gain_loss_value'] = gainLossValue;
    data['gl'] = gl;
    data['gain_loss_per'] = gainLossPer;
    data['relized'] = relized;
    data['plg'] = plg;
    return data;
  }
}

class PorfolioStock extends StockStatus implements CoreResponseModel {
  late final String symbol;
  String? account;
  num? actualVol;
  num? avaiableVol;
  num? repoVol;
  num? rightVol;
  num? marginRate;
  num? buyT1;
  num? sellT1;
  num? buyT2;
  num? sellT2;
  num? buyT0;
  num? sellT0;
  num? sellUnmatchVol;
  num? avgPrice;
  num? value;
  num? marketPrice;
  num? marketValue;
  num? gainLossValue;
  num? gl;
  String? gainLossPer;
  String? relized;
  String? plg;

  num get capitalValue => (actualVol ?? 0) * (avgPrice ?? 0) * 1000;

  num get buyTVol => (buyT0 ?? 0) + (buyT1 ?? 0) + (buyT2 ?? 0);
  num get sellTVol => (sellT0 ?? 0) + (sellT1 ?? 0) + (sellT1 ?? 0);
  @override
  Color get color {
    final value = gainLossValue ?? 0;
    if (value > 0) {
      return AppColors.semantic_01;
    } else if (value < 0) {
      return AppColors.semantic_03;
    } else {
      return AppColors.semantic_02;
    }
  }

  @override
  SStatus get sstatus {
    try {
      final value = gainLossValue ?? 0;
      if (value > 0) {
        return SStatus.up;
      } else if (value < 0) {
        return SStatus.down;
      } else {
        return SStatus.ref;
      }
    } catch (e) {
      return SStatus.ref;
    }
  }

  PorfolioStock(
      {required this.symbol,
      this.actualVol,
      this.avaiableVol,
      this.repoVol,
      this.rightVol,
      this.marginRate,
      this.buyT1,
      this.sellT1,
      this.buyT2,
      this.sellT2,
      this.buyT0,
      this.sellT0,
      this.account,
      this.sellUnmatchVol,
      this.avgPrice,
      this.value,
      this.marketPrice,
      this.marketValue,
      this.gainLossValue,
      this.gl,
      this.gainLossPer,
      this.relized,
      this.plg});

  PorfolioStock.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    actualVol = parse(json['actual_vol']);
    avaiableVol = parse(json['avaiable_vol']);
    repoVol = parse(json['repo_vol']);
    rightVol = parse(json['right_vol']);
    marginRate = parse(json['margin_rate']);
    buyT1 = parse(json['buy_t1']);
    sellT1 = parse(json['sell_t1']);
    buyT2 = parse(json['buy_t2']);
    sellT2 = parse(json['sell_t2']);
    buyT0 = parse(json['buy_t0']);
    sellT0 = parse(json['sell_t0']);
    account = json['account'];
    sellUnmatchVol = parse(json['sell_unmatch_vol']);
    avgPrice = parse(json['avg_price']);
    value = parse(json['value']);
    marketPrice = parse(json['market_price']);
    marketValue = parse(json['market_value']);
    gainLossValue = parse(json['gain_loss_value']);
    gl = parse(json['gl']);
    gainLossPer = json['gain_loss_per'];
    relized = json['relized'];
    plg = json['plg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['actual_vol'] = actualVol;
    data['avaiable_vol'] = avaiableVol;
    data['repo_vol'] = repoVol;
    data['right_vol'] = rightVol;
    data['margin_rate'] = marginRate;
    data['buy_t1'] = buyT1;
    data['sell_t1'] = sellT1;
    data['buy_t2'] = buyT2;
    data['sell_t2'] = sellT2;
    data['buy_t0'] = buyT0;
    data['sell_t0'] = sellT0;
    data['account'] = account;
    data['sell_unmatch_vol'] = sellUnmatchVol;
    data['avg_price'] = avgPrice;
    data['value'] = value;
    data['market_price'] = marketPrice;
    data['market_value'] = marketValue;
    data['gain_loss_value'] = gainLossValue;
    data['gl'] = gl;
    data['gain_loss_per'] = gainLossPer;
    data['relized'] = relized;
    data['plg'] = plg;
    return data;
  }
}

num? parse(String string) {
  return num.tryParse(string);
}
