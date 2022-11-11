// ignore_for_file: non_constant_identifier_names

import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkService implements INetworkService {
  final http.Client client = http.Client();

  NetworkService._internal();

  static final _instance = NetworkService._internal();
  static NetworkService get instance => _instance;

  factory NetworkService() {
    return _instance;
  }

  late Environment environment;

  late String core_url;
  late String core_endpoint;

  Uri get url_core => Uri.https(core_url, core_endpoint);

  @override
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await dotenv.load(fileName: environment.envFileName);
    core_url = dotenv.env['core_domain']!;
    core_endpoint = dotenv.env['core_endpoint']!;
    return;
  }

  @override
  Future<UserEntity?> checkLogin(RequestModel requestModel) async {
    logger.v(requestModel.toJson());
    final http.Response response =
        await client.post(url_core, body: requestModel.toString());
    logger.v(response.body);
    return null;
  }
}
