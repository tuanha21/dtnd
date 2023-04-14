import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/share_earned_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:get/get.dart';

class AssetStockDetailController {
  AssetStockDetailController._internal();
  static final AssetStockDetailController _instance =
      AssetStockDetailController._internal();

  factory AssetStockDetailController({String? stockCode}) {
    if (stockCode != null) {
      _instance.stockCode.value = stockCode;
    }
    return _instance;
  }
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();

  final Rx<String?> stockCode = Rxn();
  final Rx<ShareEarnedModel?> shareEarnedModel = Rxn();

  Future<ShareEarnedModel?> getAllShareEarned(
      String fromDay, String toDay) async {
    if (!userService.isLogin) {
      return null;
    }
    final requestModel = RequestModel(
      userService,
      group: "B",
      data: RequestDataModel.cursorType(
          cmd: "GetAllShareEarned",
          p1: userService.token.value!.defaultAcc,
          p2: stockCode.value,
          p3: fromDay,
          p4: toDay,
          p5: "1",
          p6: "10"),
    );
    logger.v(requestModel.toJson());
    final listDetail = await networkService
        .requestTraditionalApiResList<ShareEarnedDetailModel>(requestModel);
    // logger.v(listDetail);
    if (listDetail?.isNotEmpty ?? false) {
      shareEarnedModel.value = ShareEarnedModel.fromListDetail(listDetail);
    }
    return shareEarnedModel.value;
  }
}
