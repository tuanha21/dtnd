import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:get/get.dart';

class AssetController {
  static final AssetController _instance = AssetController._intern();

  AssetController._intern();

  factory AssetController() => _instance;

  final Rx<List<IAccountModel>> listAccount = Rx<List<IAccountModel>>([]);

  
}
