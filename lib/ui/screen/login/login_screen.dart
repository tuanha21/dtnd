import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/screen/login/login_controller.dart';
import 'package:dtnd/ui/screen/login/widget/login_form.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
  final Rx<bool> canCheckLogin = Rx<bool>(false);
  bool invalidUsername = false;
  bool invalidPassword = false;

  @override
  void initState() {
    super.initState();
  }

  String? usernameValidator(String? value) {
    if ((value?.length ?? 0) < 6) {
      return S.of(context).null_username;
    }
    if (invalidUsername) {
      setState(() {
        invalidUsername = false;
      });
      return S.of(context).invalid_account;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if ((value?.length ?? 0) < 8) {
      return S.of(context).null_password;
    }
    if (invalidPassword) {
      setState(() {
        invalidPassword = false;
      });
      return S.of(context).wrong_password;
    }
    if (invalidUsername) {
      setState(() {
        invalidUsername = false;
      });
      return S.of(context).invalid_account;
    }
    return null;
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
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: S.of(context).login_qoute1,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextSpan(
                          text: "DTND",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(
                  loginFormKey: loginFormKey,
                  usernameFormKey: usernameFormKey,
                  passwordFormKey: passwordFormKey,
                  usernameValidator: usernameValidator,
                  passwordValidator: passwordValidator,
                  otpRequired: loginController.otpRequired,
                  canCheckLogin: canCheckLogin,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                          // ObxValue<Rx<bool>>(
                          //   (value) {
                          //     return TextButton(
                          //       // onPressed: value.value
                          //       //     ? () => loginController.login(
                          //       //         usernameFormKey.currentState!.value!,
                          //       //         passwordFormKey.currentState!.value!)
                          //       //     : null,
                          //       onPressed: () {
                          //         GoRouter.of(context).go('/');
                          //       },
                          //       child: const Text("Login"),
                          //     );
                          //   },
                          //   canCheckLogin,
                          // ),
                          TextButton(
                        // onPressed: value.value
                        //     ? () => loginController.login(
                        //         usernameFormKey.currentState!.value!,
                        //         passwordFormKey.currentState!.value!)
                        //     : null,
                        onPressed: () {
                          GoRouter.of(context).go('/');
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox.square(
                      dimension: 40,
                      child: SvgPicture.asset(AppImages.login_face_id_icon),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => AppService().switchTheme(),
                  child: const Text("ChangeTheme"),
                ),

                // TextButton(
                //   onPressed: () {
                //     appService.switchLanguage();
                //   },
                //   child: const Text("Change Language"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
