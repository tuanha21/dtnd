import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../widget/overlay/custom_dialog.dart';

class NotSigninCatalogWidget extends StatelessWidget {
  const NotSigninCatalogWidget({
    super.key,
    this.afterLogin,
    required this.localStorageService,
  });

  final VoidCallback? afterLogin;
  final ILocalStorageService localStorageService;

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ))
        .then((result) async {
      if ((result ?? false)) {
        afterLogin?.call();

        if (!localStorageService.biometricsRegistered) {
          final reg = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomDialog(
                textButtonAction: S.of(context).ok,
                textButtonExit: S.of(context).Later,
                title: S.of(context).biometric_authentication,
                content:
                    S.of(context).login_with_biometric,
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
        }
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => _onTap.call(context),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 300,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 200,
                    child: Image.asset(AppImages.scene),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).you_are_not_logged_in,
                    style: textTheme.labelLarge,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      S.of(context).login_to_continue,
                      textAlign: TextAlign.center,
                      // style: textTheme.labelLarge,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
