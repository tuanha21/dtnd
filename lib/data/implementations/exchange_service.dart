import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_network_service.dart';

class ExchangeService implements IExchangeService {
  ExchangeService._internal();

  static final ExchangeService _instance = ExchangeService._internal();

  static ExchangeService get instance => _instance;

  factory ExchangeService() => _instance;

  ExchangeService.init(this.networkService);

  @override
  late final INetworkService networkService;

  @override
  Future<void> createNewOrder(RequestModel requestModel) async {
    throw UnimplementedError();
  }
}
