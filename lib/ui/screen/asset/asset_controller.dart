import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

class AssetController {
  static final AssetController _instance = AssetController._intern();

  AssetController._intern();

  factory AssetController() => _instance;

  final IDataCenterService dataCenterService = DataCenterService();

  final Rx<List<IAccountModel>> listAccount = Rx<List<IAccountModel>>([]);

  final Rx<StockTradingHistory?> currentChartData = Rxn();

  Future<void> init() async {
    currentChartData.value = await dataCenterService.getStockTradingHistory(
      Index.VN30.chartCode,
      "1D",
      DateTime.now().subtract(TimeUtilities.month(1)),
      DateTime.now(),
    );
  }
}
