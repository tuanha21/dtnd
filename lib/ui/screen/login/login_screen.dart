import 'package:dtnd/ui/screen/login/login_controller.dart';
import 'package:dtnd/ui/screen/login/widget/login_form.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = LoginController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String?>> usernameFormKey =
      GlobalKey<FormFieldState<String?>>();

  final GlobalKey<FormFieldState<String?>> passwordFormKey =
      GlobalKey<FormFieldState<String?>>();

  void loginSuccess() {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    if (navigator != null && navigator.canPop()) {
      return navigator.pop(true);
    }
    context.go("/");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).hello,
                      style: AppTextStyle.headlineSmall_24
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: S.of(context).login_qoute1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: "DTND",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.primary_01,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          TextSpan(
                            text: S.of(context).login_qoute2,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(
                  loginFormKey: loginFormKey,
                  otpRequired: loginController.otpRequired,
                  onSuccess: loginSuccess,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
