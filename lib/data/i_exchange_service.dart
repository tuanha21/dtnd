import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_network_service.dart';

abstract class IExchangeService {
  late final INetworkService networkService;

  IExchangeService.init(this.networkService);

  Future<void> createNewOrder(RequestModel requestModel);
}
