import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:get/get.dart';

class IndexModel {
  late final Index index;
  late final IndexDetail _indexDetail;
  final Rx<StockTradingHistory?> stockTradingHistory = Rxn();

  IndexDetail get indexDetail => _indexDetail;

  IndexModel(
      {required this.index,
      required IndexDetailResponse indexDetailResponse,
      StockTradingHistory? stockTradingHistory}) {
    _indexDetail = IndexDetail.fromResponse(indexDetailResponse);
    this.stockTradingHistory.value = stockTradingHistory;
  }

  void updateIndexDetail(IndexDetailResponse data) {
    _indexDetail
      ..cIndex.value = data.cIndex
      ..ot.value = data.ot
      ..status.value = data.status
      ..value.value = data.value
      ..vol.value = data.vol
      ..time.value = data.time;
  }

  void onSocketData(dynamic data) {
    _indexDetail
      ..cIndex.value = data["data"]["cIndex"]
      ..vol.value = data['data']['vol']
      ..ot.value = data["data"]["ot"].split('|')
      ..value.value = data['data']['value'];
  }

  @override
  bool operator ==(Object other) => other is IndexModel && index == other.index;

  @override
  int get hashCode => index.hashCode;
}
