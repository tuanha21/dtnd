import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/=models=/response/account/base_normal_account_model.dart';
import 'package:dtnd/=models=/response/account/unknown_account_model.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';

class AccountUtil {
  static Type getAccountType(String accountCode) {
    final String lastCode = accountCode[accountCode.length - 1];
    switch (lastCode) {
      case "1":
        return BaseNormalAccountModel;
      case "6":
        return BaseMarginAccountModel;
      default:
        return UnknownAccountModel;
    }
  }

  static void logout(BuildContext context) {
    final IUserService userService = UserService();
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomDialog(
          textButtonAction: 'Đồng ý',
          textButtonExit: 'Để sau',
          title: 'Xác nhận',
          content: 'Bạn có chắc chắn muốn dùng tài khoản khác?',
          action: () => Navigator.of(context).pop(true),
          type: TypeAlert.notification,
        );
      },
    ).then((change) {
      if (change ?? false) {
        userService.deleteToken();
        Navigator.of(homeBaseKey.currentContext!).push<bool>(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        return;
      }
    });
    return;
  }

  static void validateSession(BuildContext context,
      {void Function()? nextFunction}) async {
    final IUserService userService = UserService();
    final ILocalStorageService localStorageService = LocalStorageService();
    if (!userService.isLogin) {
      showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      ).then((toLogin) {
        if (toLogin ?? false) {
          Navigator.of(context)
              .push<bool>(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ))
              .then((result) {
            if ((result ?? false)) {
              if (!localStorageService.biometricsRegistered &&
                  localStorageService.isDeviceSupport) {
                showDialog<bool>(
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
                      type: TypeAlert.notification,
                    );
                  },
                ).then((reg) {
                  if (reg ?? false) {
                    localStorageService.biometricsValidate().then((auth) {
                      if (auth) {
                        localStorageService.registerBiometrics();
                      }
                    }).onError((error, stackTrace) => null);
                  }
                });
              }
              return validateSession(context, nextFunction: nextFunction);
            }
          });
        }
      });
      return;
    } else {
      return nextFunction?.call();
    }
  }
}
