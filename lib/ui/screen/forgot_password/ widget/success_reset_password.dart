import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class SuccessResetPasswordPage extends StatelessWidget {
  const SuccessResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Container(
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
                            SizedBox.square(
                                dimension: 200,
                                child: Image.asset(AppImages.illust04)),
                            const SizedBox(height: 8),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                S.of(context).success_reset_password,
                                style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.text_grey_1),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: AppColors.light_tabBar_bg,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                            S.of(context).return_home_page,
                                            style: AppTextStyle.bodyMedium_14
                                                .copyWith(
                                                    color:
                                                        AppColors.linear_01)),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .popUntil((r) => r.isFirst);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                            (r) => r.isFirst);
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: AppColors.linear_01,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          S.of(context).login,
                                          style: AppTextStyle.bodyMedium_14
                                              .copyWith(
                                                  color: AppColors.neutral_07),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
