import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/ui/screen/login/login_controller.dart';
import 'package:dtnd/ui/screen/login/widget/login_form.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/l10n.dart';
import 'widget/not_first_login_for.dart';

const String _userKey = "_userKey";
String _userNameKey(String user) => "_userName${user}Key";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.toSignup, this.codeResetUser})
      : super(key: key);
  final bool? toSignup;
  final String? codeResetUser;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ILocalStorageService localStorageService = LocalStorageService();
  final LoginController loginController = LoginController();

  final TextEditingController userTextEditingController =
      TextEditingController();
  late String? name;
  late bool firstTimeLogin;

  void loginSuccess(UserToken userToken) {
    localStorageService.sharedPreferences.setString(_userKey, userToken.user);
    localStorageService.sharedPreferences
        .setString(_userNameKey(userToken.user), userToken.name);
    // return Navigator.of(context).pop(true);
    final NavigatorState? navigator = Navigator.maybeOf(context);
    if (navigator != null && navigator.canPop()) {
      return navigator.pop(true);
    }
    context.go("/");
  }

  @override
  void initState() {
    init();
    super.initState();
    if (widget.codeResetUser != null) {
      userTextEditingController.text = widget.codeResetUser!;
    }
    if (widget.toSignup ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(milliseconds: 500), () {
          GoRouter.of(context).push('/SignUp');
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() {
    final savedUser = localStorageService.sharedPreferences.getString(_userKey);
    if (savedUser != null) {
      userTextEditingController.text = savedUser;
      name = localStorageService.sharedPreferences
          .getString(_userNameKey(savedUser));
      firstTimeLogin = false;
    } else {
      name = null;
      firstTimeLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget hi;
    Widget quote;
    Widget form;
    if (firstTimeLogin || (widget.toSignup ?? false)) {
      hi = Text(
        S.of(context).hello,
        overflow: TextOverflow.ellipsis,
        style:
            AppTextStyle.headlineSmall_24.copyWith(fontWeight: FontWeight.w700),
      );
      quote = Text.rich(
        TextSpan(children: [
          TextSpan(
            text: S.of(context).login_qoute1,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextSpan(
            text: "IFIS",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.primary_01,
                  fontWeight: FontWeight.w700,
                ),
          ),
          TextSpan(
            text: S.of(context).login_qoute2,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ]),
      );
      form = LoginForm(
        loginFormKey: loginController.loginFormKey,
        otpRequired: loginController.otpRequired,
        onSuccess: loginSuccess,
        userController: userTextEditingController,
      );
    } else {
      hi = Text(
        "${S.of(context).hi} $name!",
        overflow: TextOverflow.ellipsis,
        style:
            AppTextStyle.headlineSmall_24.copyWith(fontWeight: FontWeight.w700),
      );
      quote = Text(
        S.of(context).not_first_login_quote,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColors.neutral_02),
      );

      form = NotFirstLoginForm(
        loginFormKey: loginController.loginFormKey,
        otpRequired: loginController.otpRequired,
        onSuccess: loginSuccess,
        userController: userTextEditingController,
        onBack: () async {
          await localStorageService.sharedPreferences
              .remove(_userNameKey(_userKey));
          await localStorageService.sharedPreferences.remove(_userKey);
          init();

          setState(() {});
        },
      );
    }
    return LoginScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: hi),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: quote,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                form,
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
