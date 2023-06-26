import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/i_network_service.dart';

class UnknownAccountModel extends IAccountModel {
  UnknownAccountModel.fromJson(Map<String, dynamic> json) : super(accCode: "") {
    throw UnimplementedError();
  }

  @override
  void updateDataFromJson(IAccountResponse? jsonData) {
    throw UnimplementedError();
  }

  @override
  Future<List<UnexecutedRightModel>> getListUnexecutedRight(
      IUserService userService, INetworkService networkService) {
    throw UnimplementedError();
  }

  @override
  Future<List<UnexecutedRightModel>> getListRightBuy(
      IUserService userService, INetworkService networkService) {
    throw UnimplementedError();
  }

  @override
  Future<List<UnexecutedRightModel>> getListHistoryBuy(
      IUserService userService, INetworkService networkService,{String? fromDay, String? toDay}) {
    throw UnimplementedError();
  }
}
