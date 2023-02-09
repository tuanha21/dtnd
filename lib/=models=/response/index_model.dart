import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:get/get.dart';

class IndexModel {
  late final Index index;
  late final IndexDetail _indexDetail;
  final Rx<StockTradingHistory?> stockIndayTradingHistory = Rxn();
  final Rx<StockTradingHistory?> stockDayTradingHistory = Rxn();

  IndexDetail get indexDetail => _indexDetail;

  IndexModel(
      {required this.index,
      required IndexDetailResponse indexDetailResponse,
      StockTradingHistory? stockIndayTradingHistory,
      StockTradingHistory? stockDayTradingHistory}) {
    _indexDetail = IndexDetail.fromResponse(indexDetailResponse);
    this.stockIndayTradingHistory.value = stockIndayTradingHistory;
    this.stockDayTradingHistory.value = stockDayTradingHistory;
    if (this.stockDayTradingHistory.value != null &&
        (this.stockDayTradingHistory.value?.o?.isNotEmpty ?? false) &&
        indexDetailResponse.oIndex != null) {
      this.stockDayTradingHistory.value!.o!.last = indexDetailResponse.oIndex!;
    }
  }

  void updateIndexDetail(IndexDetailResponse data) {
    _indexDetail
      ..cIndex.value = data.cIndex
      ..ot.value = data.ot
      ..changeIndexStatus(data.status)
      ..value.value = data.value
      ..vol.value = data.vol
      ..time.value = data.time;
  }

  void onSocketData(dynamic data) {
    _indexDetail
      ..cIndex.value = data["data"]["cIndex"]
      ..vol.value = data['data']['vol']
      ..changeIndexStatus(data['data']['status'])
      ..ot.value = data["data"]["ot"].split('|')
      ..value.value = data['data']['value'];
    if (stockDayTradingHistory.value != null &&
        (stockDayTradingHistory.value!.c?.isNotEmpty ?? false)) {
      stockDayTradingHistory.value!.c!.last = data["data"]["cIndex"];
      stockDayTradingHistory.refresh();
    }
  }

  @override
  bool operator ==(Object other) => other is IndexModel && index == other.index;

  @override
  int get hashCode => index.hashCode;
}
