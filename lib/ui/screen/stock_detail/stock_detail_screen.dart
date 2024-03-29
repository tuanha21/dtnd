// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/enum/detail_tab_enum.dart';
import 'package:dtnd/ui/screen/stock_detail/tab/finance_index_tab.dart';
import 'package:dtnd/ui/screen/stock_detail/tab/overview_tab.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/component/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/stock_detail_overview.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/service/app_services.dart';
import '../../../l10n/generated/l10n.dart';
import '../../widget/overlay/custom_dialog.dart';
import '../exchange_stock/stock_order/business/stock_order_flow.dart';
import 'tab/technical_analysis.dart';
import 'tab/transaction_tab.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({
    Key? key,
    required this.stockModel,
  }) : super(key: key);
  final StockModel stockModel;

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final IDataCenterService dataCenterService = DataCenterService();
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await getStockIndayTradingHistory();
    await getSecurityBasicInfo();
    widget.stockModel.businnessLeaders ??= await dataCenterService
        .getBusinnessLeaders(widget.stockModel.stock.stockCode);
  }

  Future<void> getStockIndayTradingHistory() async {
    widget.stockModel.indayTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(widget.stockModel.stock.stockCode);
  }

  Future<void> getSecurityBasicInfo() async {
    widget.stockModel.securityBasicInfo.value = await dataCenterService
        .getSecurityBasicInfo(widget.stockModel.stock.stockCode);
  }

  // Future<void> getStockRankingFinancialIndex() async {
  //   widget.stockModel.stockRankingFinancialIndex.value = await dataCenterService
  //       .getStockRankingFinancialIndex(widget.stockModel.stock.stockCode);
  // }
  //
  // Future<void> getIndayMatchedOrders() async {
  //   final listMatchedOrder = await dataCenterService
  //       .getIndayMatchedOrders(widget.stockModel.stock.stockCode);
  //   widget.stockModel.updateListMatchedOrder(listMatchedOrder);
  // }

  void _onFABTapped() async {
    if (!userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        if (result && mounted) {
          if (!localStorageService.biometricsRegistered) {
            final reg = await showDialog<bool>(
              context: context,
              builder: (context) {
                return CustomDialog(
                  textButtonAction: S.of(context).ok,
                  textButtonExit: S.of(context).later,
                  title: S.of(context).biometric_authentication,
                  content: S.of(context).login_with_biometric,
                  action: () => Navigator.of(context).pop(true),
                  type: TypeAlert.notification,
                );
              },
            );
            if (reg ?? false) {
              if (!mounted) return;
              final auth = await localStorageService
                  .biometricsValidate()
                  .onError((error, stackTrace) => false);
              if (auth) {
                await localStorageService.registerBiometrics();
              }
            }
          }
          return _onFABTapped();
        }
      }
    } else {
      // return StockOrderISheet(widget.stockModel).showSheet(context, );
      StockOrderISheet(widget.stockModel).show(
          context,
          StockOrderSheet(
            stockModel: widget.stockModel,
            orderData: null,
          ));
    }
  }

  bool isChart = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: StockDetailAppbar(
          stockModel: widget.stockModel,
          onTap: () {
            setState(() {
              isChart = !isChart;
            });
          },
          isChart: isChart),
      // appBar: StockDetailAppbar(stock: widget.stockModel.stock),
      body: isChart
          ? TechnicalAnalysis(stockCode: widget.stockModel.stock.stockCode)
          : Column(children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StockDetailOverview(stockModel: widget.stockModel),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: DefaultTabController(
                  length: DetailTab.values.length,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          isScrollable: true,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.text_black_1),
                          unselectedLabelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.neutral_02),
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 6),
                          padding: EdgeInsets.zero,
                          // indicatorSize: TabBarIndicatorSize.label,
                          tabs: DetailTab.values
                              .map((e) => Text(e.getName(context)))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(children: [
                          OverviewTab(stockModel: widget.stockModel),
                          TransactionTab(stockModel: widget.stockModel),
                          // TechnicalAnalysis(
                          //     stockCode: widget.stockModel.stock.stockCode),
                          FinanceIndexTab(stockModel: widget.stockModel),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ]),
      backgroundColor:
          themeMode.isLight ? AppColors.bg_1 : AppColors.neutral_01,
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            onTap: _onFABTapped,
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.primary_01,
              ),
              child: SvgPicture.asset(
                AppImages.arrange_circle,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
