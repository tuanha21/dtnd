import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:get/get.dart';

class AccumulationController {
  static final AccumulationController _instance =
      AccumulationController._intern();
  static AccumulationController get instance => _instance;

  AccumulationController._intern();

  factory AccumulationController() => _instance;

  // State
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  final Rx<List<FeeRateModel>?> listFeeRate = Rx(<FeeRateModel>[]);
  final Rx<List<ContractModel>?> listAllContract = Rx(<ContractModel>[]);
  final Rx<bool> accumulationInitialized = false.obs;

  Future<void> init() async {
    await getFeeRate();
    await getAllContract();
    accumulationInitialized.value = true;
  }

  Future<void> getFeeRate() async {
    final allFeeRate = await userService.getAllFreeRate();
    if ((allFeeRate?.isEmpty ?? true) || allFeeRate == null) {
      throw Exception();
    } else {
      listFeeRate.value!.clear();
      listFeeRate.value!.addAll(allFeeRate);
      listFeeRate.refresh();
    }
  }

  FeeRateModel getItemFeeRate(String id) {
    FeeRateModel itemWithId;
    itemWithId = listFeeRate.value!.firstWhere((item) => item.id == id);
    return itemWithId;
  }

  Future<void> getAllContract() async {
    final allContract = await userService.getAllContract();
    if ((allContract?.isEmpty ?? true) || allContract == null) {
      throw Exception();
    } else {
      listAllContract.value!.clear();
      listAllContract.value!.addAll(allContract);
      listAllContract.refresh();
    }
  }

  ContractModel getItemContract(String id) {
    ContractModel itemWithId;
    itemWithId = listAllContract.value!.firstWhere((item) => item.id == id);
    return itemWithId;
  }
}
