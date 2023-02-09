import 'package:dtnd/=models=/core_response_model.dart';

abstract class IAccountModel implements CoreResponseModel {
  late String accountCode;
  late num nav;
  late num cash;

  IAccountModel({required this.accountCode, this.nav = 0, this.cash = 0});
}
