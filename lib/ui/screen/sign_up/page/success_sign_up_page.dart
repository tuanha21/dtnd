import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_image.dart';
import '../../../theme/app_textstyle.dart';
import '../../home_base/home_base.dart';
import '../../login/login_screen.dart';

class SuccessSignUpPage extends StatelessWidget {
  const SuccessSignUpPage({Key? key}) : super(key: key);

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
                                S.of(context).info_sent_to_email,
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
                                        GoRoute(
                                          path: '/Home',
                                          name: "home",
                                          builder: (BuildContext context,
                                              GoRouterState state) {
                                            return const HomeBase();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        GoRoute(
                                          path: '/SignIn',
                                          builder: (BuildContext context,
                                              GoRouterState state) {
                                            return const LoginScreen();
                                          },
                                        );
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
