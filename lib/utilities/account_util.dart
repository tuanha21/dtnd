import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/=models=/response/account/base_normal_account_model.dart';
import 'package:dtnd/=models=/response/account/unknown_account_model.dart';

class AccountUtil {
  static Type getAccountType(String accountCode) {
    final String lastCode = accountCode[accountCode.length - 1];
    switch (lastCode) {
      case "1":
        return BaseNormalAccountModel;
      case "6":
        return BaseMarginAccountModel;
      default:
        return UnknownAccountModel;
    }
  }
}
