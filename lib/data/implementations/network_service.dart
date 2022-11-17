// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/=models=/response/index_chart_data.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_data.dart';
import 'package:dtnd/=models=/response/stock_trade.dart';
import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkService implements INetworkService {
  final http.Client client = http.Client();

  NetworkService._internal();

  static final _instance = NetworkService._internal();
  static NetworkService get instance => _instance;

  factory NetworkService() => _instance;

  late Environment environment;

  late String core_url;
  late String core_endpoint;
  late String data_feed_url;
  late String board_data_feed_url;

  Uri get url_core => Uri.https(core_url, core_endpoint);
  Uri url_data_feed(String path) => Uri.https(data_feed_url, path);
  Uri url_board_data_feed(Map<String, dynamic> queryParameters) =>
      Uri.https(board_data_feed_url, "datafeed/history", queryParameters);

  final Utf8Codec utf8Codec = const Utf8Codec();

  dynamic decode(Uint8List data) {
    return jsonDecode(utf8Codec.decode(data));
  }

  @override
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await dotenv.load(fileName: environment.envFileName);
    core_url = dotenv.env['core_domain']!;
    core_endpoint = dotenv.env['core_endpoint']!;
    data_feed_url = dotenv.env['data_feed_domain']!;
    board_data_feed_url = dotenv.env['board_data_feed_domain']!;
    return;
  }

  @override
  Future<UserEntity?> checkLogin(RequestModel requestModel) async {
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    return UserEntity.fromJson(decode(response.bodyBytes));
  }

  @override
  Future<List<Stock>> getListAllStock() async {
    const String path = "getlistallstock";
    final http.Response response = await client.get(url_data_feed(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<Stock> data = [];
    for (var element in responseBody) {
      data.add(Stock.fromJson(element));
    }
    return data;
  }

  @override
  Future<List<StockData>> getListStockData(String listStock) async {
    final String path = "getliststockdata/$listStock";
    final http.Response response = await client.get(url_data_feed(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<StockData>? data = [];
    for (var element in responseBody) {
      data.add(StockData.fromJson(element));
    }
    return data;
  }

  /// Should not call, too many datam, call method below
  @override
  Future<List<StockTrade>> getListStockTrade(String stockCode) async {
    final String path = "getliststocktrade/$stockCode";
    final http.Response response = await client.get(url_data_feed(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    List<StockTrade>? data = [];
    for (var element in responseBody) {
      data.add(StockTrade.fromJson(element));
    }
    return data;
  }

  @override
  Future<StockTradingHistory> getStockTradingHistory(
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
    if (responseBody == null) throw Exception();
    final StockTradingHistory data = StockTradingHistory.fromJson(responseBody);
    return data;
  }

  @override
  Future<List<IndexDetailResponse>> getListIndexDetail() async {
    const String path = "getlistindexdetail/10,11,02,03";
    final http.Response response = await client.get(url_data_feed(path));
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
    final http.Response response = await client.get(url_data_feed(path));
    final List<dynamic> responseBody = decode(response.bodyBytes);
    if (responseBody.isEmpty) throw Exception();
    final IndexDetailResponse data =
        IndexDetailResponse.fromJson(responseBody.first);
    return data;
  }

  @override
  Future<List<IndexChartData>> getListIndexChartData(Index index) async {
    final String path = "getlistindexdetail/${index.code}";
    final http.Response response = await client.get(url_data_feed(path));
    final responseBody = decode(response.bodyBytes);
    final List<dynamic> responseData = responseBody['data'];
    List<IndexChartData>? data = [];
    for (var element in responseData) {
      try {
        data.add(IndexChartData.fromJson(element));
      } catch (e) {
        continue;
      }
    }
    return data;
  }
}
