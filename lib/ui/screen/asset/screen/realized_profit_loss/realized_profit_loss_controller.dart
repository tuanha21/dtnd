import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../=models=/request/request_model.dart';
import '../../../../../=models=/response/share_earned_model.dart';
import '../../../../../=models=/response/stock_model.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/i_local_storage_service.dart';
import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../data/implementations/local_storage_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../../../utilities/logger.dart';
import '../../../../../utilities/time_utils.dart';

class RealizedProfitLossController {
  static final RealizedProfitLossController _instance =
      RealizedProfitLossController._intern();

  static RealizedProfitLossController get instance => _instance;

  RealizedProfitLossController._intern();

  factory RealizedProfitLossController() => _instance;

  final ILocalStorageService localStorageService = LocalStorageService();
  bool searching = false;

  void init() {}

  // State
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();

  final Rx<List<StockModel>> listStockModels = Rx(<StockModel>[]);
  final Rx<bool> portfolioInitialized = false.obs;

  final Rx<String?> stockCode = Rxn();
  final Rx<ShareEarnedModel?> shareEarnedModel = Rxn();
  final Rx<ShareEarnedModel?> listSearch = Rxn();
  final INetworkService networkService = NetworkService();

  Future<ShareEarnedModel?> getAllShareEarned(
      DateTime? fromDay, DateTime? toDay, String? maCP) async {
    if (!userService.isLogin) {
      return null;
    }
    final requestModel = RequestModel(
      group: "B",
      userService,
      data: RequestDataModel.cursorType(
          cmd: "GetAllShareEarned",
          p1: "${userService.token.value!.user}6",
          p2: maCP ?? '',
          p3: TimeUtilities.commonTimeFormat.format(fromDay ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
          p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
          p5: "1",
          p6: "20"),
    );
    logger.v(requestModel.toJson());
    final listDetail = await networkService
        .getDataProfitLoss<ShareEarnedDetailModel>(requestModel);
    logger.v(listDetail?.length.toString());
    if (listDetail?.isNotEmpty ?? false) {
      shareEarnedModel.value = ShareEarnedModel.fromListDetail(listDetail);
    }
    shareEarnedModel.refresh();
    return shareEarnedModel.value;
  }

  Future<ShareEarnedModel?> Search(
      DateTime? fromDay, DateTime? toDay, String? maCP) async {
    if (!userService.isLogin) {
      return null;
    }
    final requestModel = RequestModel(
      group: "B",
      userService,
      data: RequestDataModel.cursorType(
          cmd: "GetAllShareEarned",
          p1: "${userService.token.value!.user}6",
          p2: maCP ?? '',
          p3: TimeUtilities.commonTimeFormat.format(fromDay ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
          p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
          p5: "1",
          p6: "20"),
    );
    logger.v(requestModel.toJson());
    final listDetail = await networkService
        .getDataProfitLoss<ShareEarnedDetailModel>(requestModel);
    logger.v(listDetail?.length.toString());
    if (listDetail?.isNotEmpty ?? false) {
      listSearch.value = ShareEarnedModel.fromListDetail(listDetail);
    }
    listSearch.refresh();
    return listSearch.value;
  }
}
