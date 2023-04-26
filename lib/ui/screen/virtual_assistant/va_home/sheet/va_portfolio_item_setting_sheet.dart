import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/sheet/list_bot_sheet.dart';
import 'package:dtnd/ui/screen/virtual_assistant/interval_input_custom2.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/ui/widget/input/interval_input.dart';
import 'package:dtnd/ui/widget/input/thousand_separator_input_formatter.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VAPortfolioItemSettingSheet extends StatefulWidget {
  const VAPortfolioItemSettingSheet({super.key, required this.item});
  final VAPortfolioItem item;
  @override
  State<VAPortfolioItemSettingSheet> createState() =>
      _VAPortfolioItemSettingSheetState();
}

class _VAPortfolioItemSettingSheetState
    extends State<VAPortfolioItemSettingSheet> with AppValidator {
  final TextEditingController riskController = TextEditingController();
  final TextEditingController priceSellController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController volumePcController = TextEditingController();
  @override
  void initState() {
    super.initState();
    riskController.text = widget.item.setting.rrMax.toString();
    priceSellController.text = widget.item.setting.sell.toString();
    priceController.text = widget.item.setting.buy.toString();
    volumeController.text = widget.item.setting.volumeFix.toString();
    volumePcController.text = widget.item.setting.volumePercent.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              controller: riskController,
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
                            children:   [
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
                      controller: priceSellController,
                      validator: (value) => '',
                      // onChanged: ()=>{},
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                    controller: volumeController,
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
                    controller: volumePcController,
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
                widget.item.setting.rrMax =
                    num.tryParse(riskController.text) ?? 0;
                widget.item.setting.sell =
                    num.tryParse(priceSellController.text) ?? 0;
                widget.item.setting.buy =
                    num.tryParse(priceController.text) ?? 0;
                widget.item.setting.volumeFix =
                    num.tryParse(volumeController.text) ?? 0;
                widget.item.setting.volumePercent =
                    num.tryParse(volumePcController.text) ?? 0;
                widget.item.save();
              },
            )
          ],
        ),
      ),
    );
  }
}
