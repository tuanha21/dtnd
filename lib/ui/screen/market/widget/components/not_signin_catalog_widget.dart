import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class NotSigninCatalogWidget extends StatelessWidget {
  const NotSigninCatalogWidget({
    super.key,
    this.afterLogin,
  });
  final VoidCallback? afterLogin;

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ))
        .then((value) => afterLogin?.call());
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
