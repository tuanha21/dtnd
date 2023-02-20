import 'package:dtnd/=models=/response/stock_model.dart';

class InvestmentCatalog {
  final StockModel stockModel;
  final String capitalValue = "533.000.000đ";
  final String marketValue = "200.000.000đ";
  final num availableBalance = 10000;
  final num totalVolumn = 10000;
  final num normalVolumn = 10000;
  final num fsVolumn = 10000;
  final num availableVolumn = 10000;
  final num otherVolumn = 10000;
  final num t0 = 0;
  final num t1 = 15000;
  final num t2 = 0;

  InvestmentCatalog({
    required this.stockModel,
  });
}
