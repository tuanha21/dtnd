import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_color.dart';
import '../../theme/app_image.dart';
import '../../theme/app_textstyle.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.action,
      this.textButtonExit,
      this.textButtonAction});

  final String? title;
  final String? content;
  final String? textButtonExit;
  final String? textButtonAction;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Stack(
        children: <Widget>[
          Container(
            width: mediaQueryData.size.width,
            padding: const EdgeInsets.only(
                top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Material(
              color: AppColors.light_bg,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            color: AppColors.light_bg,
                            child: Container(
                              padding: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          title ?? 'Tiêu đề',
                                          style: AppTextStyle.labelLarge_18
                                              .copyWith(
                                                  color: AppColors.neutral_01),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        content ?? 'Nội dung thông báo',
                                        style: AppTextStyle.bodyMedium_14
                                            .copyWith(
                                                color: AppColors.neutral_04),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Container(
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  color: AppColors.neutral_06,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                    textButtonExit ?? "Để sau",
                                                    style: AppTextStyle
                                                        .bodyMedium_14
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary_01)),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: InkWell(
                                              onTap: action,
                                              child: Container(
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  color: AppColors.primary_01,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  textButtonAction ??
                                                      "Xác nhận",
                                                  style: AppTextStyle
                                                      .bodyMedium_14
                                                      .copyWith(
                                                          color: AppColors
                                                              .neutral_07),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: mediaQueryData.size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: AppColors.primary_03,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SvgPicture.asset(AppImages.icon_alert)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}