import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulation_dialog.dart';
import 'package:dtnd/ui/screen/accumulation/widget/error_register_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class AccumulationAutoRegisterDialog extends StatefulWidget {
  const AccumulationAutoRegisterDialog({
    super.key,
    required this.isRegister,
  });

  final bool isRegister;

  @override
  State<AccumulationAutoRegisterDialog> createState() =>
      _AccumulationAutoRegisterDialogState();
}

class _AccumulationAutoRegisterDialogState
    extends State<AccumulationAutoRegisterDialog> {
  final IUserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
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
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.isRegister
                                                ? S
                                                    .of(context)
                                                    .confirm_cancellation
                                                : S
                                                    .of(context)
                                                    .confirm_registration,
                                            style: AppTextStyle.labelLarge_18
                                                .copyWith(
                                                    color:
                                                        AppColors.neutral_01),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                          widget.isRegister
                                              ? S.of(context).are_you_sure_you_want_to_unsubscribe_from_automatic_accrual_products
                                              : S.of(context).are_you_sure_you_want_to_sign_up_for_automatic_accrual_products,
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
                                                        Radius.circular(8),
                                                      ),
                                                      color:
                                                          AppColors.neutral_06,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).abort,
                                                      style: AppTextStyle
                                                          .bodyMedium_14
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary_01),
                                                    ),
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
                                                onTap: () async {
                                                  try {
                                                    await userService
                                                        .changeContractBase(
                                                            widget.isRegister
                                                                ? 0
                                                                : 1);
                                                    if (!mounted) return;
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (_) =>
                                                          AccumulationDialog(
                                                        content: widget
                                                                .isRegister
                                                            ? S.of(context).you_have_successfully_deleted_the_auto_registry
                                                            :S.of(context).you_have_completed_the_automatic_accrual_registration,
                                                        title: widget.isRegister
                                                            ? S
                                                                .of(context)
                                                                .successfully_canceled
                                                            : S
                                                                .of(context)
                                                                .successfully_registered,
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (_) =>
                                                          ErrorRegisterDialog(
                                                        error: S
                                                            .of(context)
                                                            .an_error_occurred,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
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
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    margin: const EdgeInsets.only(top: 5),
                    child: Container(
                      alignment: Alignment.center,
                      height: 64,
                      decoration: BoxDecoration(
                          color: AppColors.neutral_06,
                          borderRadius: BorderRadius.circular(12)),
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
