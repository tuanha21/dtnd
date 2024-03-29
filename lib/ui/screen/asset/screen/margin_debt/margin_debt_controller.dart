import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../=models=/request/request_model.dart';
import '../../../../../=models=/response/account/debt_model.dart';
import '../../../../../=models=/response/market/stock_model.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../../../utilities/logger.dart';
import '../../../../../utilities/time_utils.dart';

class MarginDebtControllers {
  static final MarginDebtControllers _instance =
      MarginDebtControllers._intern();

  static MarginDebtControllers get instance => _instance;

  MarginDebtControllers._intern();

  factory MarginDebtControllers() => _instance;

  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  final Rx<List<StockModel>> listStockModels = Rx(<StockModel>[]);
  final Rx<bool> portfolioInitialized = false.obs;
  final RxDouble sumCloanIn = 0.0.obs;
  final RxDouble sumCFEE = 0.0.obs;
  final RxDouble sumCloan = 0.0.obs;
  final Rx<List<DebtModel?>> listData = Rx([]);

  final Rx<String?> stockCode = Rxn();

  final INetworkService networkService = NetworkService();

  Future<List<DebtModel?>?> getDebt(
      {DateTime? fromDay, DateTime? toDay}) async {
    if (!userService.isLogin) {
      return [];
    }
    final requestModel = RequestModel(
      group: "B",
      userService,
      data: RequestDataModel.cursorType(
          cmd: "GetDebtForWeb",
          p1: userService.token.value!.defaultAcc,
          p3: TimeUtilities.commonTimeFormat.format(fromDay ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
          p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
          p5: "1",
          p6: "20"),
    );
    logger.v(requestModel.toJson());
    listData.value = await networkService
            .requestTraditionalApiResList<DebtModel>(requestModel) ??
        [];
    if (listData.value.isNotEmpty) {
      for (DebtModel? item in listData.value) {
        sumCloanIn.value += item?.cLOANIN?.toDouble() ?? 0;
        sumCFEE.value += item?.fee?.toDouble() ?? 0;
        sumCloan.value += item?.loan?.toDouble() ?? 0;
      }
    }
    return listData.value;
  }
}
