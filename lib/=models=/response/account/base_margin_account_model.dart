import 'package:dtnd/=models=/response/account/i_account.dart';

class BaseMarginAccountModel implements IAccountModel {
  @override
  late String accountCode;

  @override
  late num cash;

  @override
  late num nav;

  BaseMarginAccountModel.fromJson(Map<String, dynamic> json) {
    accountCode = "6";
  }

  @override
  BaseMarginAccountModel fromJson(Map<String, dynamic> json) {
    return BaseMarginAccountModel.fromJson(json);
  }
}
