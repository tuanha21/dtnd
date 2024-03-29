// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dtnd/=models=/algo/filter.dart';
import 'package:dtnd/=models=/algo/stock_filter.dart';
import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/=models=/response/accumulation/single_contract.dart';
import 'package:dtnd/=models=/response/market/business_profile_model.dart';
import 'package:dtnd/=models=/response/account/cash_transaction_model.dart';
import 'package:dtnd/=models=/response/market/commodity_model.dart';
import 'package:dtnd/=models=/response/market/company_info.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/market/index_board.dart';
import 'package:dtnd/=models=/response/market/index_chart_data.dart';
import 'package:dtnd/=models=/response/market/index_detail.dart';
import 'package:dtnd/=models=/response/market/introduct_company.dart';
import 'package:dtnd/=models=/response/market/liquidity_model.dart';
import 'package:dtnd/=models=/response/market/news_model.dart';
import 'package:dtnd/=models=/response/market/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/share_holder.dart';
import 'package:dtnd/=models=/response/market/signal_month_model.dart';
import 'package:dtnd/=models=/response/market/signal_type.dart';
import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/=models=/response/market/stock_board.dart';
import 'package:dtnd/=models=/response/market/stock_data.dart';
import 'package:dtnd/=models=/response/market/stock_derivative_model.dart';
import 'package:dtnd/=models=/response/market/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/market/stock_his.dart';
import 'package:dtnd/=models=/response/market/stock_news.dart';
import 'package:dtnd/=models=/response/market/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/market/stock_report_res.dart';
import 'package:dtnd/=models=/response/market/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/stock_vol.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/market/suggested_signal_model.dart';
import 'package:dtnd/=models=/response/market/top_influence_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_history_model.dart';
import 'package:dtnd/=models=/response/market/top_signal_stock_model.dart';
import 'package:dtnd/=models=/response/account/total_asset_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/=models=/response/market/world_index_model.dart';
import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:dtnd/=models=/ui_model/exception.dart';
import 'package:dtnd/=models=/response/market/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../=models=/local/va_portfolio_model.dart';
import '../../=models=/response/accumulation/contract_fee_model.dart';
import '../../=models=/response/banner_model.dart';
import '../../=models=/response/market/basic_company.dart';
import '../../=models=/response/market/ind_contrib.dart';
import '../../=models=/response/market/radar_chart_model.dart';
import '../../=models=/response/market/sec_event.dart';
import '../../=models=/response/market/sec_trading.dart';
import '../../=models=/response/market/stock_industry.dart';
import '../i_local_storage_service.dart';

const List<String> sessionExpiredMsg = [
  "FOException.InvalidSessionException",
  "FOException.NotLoginException: Not logged in!"
];

class NetworkService implements INetworkService {
  final http.Client client = http.Client();

  NetworkService._internal();

  static final _instance = NetworkService._internal();

  static NetworkService get instance => _instance;

  factory NetworkService() => _instance;

  late final void Function() onSessionExpired;

  late Environment environment;

  late final String core_url;
  late final String core_url1;
  late final String core_endpoint;
  late final String board_url;
  late final String sbboard_url;
  late final String info_sbsi_url;
  late final String algo_url;
  late final String algo_url_apec;

  @override
  Uri url_core(
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    return Uri.http(core_url, unencodedPath, queryParameters);
  }

  @override
  Uri url_core1(
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    print(Uri.http(core_url1, unencodedPath, queryParameters).toString());
    return Uri.http(core_url1, unencodedPath, queryParameters);
  }

  @override
  Uri get url_core_endpoint {
    print(Uri.http(core_url, core_endpoint).toString());
    return Uri.http(core_url, core_endpoint);
  }

  @override
  Uri url_board(String path) => Uri.https(board_url, path);

  @override
  Uri url_board_sbsi(String path) {
    print(Uri.https(sbboard_url, path));
    return Uri.https(sbboard_url, path);
  }

  @override
  Uri url_board_data_feed(Map<String, dynamic> queryParameters) {
    print(Uri.https(sbboard_url, "datafeed/history", queryParameters));
    return Uri.https(sbboard_url, "datafeed/history", queryParameters);
  }

  @override
  Uri url_info_sbsi(String path, [Map<String, dynamic>? queryParameters]) {
    print(Uri.https(info_sbsi_url, path, queryParameters).toString());
    return Uri.https(info_sbsi_url, path, queryParameters);
  }

  @override
  Uri url_algo(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    final unencodedPath = "algo/pbapi/api/$path";
    print(Uri.https(algo_url_apec, unencodedPath, queryParameters).toString());
    return Uri.https(algo_url_apec, unencodedPath, queryParameters);
  }

  @override
  Uri url_algo_apec(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    final unencodedPath = "algo/pbapi/api/$path";
    print(Uri.https(algo_url_apec, unencodedPath, queryParameters).toString());
    return Uri.https(algo_url_apec, unencodedPath, queryParameters);
  }

