import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/account_screen_view.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
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
    Widget accountView;
    if (!isLogin) {
      accountView = Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push<bool>(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ))
                        .then((login) async {
                      setState(() {});
                      if ((login ?? false) &&
                          !localStorageService.biometricsRegistered) {
                        final reg = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              textButtonAction: 'Đồng ý',
                              textButtonExit: 'Để sau',
                              title: 'Đăng nhập bằng sinh trắc học',
                              content:
                                  'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
                              action: () {
                                Navigator.of(context).pop();
                              },
                            );

                            //   AppDialog(
                            //   icon: const Icon(Icons.warning_amber_rounded),
                            //   title: const Text("Đăng nhập bằng sinh trắc học"),
                            //   content: const Text(
                            //       "Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?"),
                            //   actions: [
                            //     Flexible(
                            //       child: InkWell(
                            //           onTap: () =>
                            //               Navigator.of(context).pop(false),
                            //           child: Container(
                            //             alignment: Alignment.center,
                            //             child: Text(S.of(context).cancel),
                            //           )),
                            //     ),
                            //     Flexible(
                            //       child: InkWell(
                            //           onTap: () =>
                            //               Navigator.of(context).pop(true),
                            //           child: Container(
                            //             alignment: Alignment.center,
                            //             decoration: const BoxDecoration(
                            //               border: Border(
                            //                 left: BorderSide(
                            //                     color: AppColors.neutral_05),
                            //               ),
                            //             ),
                            //             child: const Text("OK"),
                            //           )),
                            //     )
                            //   ],
                            // );
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
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                  child: Text(S.of(context).login),
                ),
              ),
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
                    title: 'Đăng nhập bằng sinh trắc học',
                    content:
                        'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
                    action: () => Navigator.of(context).pop(true),
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
