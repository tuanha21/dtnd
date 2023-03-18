import 'dart:async';

import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/login/login_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:dtnd/ui/widget/overlay/error_dialog.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_image.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.loginFormKey,
    required this.otpRequired,
    required this.onSuccess,
    this.userController,
    this.passController,
  }) : super(key: key);

  final GlobalKey<FormState> loginFormKey;
  final void Function(UserToken) onSuccess;
  final Rx<bool> otpRequired;
  final TextEditingController? userController;
  final TextEditingController? passController;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginController loginController = LoginController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late final TextEditingController _userController;
  late final TextEditingController _passController;

  final GlobalKey<FormFieldState<String?>> usernameFormKey =
      GlobalKey<FormFieldState<String?>>();
  final GlobalKey<FormFieldState<String?>> passwordFormKey =
      GlobalKey<FormFieldState<String?>>();
  final GlobalKey<FormFieldState<String?>>? otpFormKey =
      GlobalKey<FormFieldState<String?>>();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  Timer? onUsernameStoppedTyping;
  Timer? onPasswordStoppedTyping;
  bool hasChanged = false;
  bool showPass = false;

  bool typingUsername = false;
  bool typingPassword = false;
  String? userNameInitialValue;
  FutureVoidCallback? login;

  bool canCheckLogin = false;

  @override
  void initState() {
    _userController = widget.userController ?? TextEditingController();
    _passController = widget.passController ?? TextEditingController();
    userNameInitialValue = _userController.text;
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _userController.addListener(() {
    //     usernameFormKey.currentState!.didChange(_userController.text);
    //   });
    //   _passController.addListener(() {
    //     passwordFormKey.currentState!.didChange(_passController.text);
    //   });
    // });
  }

  void _onUsernameChangeHandler(
      FormFieldState<String?> usernameState, String value) {
    usernameState.didChange(value);
    if (onUsernameStoppedTyping != null) {
      setState(() {
        typingUsername = true;
      }); // clear timer
      onUsernameStoppedTyping!.cancel();
    }
    setState(
      () => onUsernameStoppedTyping = Timer(TimeUtilities.typingDelay, () {
        typingUsername = false;
        usernameState.validate();
        checkValidate();
      }),
    );
  }

  void _onPasswordChangeHandler(
      FormFieldState<String?> passwordState, String value) {
    passwordState.didChange(value);
    if (onPasswordStoppedTyping != null) {
      setState(() {
        typingPassword = true;
        onPasswordStoppedTyping!.cancel();
      }); // clear timer
    }
    setState(
      () => onPasswordStoppedTyping = Timer(TimeUtilities.typingDelay, () {
        typingPassword = false;
        passwordState.validate();
        checkValidate();
      }),
    );
  }

  String? usernameValidator(String? value) {
    if ((value?.length ?? 0) < 6) {
      return S.of(context).null_username;
    }
    if (loginController.invalidAccount.value) {
      loginController.invalidAccount.value = false;
      return S.of(context).invalid_account;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if ((value?.length ?? 0) < 6) {
      return S.of(context).null_password;
    }
    if (loginController.invalidPassword.value) {
      loginController.invalidPassword.value = false;
      return S.of(context).wrong_password;
    }
    if (loginController.invalidAccount.value) {
      loginController.invalidAccount.value = false;
      return S.of(context).invalid_account;
    }
    return null;
  }

  void checkValidate() {
    setState(() {
      if (usernameHasError || passwordHasError) {
        if (login == null) {
          return;
        }
        login = null;
      } else {
        login = checkLogin;
      }
    });
  }

  bool get usernameHasError =>
      (usernameFormKey.currentState?.hasError ?? true) && !typingUsername;

  bool get passwordHasError =>
      (passwordFormKey.currentState?.hasError ?? true) && !typingPassword;

  @override
  Widget build(BuildContext context) {
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Form(
      key: widget.loginFormKey,
      child: Column(
        children: [
          FormField<String?>(
            key: usernameFormKey,
            validator: usernameValidator,
            initialValue: userNameInitialValue,
            builder: (usernameState) => TextField(
              autocorrect: false,
              focusNode: usernameFocusNode,
              controller: _userController,
              onChanged: (value) =>
                  _onUsernameChangeHandler(usernameState, value),
              decoration: InputDecoration(
                labelText: S.of(context).username,
                hintText: S.of(context).username,
                errorText: usernameHasError
                    ? usernameFormKey.currentState?.errorText
                    : null,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FormField<String?>(
            key: passwordFormKey,
            validator: passwordValidator,
            builder: (passwordState) => TextField(
              obscureText: !showPass,
              autocorrect: false,
              focusNode: passwordFocusNode,
              controller: _passController,
              onChanged: (value) =>
                  _onPasswordChangeHandler(passwordState, value),
              decoration: InputDecoration(
                labelText: S.of(context).password,
                hintText: S.of(context).password,
                errorText: passwordHasError
                    ? passwordFormKey.currentState?.errorText
                    : null,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  child: Icon(showPass
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
            ),
          ),
          // ObxValue<Rx<bool>>((otpRequired) {
          //   if (!otpRequired.value) {
          //     return Container();
          //   }
          //   return FormField<String?>(
          //     key: widget.otpFormKey,
          //     validator: widget.otpValidator,
          //     builder: (otpFieldState) {
          //       return TextFormField(
          //         controller: _passController,
          //         onChanged: (otp) =>
          //             _onChangeHandler(otpFieldState, null, otp, null),
          //         decoration: InputDecoration(
          //           labelText: "OTP",
          //           hintText: S.of(context).fill_OTP,
          //         ),
          //       );
          //     },
          //   );
          // }, widget.otpRequired),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: AsyncButton(
                    onPressed: login,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Text(S.of(context).login),
                  ),
                ),
                // const SizedBox(
                //   width: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     context.pushNamed("ekyc");
                //   },
                //   child: SizedBox.square(
                //     child: SvgPicture.asset(AppImages.login_face_id_icon),
                //   ),
                // ),
              ],
            ),
          ),
          // const SizedBox(height: 16),
          // socialButton(AppImages.google, S.of(context).login_with_google),
          // const SizedBox(height: 16),
          // socialButton(AppImages.facebook, S.of(context).login_with_facebook),
          const SizedBox(height: 50),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '${S.of(context).you_are_not_account} ',
                style: titleSmall?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.neutral_04)),
            TextSpan(
                text: S.of(context).sign_up,
                style: titleSmall?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.primary_01),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    GoRouter.of(context).push('/SignUp');
                  })
          ]))
        ],
      ),
    );
  }

  Widget socialButton(String icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.primary_01),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();

    if (widget.loginFormKey.currentState!.validate()) {
      late final UserToken? userToken;
      try {
        userToken = await loginController.login(
            usernameFormKey.currentState!.value!,
            passwordFormKey.currentState!.value!);
      } catch (e) {
        userToken = null;
        logger.e(e);
        if (mounted) {
          return await showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                title: S.of(context).login_falied,
                content: e.toString(),
              );
            },
          );
        }
      }
      widget.onSuccess.call(userToken!);
    }
  }
}