  final Utf8Codec utf8Codec = const Utf8Codec();

  @override
  late Socket socket;

  @override
  dynamic decode(dynamic data) {
    try {
      dynamic decoded;
      if (data is Uint8List) {
        decoded = jsonDecode(utf8Codec.decode(data));
      } else {
        decoded = jsonDecode(data);
      }
      if (decoded is Map<String, dynamic> &&
          decoded["rs"] != null &&
          sessionExpiredMsg.contains(decoded["rs"])) {
        throw const SessionExpiredException();
      }
      return decoded;
    } catch (e) {
      // print(data);
      if (e is SessionExpiredException) {
        onSessionExpired.call();
        return;
      }
      logger.e(e.toString());
      return null;
    }
  }

  @override
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) {
    return client.get(url, headers: headers);
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return client.post(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return client.put(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return client.delete(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await dotenv.load(fileName: environment.envFileName);
    core_url = dotenv.env['core_domain1']!;
    core_url1 = dotenv.env['core_domain1']!;
    core_endpoint = dotenv.env['core_endpoint']!;
    board_url = dotenv.env['board_domain']!;
    sbboard_url = dotenv.env['sbboard_domain']!;
    info_sbsi_url = dotenv.env['info_sbsi_domain']!;
    algo_url = dotenv.env['algo_domain']!;
    algo_url_apec = dotenv.env['algo_domain_apec']!;

    initSocket(sbboard_url);
    return;
  }

  @override
  Future<Map<String, dynamic>> getAppConfig() async {
    final response = await client
        .get(url_core1("getAppConfig"))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode != 200) {
      throw const NoInternetException();
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      throw const SomethingWentWrongException();
    }
  }

  @override
  void regSessionExpiredCallback(void Function() onSessionExpired) {
    this.onSessionExpired = onSessionExpired;
  }

  @override
  void initSocket(String url) {
    socket = io(
        'https://$url/ps',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .disableReconnection()
            .disableForceNewConnection()
            .setTimeout(8000)
            .build());
    return;
  }

  @override
  Future<void> startSocket() async {
    throw UnimplementedError();
  }

  @override
  Future<List<DataBanner>?> getHomeBanner() async {
    var response = await client.get(Uri.http(core_url1, "banners"));
    final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
    if (responseBody.isEmpty) throw Exception();
    List<DataBanner> data = [];
    for (var element in responseBody) {
      data.add(DataBanner.fromJson(element));
    }
    return data;
  }

  @override
  Future<T?> requestTraditionalApi<T extends CoreResponseModel>(
    RequestModel requestModel, {
    bool Function(Map<String, dynamic>)? hasError,
    T? Function(Map<String, dynamic>)? onError,
    T? Function()? onParseError,
    dynamic Function(Map<String, dynamic>)? selectionData,
    Map<String, dynamic> Function(Map<String, dynamic>)? modifyResponse,
  }) async {
    dynamic response =
        await client.post(url_core_endpoint, body: requestModel.toString());
    response = decode(response.bodyBytes);
    if (response is! Map<String, dynamic>) {
      return null;
    }
    bool checkResponse = hasError?.call(response) ?? (response["rc"] != 1);
    if (checkResponse) {
      return onError?.call(response);
    }
    if (selectionData != null) {
      response = selectionData.call(response);
    } else {
      response = response["data"];
    }
    if (modifyResponse != null) {
      response = modifyResponse.call(response);
    }
    try {
      return CoreResponseModel.fromJson<T>(response);
    } catch (e) {
      if (onParseError != null) {
        return onParseError.call();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<T>?> requestTraditionalApiResList<T extends CoreResponseModel>(
    RequestModel requestModel, {
    bool Function(Map<String, dynamic>)? hasError,
    List<T>? Function(Map<String, dynamic>)? onError,
    List<T>? Function()? onParseError,
    List<dynamic> Function(Map<String, dynamic>)? selectionData,
    Map<String, dynamic> Function(Map<String, dynamic>)? modifyResponse,
  }) async {
    dynamic response =
        await client.post(url_core_endpoint, body: requestModel.toString());
    response = decode(response.bodyBytes);
    bool checkResponse = hasError?.call(response) ?? (response["rc"] != 1);
    if (checkResponse) {
      return onError?.call(response);
    }
    if (selectionData != null) {
      response = selectionData.call(response);
    } else {
      response = response["data"];
    }
    final List<T> result = [];
    if (response.runtimeType != List || response.isEmpty) {
      return [];
    }
    for (var element in response) {
      try {
        result.add(CoreResponseModel.fromJson<T>(element)!);
      } catch (e) {
        if (onParseError != null) {
          return onParseError.call();
        } else {
          rethrow;
        }
      }
    }

    return result;
  }

  @override
  Future<List<Stock>> getListAllStock() async {
    const String path = "getlistallstock";
    final http.Response response = await client.get(url_board(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<Stock> data = [];
    for (var element in responseBody) {
      data.add(Stock.fromJson(element));
    }
    return data;
  }

  @override
  Future<List<String>> getList30Stocks(String code) async {
    const String path = "list30.pt";
    final Map<String, dynamic> param = {"market": code};
    final http.Response response = await client.get(url_info_sbsi(path, param));
    final String responseBody = decode(response.bodyBytes)['list'];

    if (responseBody.isEmpty) throw Exception();
    final List<String> data = responseBody.split(",");

    return data;
  }

  @override
  Future<List<StockDataResponse>> getListStockData(String listStock) async {
    final String path = "getliststockdata/$listStock";
    final http.Response response = await client.get(url_board(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<StockDataResponse>? data = [];
    for (var element in responseBody) {
      data.add(StockDataResponse.fromJson(element));
    }
    return data;
  }

  /// Should not call, too many datam, call method below
  @override
  Future<List<StockTrade>> getListStockTrade(String stockCode) async {
    final String path = "getliststocktrade/$stockCode";
    final http.Response response = await client.get(url_board(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<StockTrade>? data = [];
    for (var element in responseBody) {
      data.add(StockTrade.fromJson(element));
    }
    return data;
  }

  @override
  Future<StockTradingHistory?> getStockTradingHistory(
      String symbol, String resolution, int from, int to) async {
    final Map<String, String> queryParameters = {
      "symbol": symbol,
      "resolution": resolution,
      "from": "$from",
      "to": "$to",
    };
    logger.v(url_board_data_feed(queryParameters).toString());
    final http.Response response =
        await client.get(url_board_data_feed(queryParameters));
    final responseBody = decode(response.bodyBytes);
    if (responseBody == null) {
      return null;
    }
    if (responseBody == null) throw Exception();
    final StockTradingHistory data = StockTradingHistory.fromJson(responseBody);
    return data;
  }

  @override
  Future<List<IndexDetailResponse>> getListIndexDetail() async {
    const String path = "getlistindexdetail/11,10,02,03";
    final http.Response response = await client.get(url_board(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<IndexDetailResponse>? data = [];
    for (var element in responseBody) {
      data.add(IndexDetailResponse.fromJson(element));
    }
    return data;
  }

  @override
  Future<IndexDetailResponse> getIndexDetail(Index index) async {
    final String path = "getlistindexdetail/${index.code}";
    final http.Response response = await client.get(url_board(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    final IndexDetailResponse data =
        IndexDetailResponse.fromJson(responseBody.first);
    return data;
  }

  @override
  Future<List<IndexChartData>> getListIndexChartData(Index index) async {
    final String path = "getlistindexdetail/${index.code}";
    final http.Response response = await client.get(url_board(path));
    final responseBody = decode(response.bodyBytes);
    final List<dynamic> responseData = responseBody['data'];
    List<IndexChartData> data = [];
    for (var element in responseData) {
      try {
        data.add(IndexChartData.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<List<StockNews>> getStockNews(String stockCode) async {
    final Map<String, dynamic> queryParameters = {
      "symbol": stockCode,
    };
    final http.Response response =
        await client.get(url_info_sbsi("stockNews.pt", queryParameters));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    List<StockNews> data = [];
    for (var element in responseBody) {
      try {
        data.add(StockNews.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<List<NewsModel>> getNews(Map<String, String> body) async {
    final http.Response response =
        await client.get(url_core1("pickNews", body));
    final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
    List<NewsModel> data = [];
    for (var element in responseBody) {
      try {
        data.add(NewsModel.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<String> getNewsDetail(int id) async {
    final http.Response response = await client.get(url_core1(
      "pickContents/$id",
    ));
    var responseBody = decode(response.bodyBytes);
    logger.d(responseBody);
    if (responseBody['rc'] == -1) {
      return Future.error(responseBody['rs']);
    }
    final data = responseBody["rs"];
    return data;
  }

  @override
  Future<String> getNewsContent(int id) async {
    final http.Response response =
        await client.get(url_info_sbsi("newsDetail.pt", {"id": id.toString()}));

    var responseBody = decode(response.bodyBytes);
    logger.d(responseBody);
    if (responseBody['rc'] == -1) {
      return Future.error(responseBody['rs']);
    }
    final data = responseBody["Content"];
    return data;
  }

  @override
  Future<List<WorldIndexModel>> getWorldIndex() async {
    final http.Response response =
        await client.get(url_info_sbsi("worldIndex"));
    final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
    List<WorldIndexModel> data = [];
    for (var element in responseBody) {
      try {
        data.add(WorldIndexModel.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<List<CommodityModel>> getCommodity() async {
    final http.Response response =
        await client.get(url_info_sbsi("commodities"));
    final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
    List<CommodityModel> data = [];
    for (var element in responseBody) {
      try {
        data.add(CommodityModel.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<List<WorldIndexData>> getWorldIndexData(
      Map<String, String> body) async {
    final http.Response response =
        await client.get(url_info_sbsi("chartTime", body));
    final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
    List<WorldIndexData> data = [];
    for (var element in responseBody) {
      try {
        data.add(WorldIndexData.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }

  @override
  Future<List<DeepModel>> getMarketDepth() async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("marketDepth"));
      final List<dynamic> responseBody = decode(response.bodyBytes);
      List<DeepModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(DeepModel.fromJson(element));
        } catch (e) {
          continue;
        }
      }
      data.sort((a, b) => a.sortValue.compareTo(b.sortValue));
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  /// Todo: User

  @override
  Future<TotalAsset?> getTotalAsset(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core_endpoint, body: requestModel.toString());
    return TotalAsset.fromJson(decode(response.bodyBytes)['data']);
  }

  @override
  Future<List<String>> getSearchHistory(String body) async {
    dynamic response =
        await client.post(url_core1("searchMarket/history"), body: body);
    response = decode(response.bodyBytes);
    final List<String> list = [];
    if (response["rc"] == 1) {
      for (var element in response["data"]) {
        list.add(element);
      }
    }
    return list;
  }

  @override
  Future<void> putSearchHistory(String body) async {
    var res = await client.post(url_core1("searchMarket/event"), body: body);
    logger.d(jsonDecode(res.body));
  }

  @override
  Future<void> deleteAccount(String body) async {
    var res = await client.post(url_core_endpoint, body: body);
    logger.d(jsonDecode(res.body));
  }

  @override
  Future<List<String>> getTopSearch(String body) async {
    dynamic response =
        await client.post(url_core1("searchMarket/top"), body: body);
    response = decode(response.bodyBytes);
    final List<String> list = [];
    if (response["rc"] == 1) {
      for (var element in response["data"]) {
        list.add(element);
      }
    }
    return list;
  }

  @override
  Future<List<TrashModel>> getTopForeignTrade(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("topForeignTrade", body));

      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TrashModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TrashModel.fromJson(element["STOCK_CODE"]));
        } catch (e) {
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<TrashModel>> getTopStockChange(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("topStockChange", body));

      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TrashModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TrashModel.fromJson(element));
        } catch (e) {
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<TrashModel>> getTopInterested(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("topStockInterested", body));

      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TrashModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TrashModel.fromJson(element));
        } catch (e) {
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<TrashModel>> getTopStockTrade(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("topStockTrade", body));

      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TrashModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TrashModel.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<TopSignalStockModel>?> getTopSignalStocks(
      Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TopSignalStockModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TopSignalStockModel.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<SignalType>?> getSignalList(Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<SignalType> data = [];
      for (var element in responseBody) {
        try {
          data.add(SignalType.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<SuggestedSignalModel>?> getSuggestedSignal(
      Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<SuggestedSignalModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(SuggestedSignalModel.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<TopSignalDetailModel?> getTopSignalDetail(
      Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      TopSignalDetailModel data =
          TopSignalDetailModel.fromJson(responseBody.first);
      return data;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<TopSignalHistoryModel>?> getTopSignalHistory(
      Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      logger.v(response.body);
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<TopSignalHistoryModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(TopSignalHistoryModel.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  /// Todo: Order
  @override
  Future<List<IndayMatchedOrder>> getIndayMatchedOrders(String symbol) async {
    dynamic response =
        await client.get(url_algo("stockBoard/chart/stock/$symbol"));
    response = decode(response.bodyBytes);
    if (response['status'] != 200) {
      throw response['message'];
    }
    response = response['data'];
    if (response.isEmpty ?? true) {
      throw Exception();
    }
    final List<IndayMatchedOrder> result = <IndayMatchedOrder>[];
    for (var element in response) {
      result.add(IndayMatchedOrder.fromJson(element));
    }
    return result;
  }

  @override
  Future<List<TopInfluenceModel>> getTopInfluence(String index) async {
    dynamic response = await client.get(url_algo("Contrib", {"id": index}));
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["name"].isEmpty ?? true) {
      throw Exception();
    }
    final List<dynamic> val = response["upVal"];
    val.addAll(response["downVal"]);
    final List<dynamic> point = response["upPoint"];
    point.addAll(response["downPoint"]);
    final List<TopInfluenceModel> result = <TopInfluenceModel>[];
    for (var i = 0; i < response["name"].length; i++) {
      result.add(TopInfluenceModel(
        stockCode: response["name"][i],
        val: val[i],
        point: point[i],
      ));
    }

    return result;
  }

  @override
  Future<LiquidityModel> getLiquidity(String index) async {
    dynamic response = await client.get(url_algo("MarketValue", {"id": index}));
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    final LiquidityModel result = LiquidityModel.fromJson(response);
    return result;
  }

  @override
  Future<List<String>> getListIndustry() async {
    var response = await client.get(url_info_sbsi("listIndustry"));
    var data = jsonDecode(response.body);
    var list = data['data'] as List;
    List<String> listString = [];
    for (var element in list) {
      listString.add(element.toString());
    }
    return listString;
  }

  @override
  Future<List<StockIndustry>> getListStockByIndust(String industry) async {
    var response = await client
        .get(url_info_sbsi("listStockByIndust", {'industry': industry}));
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    var list = res["data"] as List;
    List<StockIndustry> result = [];
    for (var element in list) {
      if (element['GTGD'] != null) {
        result.add(StockIndustry.fromJson(element));
      }
    }
    return result;
  }

  @override
  Future<List<FieldTreeModel>> getListIndustryHeatMap(
      int top, String type) async {
    final param = {
      "top": top.toString(),
      "type": type,
    };
    dynamic response =
        await client.get(url_info_sbsi("listIndustryHeatMap", param));
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    response = response["data"];
    final List<FieldTreeModel> result = [];
    for (var element in response) {
      result.add(FieldTreeModel.fromJson(element));
    }
    return result;
  }

  @override
  Future<List<StockFinancialIndex>> getStockFinancialIndex(String body) async {
    var response = await client.post(url_algo("secFSRatios"), body: body);

    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);

    if (res["status"] != 200) {
      throw res["message"];
    }
    var list = decode(res["data"]) as List;
    final List<StockFinancialIndex> result = [];
    for (final element in list) {
      result.add(StockFinancialIndex.fromJson(element));
    }

    return result;
  }

  @override
  Future<StockRankingFinancialIndex?> getStockRankingFinancialIndex(
      String body) async {
    dynamic response =
        await client.post(url_algo("secRankingFSRatios"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = decode(response["data"]);
    final StockRankingFinancialIndex result =
        StockRankingFinancialIndex.fromJson(response);
    return result;
  }

  @override
  Future<SecurityBasicInfo?> getSecurityBasicInfo(String body) async {
    dynamic response =
        await client.post(url_algo("securityBasicInfo"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"].first;
    final SecurityBasicInfo result = SecurityBasicInfo.fromJson(response);
    return result;
  }

  @override
  Future<BusinnessProfileModel?> getBusinnessProfile(String body) async {
    dynamic response =
        await client.post(url_algo("companies/introduction"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"];
    final BusinnessProfileModel result =
        BusinnessProfileModel.fromJson(response);
    return result;
  }

  @override
  Future<BasicCompany> getBasicProfile(String code) async {
    dynamic response = await client.post(url_algo("companies/basic"),
        body: jsonEncode({"secCode": code}));
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"];
    final BasicCompany result = BasicCompany.fromJson(response);
    return result;
  }

  @override
  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String body) async {
    try {
      dynamic response =
          await client.post(url_algo("companies/leaders"), body: body);
      if (response.statusCode != 200) {
        throw response;
      }
      response = decode(response.bodyBytes);

      if (response["status"] != 200) {
        throw response["message"];
      }
      response = response["data"];
      final List<BusinnessLeaderModel> result = [];
      for (var element in response) {
        if (element['personalHeldPct'] != "0") {
          result.add(BusinnessLeaderModel.fromJson(element));
        }
      }
      return result;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SubsidiariesModel>?> getSubsidiaries(
      Map<String, dynamic> body) async {
    try {
      var response =
          await client.get(url_algo_apec("companies/relatedCompanies", body));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      if (res["status"] != 200) {
        throw res["message"];
      }
      var listData = res["data"];
      final List<SubsidiariesModel> result = [];
      for (var element in listData) {
        result.add(SubsidiariesModel.fromJson(element));
      }
      return result;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<IndexBoard>> getIndexBoard(String marketCode) async {
    var response =
        await client.get(url_algo("stockBoard/chart/index/$marketCode"));
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["status"] != 200) {
      throw res["message"];
    }
    var list = res["data"] as List;
    List<IndexBoard> result = [];
    for (var element in list) {
      /// lọc với giá trị lỗi
      if (element['Advances'] > 0 ||
          element['Declines'] > 0 ||
          element['NoChanges'] > 0) {
        result.add(IndexBoard.fromJson(element));
      }
    }
    return result;
  }

  @override
  Future<List<String>> getSectors(String industryCode) async {
    var response = await client.get(url_algo("sectors/$industryCode"));
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["status"] != 200) {
      throw res["message"];
    }
    var list = res["data"] as List;
    final List<String> result = [];
    for (var element in list) {
      result.add(element['securityCode']);
    }
    return result;
  }

  @override
  Future<IndContrib> getIndContrib(String marketCode) async {
    try {
      var response =
          await client.get(url_algo_apec("IndContrib", {"id": marketCode}));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      return IndContrib.fromJson(res);
    } catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }

  @override
  Future<IndContrib> getFIvalue(String marketCode) async {
    try {
      var response =
          await client.get(url_algo_apec("Fvalue", {"id": marketCode}));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      return IndContrib.fromJson(res);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<IndContrib> getPIvalue(String marketCode) async {
    try {
      var response =
          await client.get(url_algo_apec("PIvalue", {"id": marketCode}));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      if (res["status"] != 200) {
        throw res["message"];
      }
      return IndContrib.fromJson(res['data']);
    } catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SecEvent>> getListEvent(String stockCode,
      {required DateTime startDate,
      required String lang,
      required String reqLanguage}) async {
    try {
      var response = await client.get(url_algo_apec('news/sec_news', {
        "lang": lang,
        "secCode": stockCode,
        "startDate": TimeUtilities.usTimeFormat.format(startDate),
        "reqLanguage": reqLanguage,
      }));
      if (response.statusCode != 200) {
        throw response;
      }

      var res = decode(response.bodyBytes);

      var list = res['data'] as List;
      var listSecc = <SecEvent>[];
      for (var element in list) {
        listSecc.add(SecEvent.fromJson(element));
      }
      return listSecc;
    } catch (e) {
      logger.e((e as http.Response).request?.url);
      rethrow;
    }
  }

  @override
  Future<CompanyIntroductionResponse> getCompanyIntroduction(
      String stockCode) async {
    var response = await client.post(
        Uri.https(
            'opacc-api.apec.com.vn', 'algo/pbapi/api/companies/introduction'),
        body: jsonEncode({"secCode": stockCode}));
    var res = decode(response.bodyBytes);
    return CompanyIntroductionResponse.fromJson(res);
  }

  @override
  Future<CompanyInfo> getCompanyInfo(String stockCode) async {
    var response = await client
        .get(url_info_sbsi('companyInfo.pt', {"symbol": stockCode}));
    var res = decode(response.bodyBytes);
    return CompanyInfo.fromJson(res);
  }

  @override
  Future<StockReportRes> getStockInfo(String stockCOde) async {
    var response = await client.get(url_info_sbsi('stockReport.pt', {
      "symbol": stockCOde,
      "type": "CSTC",
      "termtype": "1",
      "from": "1",
      "to": "4"
    }));
    var res = decode(response.bodyBytes);
    return StockReportRes.fromJson(res);
  }

  @override
  Future<List<StockMatch>> getListStockMatch(String stockCode) async {
    try {
      var response = await client.get(Uri.https('opacc-api.apec.com.vn',
          'algo/pbapi/api/stockBoard/stock/getDetailsActivelyByPrice/$stockCode'));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      var list = res['data'] as List;
      var listSecc = <StockMatch>[];
      for (var element in list) {
        listSecc.add(StockMatch.fromJson(element));
      }
      return listSecc;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StockHis>> getStockHis(
      String stockCode, String from, String to) async {
    try {
      var response = await client.get(url_info_sbsi('stockHis.pt', {
        "symbol": stockCode,
        "from": from,
        "to": to,
        "page": "1",
        "pageSize": "100"
      }));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      var list = res as List;
      var listSecc = <StockHis>[];
      for (var element in list) {
        listSecc.add(StockHis.fromJson(element));
      }
      return listSecc;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<StockBoard> getStockBoard(String stockCode) async {
    var response =
        await client.get(url_algo_apec('stockBoard/stock/$stockCode'));
    var res = decode(response.bodyBytes);
    return StockBoard.fromJson(res['data']);
  }

  @override
  Future<List<SecTrading>> getSecTradingHistory(String stockCode) async {
    try {
      var response = await client.post(
          Uri.https(
              'opacc-api.apec.com.vn', 'algo/pbapi/api/secTradingHistory'),
          body: jsonEncode({
            "lang": "vi",
            "secCode": stockCode,
            "startDate": DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(const Duration(days: -20))),
            "endDate": DateFormat('yyyy-MM-dd').format(DateTime.now())
          }));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      var list = jsonDecode(res['data']) as List;
      list = list.reversed.toList();
      var listSecc = <SecTrading>[];
      for (var element in list) {
        if (list.indexOf(element) > 9) break;
        listSecc.add(SecTrading.fromJson(element));
      }
      listSecc = listSecc.reversed.toList();
      return listSecc;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ShareHolders>> getShareHolderCompany(String stockCode) async {
    try {
      var response = await client.post(
          Uri.https(
              'opacc-api.apec.com.vn', 'algo/pbapi/api/companies/shareholders'),
          body: jsonEncode({"secCode": stockCode}));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      var list = res['data'] as List;
      var listSecc = <ShareHolders>[];
      for (var element in list) {
        listSecc.add(ShareHolders.fromJson(element));
      }
      return listSecc;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Filter>> getFilterAccount() async {
    IUserService userService = UserService();
    var response = await client.get(url_algo_apec('getFilters'),
        headers: {"X-USERNAME": userService.token.value?.user ?? ""});
    var mapData = json.decode(response.body);
    logger.d(mapData);
    List data = mapData['data'];
    var list = <Filter>[];
    for (var element in data) {
      list.add(Filter.fromJson(element));
    }
    return list;
  }

  @override
  Future<List<FilterRange>> getFilterRange() async {
    var response = await client.get(url_algo_apec('getFilterRange'));
    var mapData = json.decode(response.body);
    List data = mapData['data'];
    var list = <FilterRange>[];
    for (var element in data) {
      list.add(FilterRange.fromJson(element));
    }
    return list;
  }

  @override
  Future<List<StockFilter>> getStockFilter(Filter filter) async {
    IUserService userService = UserService();

    try {
      var body = {
        "lang": "vi",
        "action": 'R',
        "name": filter.name,
        "filterId": filter.filterId,
        "exchange": filter.exchangeCode,
        "industry": filter.industryCode,
        "filter": filter.list
            .map((e) => {"code": e.code, "low": e.low, "high": e.high})
            .toList()
      };
      final response = await client.post(
          Uri.https('opacc-api.apec.com.vn', 'algo/pbapi/api/filter'),
          body: jsonEncode(body),
          headers: {"X-USERNAME": userService.token.value?.user ?? ""});
      var mapData = json.decode(response.body);
      List data = mapData['data']['items'];
      var list = <StockFilter>[];
      for (var element in data) {
        list.add(StockFilter.fromJson(element));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future setFilter(Filter filter, String type) async {
    IUserService userService = UserService();

    try {
      var body = {
        "lang": "vi",
        "action": type,
        "name": filter.name,
        "filterId": filter.filterId,
        "exchange": filter.exchangeCode,
        "industry": filter.industryCode,
        "filter": filter.list
            .map((e) => {"code": e.code, "low": e.low, "high": e.high})
            .toList()
      };
      final response = await http.post(
          Uri.https('opacc-api.apec.com.vn', 'algo/pbapi/api/filter'),
          body: jsonEncode(body),
          headers: {"X-USERNAME": userService.token.value?.user ?? ""});
      var mapData = json.decode(response.body);
      print(mapData);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future deleteFilter(int id) async {
    IUserService userService = UserService();

    try {
      var body = {"filterId": id};
      final response = await http.post(
          Uri.https('opacc-api.apec.com.vn', 'algo/pbapi/api/deleteFilter'),
          body: jsonEncode(body),
          headers: {"X-USERNAME": userService.token.value?.user ?? ""});
      var mapData = json.decode(response.body);
      print(mapData);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<IndContrib> getIndFvalue(String marketCode) async {
    try {
      var response =
          await client.get(url_algo_apec("IndFvalue", {"id": marketCode}));
      if (response.statusCode != 200) {
        throw response;
      }
      var res = decode(response.bodyBytes);
      return IndContrib.fromJson(res);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DerivativeResModel>> getListDerivative() async {
    var response = await client.get(url_board("pslistdata"));
    var data = jsonDecode(response.body);
    var list = data as List;
    List<String> listString = [];
    for (var element in list) {
      listString.add(element.toString());
    }

    try {
      // "VN30F2303","VN30F2304","VN30F2306","VN30F2309"
      final http.Response _res = await client.get(url_board(
          "getpsalldatalsnapshot/${listString.isNotEmpty ? listString.join(',') : "VN30F2303,VN30F2304,VN30F2306,VN30F2309"}"));

      final List<dynamic> responseBody = decode(_res.bodyBytes);
      if (responseBody.isEmpty) throw Exception();

      List<DerivativeResModel>? dataS = [];
      for (var element in responseBody) {
        dataS.add(DerivativeResModel.fromJson(element));
      }
      return dataS;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // Signup
  @override
  Future<bool> verifySignupInfo(String body) async {
    var response = await client.post(url_core1("openAccount/verifyPhoneEmail"),
        body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    logger.v(res);
    if (res["iRs"] != 1) {
      throw res;
    }

    return true;
  }

  @override
  Future<bool> verifySignupOTP(String body) async {
    var response =
        await client.post(url_core1("openAccount/verifyOtp"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    logger.v(res);

    if (res["rc"] != 1) {
      return false;
    }

    return true;
  }

  @override
  Future<SignUpSuccessDataModel?> createAccount(String body) async {
    final ILocalStorageService localStorageService = LocalStorageService();
    var response =
        await client.post(url_core1("openAccount/create"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    logger.v(res);

    if (res["iRs"] == 1) {
      final data = res["data"];
      String? accountCode;
      if (data is List && data.length == 1) {
        accountCode = SignUpSuccessDataModel.fromJson(data.first).cACCOUNTCODE;
        localStorageService.saveInfoRegistered(
            accountCode?.substring(0, accountCode.length - 1) ?? '');
        return SignUpSuccessDataModel.fromJson(data.first);
      } else if (data is Map<String, dynamic>) {
        accountCode = SignUpSuccessDataModel.fromJson(data).cACCOUNTCODE;
        localStorageService.saveInfoRegistered(
            accountCode?.substring(0, accountCode.length - 1) ?? '');
        return SignUpSuccessDataModel.fromJson(data);
      } else {
        throw "Lỗi hệ thống. Vui lòng thử lại sau!";
      }
    } else {
      throw res["sRs"];
    }
  }

  @override
  Future<bool> checkInfoVa(String body) async {
    var response =
        await client.post(url_core1('vtBroker/infoRegister'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerVirtualBroker(String body) async {
    var response =
        await client.post(url_core1('vtBroker/register'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> checkRegisterOtp(String body) async {
    var response =
        await client.post(url_core1('vtBroker/verifyOtp'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<VAPortfolio> getVAPortfolio(String body) async {
    final response =
        await client.post(url_core1('autoTrade/showInfoBot'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    final res = decode(response.bodyBytes);
    if (res['rc'] == 1) {
      return VAPortfolio.fromJson(res['data']);
    } else {
      throw res;
    }
  }

  @override
  Future<void> createBot(String body) async {
    var response =
        await client.post(url_core1('autoTrade/createBot'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return res;
    } else {
      throw res["rs"];
    }
  }

  @override
  Future<void> deleteBot(String body) async {
    var response =
        await client.post(url_core1('autoTrade/destroyBot'), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return res;
    } else {
      throw res["rs"];
    }
  }

  @override
  Future<List<SignalMonthModel>?> getSignalMonth(
      Map<String, String> body) async {
    try {
      final http.Response response =
          await client.get(url_info_sbsi("proxy", body));
      final List<dynamic> responseBody = decode(response.bodyBytes)["data"];
      List<SignalMonthModel> data = [];
      for (var element in responseBody) {
        try {
          data.add(SignalMonthModel.fromJson(element));
        } catch (e) {
          logger.e(e);
          continue;
        }
      }
      return data;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<RadarChartModel> getDataRadarChart(String body) async {
    RadarChartModel radarChartModel;
    var response =
        await client.post(url_algo("secRankingFSRatios"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["status"] != 200) {
      throw res["message"];
    }
    var data = decode(res["data"]);
    radarChartModel = RadarChartModel.fromJson(data);
    return radarChartModel;
  }

  @override
  Future<CheckAccountSuccessDataModel?> checkAccountInfo(String body) async {
    var response = await client.post(url_core1("openAccount/di"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    logger.v(res);

    if (res["iRs"] == 1) {
      final data = res["data"];
      return CheckAccountSuccessDataModel.fromJson(data.first);
    } else {
      throw res["sRs"];
    }
  }

  @override
  Future<bool> resetPassword(String body) async {
    var response =
        await client.post(url_core1("openAccount/resetPass"), body: body);
    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<FeeRateModel>?> getAllFreeRate(String body) async {
    List<FeeRateModel> feeRateModel = [];
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    final data = res["data"];
    for (var element in data) {
      feeRateModel.add(FeeRateModel.fromJson(element));
    }
    return feeRateModel;
  }

  @override
  Future<bool> updateContract(String body) async {
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);

    if (res["rc"] == 1) {
      return true;
    } else {
      throw res["rs"];
    }
  }

  @override
  Future<List<ContractModel>?> getAllContract(String body) async {
    List<ContractModel> feeRateModel = [];
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    final data = res["data"];
    for (var element in data) {
      feeRateModel.add(ContractModel.fromJson(element));
    }
    return feeRateModel;
  }

  @override
  Future<List<CashTransactionHistoryModel>?> getHistoryContract(
      String body) async {
    List<CashTransactionHistoryModel> historyContract = [];
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    final data = res["data"];
    for (var element in data) {
      historyContract.add(CashTransactionHistoryModel.fromJson(element));
    }
    return historyContract;
  }

  @override
  Future<bool> checkContractBase(String body) async {
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      return false;
    }
    var res = decode(response.bodyBytes);
    final flag = res["data"].first['C_AUTO_FLAG'];
    return flag == 1.0;
  }

  @override
  Future<void> changeContractBase(String body) async {
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw false;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return res;
    } else {
      throw res["rs"];
    }
  }

  @override
  Future<ContractFee?> getProvisionalFee(String body) async {
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      final data = res["data"];
      return ContractFee.fromJson(data.first);
    } else {
      throw res["sRs"];
    }
  }

  @override
  Future<SingleContract?> getSingleContract(String itemId) async {
    var response = await client.post(url_core_endpoint, body: itemId);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      final data = res["data"];
      return SingleContract.fromJson(data.first);
    } else {
      throw res["sRs"];
    }
  }

  @override
  Future<SingleContract?> liquidAll(String contractId) async {
    var response = await client.post(url_core_endpoint, body: contractId);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      final data = res["data"];
      return SingleContract.fromJson(data.first);
    } else {
      throw res["sRs"];
    }
  }

  @override
  Future<bool> methodUpdate(String body) async {
    var response = await client.post(url_core_endpoint, body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    var res = decode(response.bodyBytes);
    if (res["rc"] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
