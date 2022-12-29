import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/new_order.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
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
  Future<NewOrderResponse?> createNewOrder(OrderData orderData) async {
    final String user = userService.token!.user;
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
        cmd: "Web.newOrder",
        account: user,
        side: orderData.side.code,
        symbol: orderData.stockModel.stock.stockCode,
        volume: orderData.volumn.toString(),
        price: orderData.price,
        advance: "",
        refId: "$user.M.${NumUtils.getRandom()}",
        orderType: "1",
        pin: orderData.pin);
    final RequestModel requestModel =
        RequestModel(userService, group: "Q", data: requestDataModel);
    logger.v(requestModel.toJson());
    final response = await networkService.createNewOrder(requestModel);
    return response;
  }

  @override
  Future<SCashBalance> getSCashBalance(
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
