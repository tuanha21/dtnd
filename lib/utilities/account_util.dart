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

import '../generated/l10n.dart';

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

  static void logout(BuildContext context, {VoidCallback? afterLogout}) {
    final IUserService userService = UserService();
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomDialog(
          textButtonAction: S.of(context).ok,
          textButtonExit: S.of(context).later,
          title: S.of(context).confirm,
          content:
              S.of(context).Are_you_sure_you_want_to_use_a_different_account,
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
        afterLogout?.call();
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
                      textButtonAction: S.of(context).ok,
                      textButtonExit: S.of(context).later,
                      title: S.of(context).biometric_authentication,
                      content: S.of(context).login_with_biometric,
                      action: () {
                        Navigator.of(context).pop(true);
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

  static void deleteAccount(BuildContext context,
      {VoidCallback? afterDeletion}) {
    final IUserService userService = UserService();
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomDialog(
          textButtonAction: S.of(context).ok,
          textButtonExit: S.of(context).cancel,
          title: S.of(context).confirm,
          content: S.of(context).are_you_sure_to_delete_this_account,
          action: () => Navigator.of(context).pop(true),
          type: TypeAlert.notification,
        );
      },
    ).then((change) async {
      if (change ?? false) {
        try {
          await userService.deleteAccount();
          userService.deleteToken();
          Navigator.of(homeBaseKey.currentContext!)
              .push<bool>(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
          afterDeletion?.call();
          return;
        } catch (e) {
          showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomDialog(
                textButtonAction: S.of(context).ok,
                textButtonExit: S.of(context).cancel,
                title: S.of(context).confirm,
                content: e.toString(),
                action: () => Navigator.of(context).pop(true),
                type: TypeAlert.delete,
              );
            },
          );
        }
      }
    });
    return;
  }
}
