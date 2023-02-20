import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/new_order_message.dart';
import 'package:dtnd/utilities/num_utils.dart';

class ExchangeService implements IExchangeService {
  ExchangeService._internal();

  static final ExchangeService _instance = ExchangeService._internal();

  static ExchangeService get instance => _instance;

  factory ExchangeService() => _instance;

  final INetworkService networkService = NetworkService();

  @override
  Future<BaseOrderModel?> createNewOrder(
      IUserService userService, OrderData orderData) async {
    final String user = userService.token!.user;
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
        "${userService.token!.sid}${orderData.price}${orderData.side.code}${(orderData.volumn * 100).toString()}vpbs@456${user}1${orderData.stockModel.stock.stockCode}$refId");

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
  Future<SCashBalance> getSCashBalance(IUserService userService,
      {required String stockCode, required String price, required Side side}) {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "Web.sCashBalance",
      p1: userService.token!.user,
      p2: stockCode,
      p3: price,
      p4: side.code,
    );
    final RequestModel requestModel =
        RequestModel(userService, group: "Q", data: requestDataModel);
    return networkService.getSCashBalance(requestModel);
  }
}
