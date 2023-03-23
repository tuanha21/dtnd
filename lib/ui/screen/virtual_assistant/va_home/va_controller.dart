import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:get/get.dart';

class VAController {
  static final VAController _instance = VAController._intern();
  static VAController get instance => _instance;

  VAController._intern();

  factory VAController() => _instance;

  // State
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final Rx<VAPortfolio> vaPortfolio;
  final Rx<List<StockModel>> listStockModels = Rx(<StockModel>[]);
  final Rx<bool> portfolioInitialized = false.obs;

  Future<void> init() async {
    try {
      vaPortfolio = Rx(await getVAPortfolio());
    } catch (e) {
      vaPortfolio.value = await getVAPortfolio();
    }
    getStockModels();
    portfolioInitialized.value = true;
  }

  Future<VAPortfolio> getVAPortfolio() async {
    final portfolio = await userService.getVAPortfolio();
    return portfolio;
  }

  Future<void> getStockModels() async {
    if (vaPortfolio.value.listStockCodes.isEmpty) {
      return;
    }
    final stockModels = await dataCenterService
        .getStockModelsFromStockCodes(vaPortfolio.value.listStockCodes);
    if ((stockModels?.isEmpty ?? true) ||
        stockModels!.length != vaPortfolio.value.listStockCodes.length) {
      throw Exception();
    } else {
      listStockModels.value.clear();
      listStockModels.value.addAll(stockModels);
      listStockModels.refresh();
    }
  }

  Future<void> getStockModel(Stock stock) async {
    final stockModels =
        await dataCenterService.getStockModelsFromStockCodes([stock.stockCode]);
    if ((stockModels?.isEmpty ?? true)) {
      throw Exception();
    } else {
      listStockModels.value.add(stockModels!.first);
      listStockModels.refresh();
    }
  }

  Future<void> addStockToPortfolio(Stock stock) async {
    vaPortfolio.value.listStocks.add(VAPortfolioItem(
      stock.stockCode,
      vaPortfolio.value.generalSetting.clone()!,
    ));
    vaPortfolio.value.save();
    await getStockModel(stock);
    listStockModels.refresh();
  }
}
