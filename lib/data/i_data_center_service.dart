import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_model.dart';

abstract class IDataCenterService {
  List<StockModel> get listInterestedStocks;

  Set<IndexModel> get listIndexs;

  Future<void> init();

  Future<void> fetchData();

  Future<void> getListAllStock();

  Future<List<StockData>> getListStockData(List<String> listStock);

  Future<void> getListInterestedStocks();

  Future<void> getListIndex();
}
