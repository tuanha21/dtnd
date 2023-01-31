// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/business_profile_model.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/inday_matched_order.dart';
import 'package:dtnd/=models=/response/index_board.dart';
import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/=models=/response/new_order.dart';
import 'package:dtnd/=models=/response/news_detail.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/response/security_basic_info_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_news.dart';
import 'package:dtnd/=models=/response/stock_ranking_financial_index_model.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/subsidiaries_model.dart';
import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';

class NetworkService implements INetworkService {
  final http.Client client = http.Client();

  NetworkService._internal();

  static final _instance = NetworkService._internal();

  static NetworkService get instance => _instance;

  factory NetworkService() => _instance;

  late Environment environment;

  late final String core_url;
  late final String core_endpoint;
  late final String board_url;
  late final String sbboard_url;
  late final String info_sbsi_url;
  late final String algo_url;

  Uri get url_core => Uri.https(core_url, core_endpoint);

  Uri url_board(String path) => Uri.https(board_url, path);

  Uri url_board_data_feed(Map<String, dynamic> queryParameters) =>
      Uri.https(sbboard_url, "datafeed/history", queryParameters);

  Uri url_info_sbsi(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(info_sbsi_url, path, queryParameters);

  Uri url_algo(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    final unencodedPath = "algo/pbapi/api/$path";
    print(Uri.http(algo_url, unencodedPath, queryParameters).toString());
    return Uri.http(algo_url, unencodedPath, queryParameters);
  }

  final Utf8Codec utf8Codec = const Utf8Codec();

  @override
  late Socket socket;

  dynamic decode(dynamic data) {
    try {
      if (data is Uint8List) {
        return jsonDecode(utf8Codec.decode(data));
      } else {
        return jsonDecode(data);
      }
    } catch (e) {
      // print(data);
      logger.e(e.toString());
      return null;
    }
  }

  @override
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await dotenv.load(fileName: environment.envFileName);
    core_url = dotenv.env['core_domain']!;
    core_endpoint = dotenv.env['core_endpoint']!;
    board_url = dotenv.env['board_domain']!;
    sbboard_url = dotenv.env['sbboard_domain']!;
    info_sbsi_url = dotenv.env['info_sbsi_domain']!;
    algo_url = dotenv.env['algo_domain']!;
    initSocket(sbboard_url);
    return;
  }

  @override
  void initSocket(String url) {
    socket = io(
        'https://$url/ps',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    return;
  }

  @override
  Future<void> startSocket() async {
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> checkLogin(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    logger.v(response.body);
    return UserEntity.fromJson(decode(response.bodyBytes));
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
      String symbol, resolution, from, to) async {
    final Map<String, dynamic> queryParameters = {
      "symbol": symbol,
      "resolution": resolution,
      "from": from,
      "to": to,
    };
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
    const String path = "getlistindexdetail/10,11,02,03";
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
  Future<NewsDetail?> getNewsDetail(int id) async {
    final Map<String, dynamic> queryParameters = {
      "id": id,
    };
    final http.Response response =
        await client.get(url_info_sbsi("stockNews.pt", queryParameters));
    final responseBody = decode(response.bodyBytes);
    try {
      return NewsDetail.fromJson(responseBody);
    } catch (e) {
      logger.e(e);
      return null;
    }
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

  @override
  Future<SCashBalance> getSCashBalance(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    logger.v(response.body);
    return SCashBalance.fromJson(decode(response.bodyBytes));
  }

  @override
  Future<NewOrderResponse?> createNewOrder(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    logger.v(response.body);
    return NewOrderResponse.fromJson(decode(response.bodyBytes));
  }

  @override
  Future<UserInfo?> getUserInfo(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    logger.v(response.body);
    return UserInfo.constant();
  }

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
      throw NullThrownError();
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
      throw NullThrownError();
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
    dynamic response = await client.post(url_algo("secFSRatios"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = decode(response["data"]);
    logger.v(response);
    final List<StockFinancialIndex> result = [];
    for (final element in response) {
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
    logger.v(response);
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
    logger.v(response);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"].first;
    logger.v(response);
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
    logger.v(response);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"];
    final BusinnessProfileModel result =
        BusinnessProfileModel.fromJson(response);
    return result;
  }

  @override
  Future<List<BusinnessLeaderModel>?> getBusinnessLeaders(String body) async {
    dynamic response =
        await client.post(url_algo("companies/leaders"), body: body);
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    logger.v(response);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"];
    final List<BusinnessLeaderModel> result = [];
    for (var element in response) {
      result.add(BusinnessLeaderModel.fromJson(element));
    }
    return result;
  }

  @override
  Future<List<SubsidiariesModel>?> getSubsidiaries(
      Map<String, dynamic> body) async {
    dynamic response =
        await client.get(url_algo("companies/relatedCompanies", body));
    if (response.statusCode != 200) {
      throw response;
    }
    response = decode(response.bodyBytes);
    logger.v(response);
    if (response["status"] != 200) {
      throw response["message"];
    }
    response = response["data"];
    final List<SubsidiariesModel> result = [];
    for (var element in response) {
      result.add(SubsidiariesModel.fromJson(element));
    }
    return result;
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
          element['NoChanges'] > 0 ) {
        result.add(IndexBoard.fromJson(element));
      }
    }
    return result;
  }
}
