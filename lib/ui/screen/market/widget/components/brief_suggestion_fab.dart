import 'package:dtnd/=models=/fake/brief_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/utilities/sign_in_utils.dart';
import 'package:flutter/material.dart';

class BriefSuggestionFAB extends StatefulWidget {
  const BriefSuggestionFAB({super.key, required this.data});
  final RecommendForMorningNews data;
  @override
  State<BriefSuggestionFAB> createState() => _BriefSuggestionFABState();
}

class _BriefSuggestionFABState extends State<BriefSuggestionFAB> {
  final IDataCenterService dataCenterService = DataCenterService();
  late final Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = {
      "securitiesCode": widget.data.securitiesCode!,
      "Vùng mua": "${widget.data.fromPrice} - ${widget.data.toPrice}",
      "Mục tiêu": "${widget.data.targetPrice}",
      "Cắt lỗ": "${widget.data.stopLossPrice}",
      "Kỳ vọng": "${widget.data.upsize} %",
    };
  }

  void toBuy() {
    dataCenterService
        .getStockModelFromStockCode(widget.data.securitiesCode!)
        .then((value) {
      if (value != null) {
        Navigator.of(context).pop(value);
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.accent_light_04),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: AppColors.semantic_01)),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColors.accent_light_01,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Text(
                          data['securitiesCode'],
                          style: AppTextStyle.titleSmall_14
                              .copyWith(color: AppColors.semantic_01),
                        )),
                    Text(
                      'Mua',
                      style: AppTextStyle.bodySmall_12,
                    ),
                  ],
                )),
                for (int i = 1; i < data.length; i++)
                  Expanded(
                      child: Column(
                    children: [
                      Text(data.keys.elementAt(i)),
                      Text(
                        data.values.elementAt(i),
                        style: AppTextStyle.bodyMedium_14
                            .copyWith(color: AppColors.semantic_01),
                      ),
                    ],
                  )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleColorTextButton(
            color: AppColors.semantic_01,
            text: 'Mua ngay',
            onTap: () async {
              final IUserService userService = UserService();
              final ILocalStorageService localStorageService =
                  LocalStorageService();
              if (!userService.isLogin) {
                SigniInUtils.login(context, localStorageService, toBuy);
              } else {
                toBuy();
                return;
              }
            },
          )
        ],
      ),
    );
  }
}
