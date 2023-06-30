import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:flutter/material.dart';

class SigniInUtils {
  static void login(
      BuildContext context, ILocalStorageService localStorageService,
      [VoidCallback? afterLogin]) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ))
        .then((result) async {
      if ((result ?? false)) {
        if (!localStorageService.biometricsRegistered &&
            localStorageService.isDeviceSupport) {
          final reg = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomDialog(
                textButtonAction: S.of(context).ok,
                textButtonExit: S.of(context).later,
                title: S.of(context).biometric_authentication,
                content: S.of(context).login_with_biometric,
                action: () => Navigator.of(context).pop(true),
                type: TypeAlert.notification,
              );
            },
          );
          if (reg ?? false) {
            final auth = await localStorageService
                .biometricsValidate()
                .onError((error, stackTrace) => false);
            if (auth) {
              await localStorageService.registerBiometrics();
            }
          }
          afterLogin?.call();
        }
        return;
      }
      return;
    });
    return;
  }
}
