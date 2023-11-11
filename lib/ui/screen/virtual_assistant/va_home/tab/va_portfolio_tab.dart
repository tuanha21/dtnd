import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_home/va_controller.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/market/stock_model.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../../utilities/responsive.dart';
import '../../../../../utilities/validator.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../../widget/icon/sheet_header.dart';
import '../../../../widget/input/interval_input.dart';
import '../../../../widget/input/thousand_separator_input_formatter.dart';
import '../../../home/home_controller.dart';
import '../../../stock_detail/sheet/info_sheet.dart';
import '../../../stock_detail/sheet/list_bot_sheet.dart';
import '../../interval_input_custom2.dart';
import '../../va_filter/virtual_assistant_filter_screen.dart';
import '../component/va_portfolio_component.dart';

class VAPortfolioTab extends StatefulWidget {
  const VAPortfolioTab({super.key});

  @override
  State<VAPortfolioTab> createState() => _VAPortfolioTabState();
}

class _VAPortfolioTabState extends State<VAPortfolioTab> with AppValidator {
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();
  final IDataCenterService dataCenterService = DataCenterService();
  final HomeController homeController = HomeController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();

  final VAController controller = VAController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ObxValue<Rx<bool>>((initialized) {
          return Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      !initialized.value
                          ? "${S.of(context).following_catalog} (0/15)"
                          : "${S.of(context).following_catalog} (${controller.vaPortfolio.value.listStocks.length}/15)",
                      style: AppTextStyle.titleMedium_16
                          .copyWith(color: AppColors.neu_01),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: setting,
                      child: SizedBox.square(
                        dimension: 25,
                        child: SvgPicture.asset(AppImages.icon_setting),
                      ),
                    ),
                  ],
                ),
              ),
              if (!initialized.value)
                Container()
              else
                Visibility(
                  visible: controller.vaPortfolio.value.listStocks.length < 15,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ))
                              .then((value) async {
                            if (value is Stock) {
                              return controller.addStockToPortfolio(value);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Ink(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.neutral_06),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.add_square,
                                color: AppColors.primary_01,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                S.of(context).add_stock,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: AppColors.primary_01,
                                        fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (!initialized.value)
                Column(
                  children: [
                    const SizedBox(height: 180),
                    SizedBox(
                      height: Responsive.getMaxWidth(context) / 3,
                      child: Column(
                        children: [
                          const Text(
                            'Danh mục chưa có dữ liệu',
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            child: Text(
                              S.of(context).filter_stock,
                              style: const TextStyle(
                                  color: AppColors.semantic_01, fontSize: 15),
                            ),
                            onTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssistantStockFilterScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else if (controller.vaPortfolio.value.listStocks.isEmpty)
                Column(
                  children: [
                    const SizedBox(height: 180),
                    SizedBox(
                      height: Responsive.getMaxWidth(context) / 3,
                      child: Column(
                        children: [
                          const Text(
                            'Danh mục chưa có dữ liệu',
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            child: Text(
                              S.of(context).filter_stock,
                              style: const TextStyle(
                                  color: AppColors.semantic_01, fontSize: 15),
                            ),
                            onTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssistantStockFilterScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Obx(() {
                  return Column(
                    children: [
                      for (int i = 0;
                          i < (controller.vaPortfolio.value.listStocks.length);
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: SizedBox(
                            height: 72,
                            child: Obx(() {
                              final StockModel? stockModel;
                              if (i >
                                  controller.listStockModels.value.length - 1) {
                                stockModel = null;
                              } else {
                                stockModel = controller.listStockModels.value
                                    .elementAt(i);
                              }
                              return VAPortfolioComponent(
                                stockModel: stockModel,
                                item: controller.vaPortfolio.value.listStocks
                                    .elementAt(i),
                              );
                            }),
                          ),
                        ),
                    ],
                  );
                }),
              const SizedBox(
                height: 120,
              ),
            ],
          );
        }, controller.portfolioInitialized),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 56,
          child: AsyncButton(
              onPressed: userService.createBot,
              child: Text(
                S.of(context).Start,
                style: AppTextStyle.textButtonTextStyle
                    .copyWith(color: AppColors.neutral_05),
              )),
        ),
      ),
    );
  }

  void setting() {
    const InfoISheet().show(
      context,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetHeader(
                title: 'Cài đặt thiết lập danh mục',
                implementBackButton: false,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(S.of(context).Your_portfolio),
              const SizedBox(
                height: 16,
              ),
              Text(S.of(context).Maximum_risk),
              const SizedBox(
                height: 16,
              ),
              IntervalInputCustom2(
                controller: priceController,
                labelText: S.of(context).Maximum_risk,
                defaultValue: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tỷ lệ chốt cắt lỗ',
                    style: AppTextStyle.labelMedium_12,
                  ),
                  InkWell(
                    child: SvgPicture.asset(AppImages.icon_setting_va),
                    onTap: () {
                      const ListBotSheet().show(
                        context,
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SheetHeader(
                                  title: S.of(context).Bot_list,
                                  implementBackButton: true,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IntervalInput(
                      controller: priceController,
                      labelText: S.of(context).price,
                      interval: (value) => 0.1,
                      defaultValue: 0,
                      // onChanged: onChangedPrice,
                      // onTextChanged: _onPriceChangeHandler,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Material(
                      child: TextFormField(
                        controller: priceController,
                        validator: (value) => '',
                        // onChanged: ()=>{},
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [ThousandsSeparatorInputFormatter()],
                        decoration: InputDecoration(
                          labelText: 'Bán khi giá',
                          contentPadding: const EdgeInsets.only(left: 50),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(18),
                            child: SvgPicture.asset(
                                AppImages.icon_greater_than_or_equal_to),
                            // SvgPicture.asset(
                            //     AppImages.icon_downt),
                            // SvgPicture.asset(
                            //     AppImages.icon_line),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppImages.icon_percent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(S.of(context).volumn),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        labelText: 'Khối lượng cố định',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: IntervalInputCustom2(
                      controller: volumeController,
                      labelText: 'Khối lượng theo tỷ lệ',
                      validator: volumnValidator,
                      // onChanged: onChangeVol,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.color_secondary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Lưu',
                    style: AppTextStyle.textButtonTextStyle
                        .copyWith(color: AppColors.neutral_05),
                  ),
                ),
                onTap: () {
                  // Click để lưu
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
