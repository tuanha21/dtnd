// ignore_for_file: non_constant_identifier_names

import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:http/http.dart' as http;

class NetworkService implements INetworkService {
  final http.Client client = http.Client();

  NetworkService._internal();

  static final _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }

  @override
  Future<void> init(String config) async {
    return;
  }

  @override
  Future<UserToken?> checkLogin(RequestModel requestModel) async {
    // final http.Response response = await client.post();
    return null;
  }
}
