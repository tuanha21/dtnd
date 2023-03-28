import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../=models=/request/request_model.dart';
import '../../../../../=models=/response/get_bedt_model.dart';
import '../../../../../=models=/response/stock_model.dart';
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
  final RxDouble sumCloanOut = 0.0.obs;
  final RxDouble sumCloan = 0.0.obs;
  final Rx<List<GetBedtModel?>?> listData = Rxn();

  final Rx<String?> stockCode = Rxn();

  final INetworkService networkService = NetworkService();

  Future<List<GetBedtModel?>?> getAllShareEarned(
      {DateTime? fromDay, DateTime? toDay}) async {
    if (!userService.isLogin) {
      return [];
    }
    final requestModel = RequestModel(
      group: "B",
      userService,
      data: RequestDataModel.cursorType(
          cmd: "GetDebtForWeb",
          p1: "${userService.token.value!.user}6",
          p3: TimeUtilities.commonTimeFormat.format(fromDay ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
          p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
          p5: "1",
          p6: "20"),
    );
    logger.v(requestModel.toJson());
    listData.value =
        await networkService.getDataMarginDebt<GetBedtModel>(requestModel);
    if (listData.value?.isNotEmpty == true &&
        listData.value != [] &&
        listData.value != null) {
      for (var item in listData.value ?? []) {
        sumCloanIn.value += item?.cLOANIN?.toDouble() ?? 0;
        sumCloanOut.value += item?.cLOANOUT?.toDouble() ?? 0;
        sumCloan.value += item?.cLOAN?.toDouble() ?? 0;
      }
    }
    return listData.value;
  }
}
