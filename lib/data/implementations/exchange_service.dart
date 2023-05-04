import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/cash_transaction_model.dart';
import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/order_model/change_order_model.dart';
import 'package:dtnd/=models=/response/share_transaction_model.dart';
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
import 'package:dtnd/utilities/time_utils.dart';

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
        account: userService.token.value!.defaultAcc,
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
  Future<ChangeOrderModel?> changeOrder(IUserService userService,
      BaseOrderModel baseOrderModel, num vol, String price, String pin) async {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "Web.changeOrder",
      orderNo: "${baseOrderModel.orderNo}",
      nvol: vol.toInt(),
      nprice: price,
      orderType: "1",
      pin: pin,
    );

    final RequestModel requestModel = RequestModel(
      userService,
      group: "O",
      data: requestDataModel,
      checksum: "",
    );
    logger.v(requestModel.toJson());
    hasError(Map<String, dynamic> json) {
      logger.v(json);
      final int rc = json['rc'];
      return rc <= 0;
    }

    onError(Map<String, dynamic> json) {
      final int rc = json['rc'];
      throw rc;
    }

    onParseError() {
      return null;
    }

    final response = await networkService
        .requestTraditionalApiResList<ChangeOrderModel>(requestModel,
            hasError: hasError, onError: onError, onParseError: onParseError);
    logger.v(response);
    // if (response?.isNotEmpty ?? false) {
    //   return response!.first;
    // }
    return null;
  }

  @override
  Future<ChangeOrderModel?> cancelOrder(IUserService userService,
      BaseOrderModel baseOrderModel, String pin) async {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "Web.cancelOrder",
      orderNo: "${baseOrderModel.orderNo}",
      orderType: "1",
      pin: pin,
    );

    final RequestModel requestModel = RequestModel(
      userService,
      group: "O",
      data: requestDataModel,
      checksum: "",
    );
    logger.v(requestModel.toJson());
    hasError(Map<String, dynamic> json) {
      logger.v(json);
      final int rc = json['rc'];
      return rc <= 0;
    }

    onError(Map<String, dynamic> json) {
      final String rc = json['rs'];
      throw rc;
    }

    final response = await networkService
        .requestTraditionalApiResList<ChangeOrderModel>(requestModel,
            hasError: hasError, onError: onError);
    logger.v(response);
    if (response?.isNotEmpty ?? false) {
      return response!.first;
    }
    return null;
  }

  @override
  Future<StockCashBalanceModel?> getSCashBalance(
      {required String stockCode,
      required String price,
      required Side side}) async {
    final RequestDataModel requestDataModel = RequestDataModel.stringType(
      cmd: "Web.sCashBalance",
      p1: userService.token.value!.defaultAcc,
      p2: stockCode,
      p3: price,
      p4: side.code,
    );

    final RequestModel requestModel =
        RequestModel(userService, group: "Q", data: requestDataModel);
    return await networkService
        .requestTraditionalApi<StockCashBalanceModel>(requestModel);
  }

  @override
  Future<List<OrderHistoryModel>> getOrdersHistory(IUserService userService,
      {String? stockCode,
      DateTime? fromDay,
      DateTime? toDay,
      String? status,
      int? page,
      int? recordPerPage}) async {
    final RequestDataModel requestDataModel = RequestDataModel.cursorType(
      cmd: "ListOrder",
      p1: userService.token.value!.defaultAcc,
      p2: stockCode ?? "",
      p3: TimeUtilities.commonTimeFormat.format(
          fromDay ?? TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
      p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
      p5: status ?? "",
      p7: page?.toString() ?? "1",
      p8: recordPerPage?.toString() ?? "100",
    );

    final RequestModel requestModel =
        RequestModel(userService, group: "B", data: requestDataModel);

    final response = await networkService
        .requestTraditionalApiResList<OrderHistoryModel>(requestModel);
    if (response == null) {
      throw Exception();
    }
    logger.v(response);
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

  @override
  Future<CashTransactionModel> getCashTransactions(
      {String? user,
      DateTime? fromDay,
      DateTime? toDay,
      int? page,
      int? recordPerPage}) async {
    final RequestDataModel requestDataModel = RequestDataModel(
      cmd: "CashTransactionNew",
      p1: "0",
      p2: userService.token.value!.defaultAcc,
      p3: TimeUtilities.commonTimeFormat.format(
          fromDay ?? TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
      p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
      p5: page?.toString() ?? "1",
      p6: recordPerPage?.toString() ?? "100",
    );

    final RequestModel requestModel =
        RequestModel(userService, group: "B", data: requestDataModel);
    logger.v(requestModel.toJson());
    try {
      late TotalCashTransactionModel total;
      List<dynamic> selectionData(Map<String, dynamic> json) {
        logger.v(json);
        total = TotalCashTransactionModel.fromJson(
            json["data"].first["data1"].first);
        return json["data"].first["data2"];
      }

      dynamic response = await networkService
          .requestTraditionalApiResList<CashTransactionHistoryModel>(
        requestModel,
        selectionData: selectionData,
      );
      response = CashTransactionModel(total, response);
      if (response == null) {
        throw Exception();
      }
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<ShareTransactionModel>> getShareTransactions(
      {String? user,
      DateTime? fromDay,
      DateTime? toDay,
      int? page,
      int? recordPerPage}) async {
    final RequestDataModel requestDataModel = RequestDataModel(
      cmd: "ShareTransaction",
      p1: user ?? userService.token.value!.defaultAcc,
      p3: TimeUtilities.commonTimeFormat.format(
          fromDay ?? TimeUtilities.getPreviousDateTime(TimeUtilities.month(1))),
      p4: TimeUtilities.commonTimeFormat.format(toDay ?? DateTime.now()),
      p5: "0",
      p6: page?.toString() ?? "1",
      p7: recordPerPage?.toString() ?? "10",// hiển thị 10 item
    );

    final RequestModel requestModel =
        RequestModel(userService, group: "B", data: requestDataModel);
    logger.v(requestModel.toJson());
    try {
      List<dynamic> selectionData(Map<String, dynamic> json) {
        return json["data"].first["data2"];
      }

      final response = await networkService
          .requestTraditionalApiResList<ShareTransactionModel>(
        requestModel,
        selectionData: selectionData,
      );
      if (response == null) {
        throw Exception();
      }
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
