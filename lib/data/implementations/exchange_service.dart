import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/stock_cash_balance_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';

class ExchangeService implements IExchangeService {
  ExchangeService._internal();

  static final ExchangeService _instance = ExchangeService._internal();

  static ExchangeService get instance => _instance;

  factory ExchangeService() => _instance;

  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();

  @override
  Future<BaseOrderModel?> createNewOrder(
      IUserService userService, OrderData orderData) async {
    final String user = userService.token.value!.user;
    final String refId = "$user.H.${NumUtils.getRandom()}";
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
        cmd: "Web.newOrder",
        account: "${user}6",
        side: orderData.side.code,
        symbol: orderData.stockModel.stock.stockCode,
        volume: orderData.volumn.toInt(),
        price: orderData.price,
        advance: "",
        refId: refId,
        orderType: "1",
        pin: orderData.pin);
    final String checksum = NumUtils.generateMd5(
        "${userService.token.value!.sid}${orderData.price}${orderData.side.code}${(orderData.volumn * 100).toString()}vpbs@456${user}1${orderData.stockModel.stock.stockCode}$refId");

    final RequestModel requestModel = RequestModel(
      userService,
      group: "O",
      data: requestDataModel,
      checksum: checksum,
    );
    // logger.v(requestModel.toJson());
    hasError(Map<String, dynamic> json) {
      logger.v(json);
      final int rc = json['rc'];
      return rc <= 0;
    }

    onError(Map<String, dynamic> json) {
      final int rc = json['rc'];
      throw rc;
    }

    final response = await networkService
        .requestTraditionalApiResList<BaseOrderModel>(requestModel,
            hasError: hasError, onError: onError);
    if (response?.isNotEmpty ?? false) {
      return response!.first;
    }
    return null;
  }

  @override
  Future<StockCashBalanceModel> getSCashBalance(
      {required String stockCode,
      required String price,
      required Side side}) async {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "Web.sCashBalance",
      p1: "${userService.token.value!.user}6",
      p2: stockCode,
      p3: price,
      p4: side.code,
    );

    final RequestModel requestModel =
        RequestModel(userService, group: "Q", data: requestDataModel);
    logger.v(requestModel.toJson());
    final response = await networkService
        .requestTraditionalApi<StockCashBalanceModel>(requestModel);
    logger.v(response);
    if (response == null) {
      throw Exception();
    }

    return response;
  }

  @override
  Future<void> registerRight(
      {required IAccountModel accountModel,
      required UnexecutedRightModel right,
      required String volumn,
      required String pin}) {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "UpdateRightRegister",
      p1: accountModel.accCode,
      p2: right.pKRIGHTSTOCKINFO,
      p3: volumn,
      p4: accountModel.accCode,
      p6: pin,
    );

    bool hasError(dynamic json) => true;

    onError(dynamic json) {
      if (json["rc"] <= 0) {
        throw json["rs"];
      } else {
        return;
      }
    }

    final RequestModel requestModel =
        RequestModel(userService, group: "B", data: requestDataModel);

    return networkService.requestTraditionalApi(requestModel,
        hasError: hasError, onError: onError);
  }
}
