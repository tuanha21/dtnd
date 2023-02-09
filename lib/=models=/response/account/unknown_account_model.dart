import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';

class UnknownAccountModel implements IAccountModel {
  @override
  late String accountCode;

  @override
  late num cash;

  @override
  late num nav;

  @override
  CoreResponseModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
