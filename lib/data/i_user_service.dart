import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/account_info_model.dart';
import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/=models=/response/account/cash_transaction_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/account/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:get/get.dart';

import '../=models=/response/accumulation/contract_fee_model.dart';
import '../=models=/response/accumulation/single_contract.dart';

abstract class IUserService {
  bool get isLogin;

  Rx<UserToken?> get token;

  Rx<bool?> get isRegisterVa;

  Rx<UserInfo?> get userInfo;

  Rx<TotalAsset?> get totalAsset;

  Rx<IAccountModel?> get defaultAccount;

  Rx<List<IAccountModel>?> get listAccountModel;

  List<String> get searchHistory;

  VAPortfolio? get vaPortfolio;

  bool get regSmartOTP;

  void changeRegSmartOTP(bool value);

  bool get regVA;

  void changeRegVA(bool value);

  Future<void> init();

  Future<void> deleteToken();

  Future<bool> saveToken(UserToken token, String password);

  Future<List<BaseOrderModel>?> getIndayOrder(
      {int? page,
      int? recordPerPage,
      String? accountCode,
      String? symbol,
      int? status,
      Side? side});

  Future<List<String>> getSearchHistory();

  Future<List<String>> getTopSearch();

  Future<void> refreshAssets();

  void putSearchHistory(String searchString);

  // Register session
  Future<bool> verifyRegisterInfo(String mobile, String mail);

  Future<bool> verifyRegisterOTP(String mobile, String mail, String otp);

  Future<SignUpSuccessDataModel?> createAccount(
      String name, String mobile, String mail, String pass);

  // VA
  // Future<>
  Future<VAPortfolio> getVAPortfolio();

  Future<void> createBot();

  Future<void> destroyBot();

  Future<void> saveValueRegisterVa();

  Future<CheckAccountSuccessDataModel?> checkAccountInfo(String mail);

  Future<bool> resetPassword(
      String id, String phone, String mail, String password);

  Future<void> deleteAccount();

  // Fee Rate, Contract
  Future<List<FeeRateModel>?> getAllFreeRate();

  Future<bool> updateContract(String termCode, num capital, String extentType);

  Future<List<ContractModel>?> getAllContract();

  Future<List<CashTransactionHistoryModel>?> getHistoryContract({
    DateTime? fromDay,
    DateTime? toDay,
    int? recordPerPage,
  });

  Future<bool> checkContractBase();

  Future<void> changeContractBase(int codeFlag);

  Future<ContractFee?> getProvisionalFee(String term, String capital);

  Future<SingleContract?> getSingleContract(String itemId);

  Future<SingleContract?> liquidAll(String contactId);

  Future<bool> methodUpdate(String contactId, String extentType);
}
