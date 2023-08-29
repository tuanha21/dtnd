import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/screen/settlement_confirm.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

class SettlementDialog extends StatelessWidget {
  const SettlementDialog({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            bottom: mediaQueryData.viewInsets.bottom, left: 10, right: 10),
        child: Stack(
          children: <Widget>[
            Container(
              width: mediaQueryData.size.width,
              padding: const EdgeInsets.only(
                  top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                color: themeMode.isLight ? AppColors.light_bg : AppColors.neutral_01,
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
                              color: themeMode.isLight ? AppColors.light_bg : AppColors.neutral_01,
                              child: Container(
                                padding: EdgeInsets.zero,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            S.of(context).payment_confirmation,
                                            style: AppTextStyle.labelLarge_18
                                                .copyWith(
                                                    color:
                                                    themeMode.isLight ? AppColors.neutral_01 :AppColors.neutral_06),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                          S.of(context).are_you_sure_you_want_to_pay_off_early,
                                          style: AppTextStyle.bodyMedium_14
                                              .copyWith(
                                                  color: themeMode.isLight ? AppColors.neutral_04 : AppColors.neutral_06),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible: true,
                                              child: Expanded(
                                                child: InkWell(
                                                  child: Container(
                                                    height: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      color:
                                                          AppColors.neutral_06,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        S.of(context).later,
                                                        style: AppTextStyle
                                                            .bodyMedium_14
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary_01)),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SettlementConfirm(
                                                              id: id),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    color: AppColors.primary_01,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).confirm,
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
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 5),
                    child: Container(
                      alignment: Alignment.center,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 64,
                      child: Image.asset(
                        AppImages.tick_confirm,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
