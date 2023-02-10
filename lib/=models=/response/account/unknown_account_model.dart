import 'package:dtnd/=models=/response/account/i_account.dart';

class UnknownAccountModel implements IAccountModel {
  @override
  String accCode = "";
  UnknownAccountModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  void updateData(IAccountResponse data) {
    // TODO: implement updateData
  }
}
