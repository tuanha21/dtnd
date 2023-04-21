import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/account_screen_view.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final IUserService userService = UserService();
  final ILocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    final isLogin = userService.isLogin;
    final textTheme = Theme.of(context).textTheme;
    Widget accountView;
    if (!isLogin) {
      accountView = Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox.square(
                  dimension: 200, child: Image.asset(AppImages.illust09)),
              Text(
                S.of(context).you_are_not_logged_in,
                style:
                    textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  S.of(context).account_not_login_sentence,
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              SingleColorTextButton(
                  onTap: () {
                    Navigator.of(context)
                        .push<bool>(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    )
                        .then((login) async {
                      setState(() {});
                      if ((login ?? false) &&
                          !localStorageService.biometricsRegistered) {
                        final reg = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              textButtonAction: S.of(context).ok,
                              textButtonExit: S.of(context).Later,
                              title: S.of(context).biometric_authentication,
                              content: S.of(context).login_with_biometric,
                              action: () {
                                Navigator.of(context).pop();
                              },
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
                    });
                    return;
                  },
                  text: S.of(context).login,
                  color: AppColors.primary_01)
            ],
          ),
        ),
      );
    } else {
      accountView = AccountScreenView(
        userService: userService,
        onLogOut: () async {
          await userService.deleteToken();
          if (mounted) {}
          setState(() {});
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ))
              .then((login) async {
            setState(() {});
            if ((login ?? false) && !localStorageService.biometricsRegistered) {
              final reg = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return CustomDialog(
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
          });
          return;
        },
      );
    }
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                AccountIcon.bg,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 160,
              decoration: const BoxDecoration(
                  color: AppColors.bg_1,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Expanded(child: accountView),
                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Icon(
                Icons.account_circle_outlined,
                color: AppColors.neutral_03,
                size: 72,
              ),
            ),
          )
        ],
      ),
    );
  }
}
