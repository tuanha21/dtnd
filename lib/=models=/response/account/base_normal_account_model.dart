import 'package:dtnd/=models=/response/account/i_account.dart';

class BaseNormalAccountModel implements IAccountModel {
  @override
  late String accountCode;

  @override
  late num cash;

  @override
  late num nav;

  BaseNormalAccountModel.fromJson(Map<String, dynamic> json) {
    accountCode = "1";
  }

  @override
  BaseNormalAccountModel fromJson(Map<String, dynamic> json) {
    return BaseNormalAccountModel.fromJson(json);
  }
}
