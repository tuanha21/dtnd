import 'dart:async';

import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/forgot_password/forgot_password.dart';
import 'package:dtnd/ui/screen/login/login_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_image.dart';
import '../../../widget/overlay/custom_dialog.dart';

class NotFirstLoginForm extends StatefulWidget {
  const NotFirstLoginForm({
    Key? key,
    required this.loginFormKey,
    required this.otpRequired,
    required this.onSuccess,
    this.userController,
    this.passController,
    this.onBack,
  }) : super(key: key);

  final GlobalKey<FormState> loginFormKey;
  final void Function(UserToken) onSuccess;
  final Rx<bool> otpRequired;
  final TextEditingController? userController;
  final TextEditingController? passController;
  final VoidCallback? onBack;

  @override
  State<NotFirstLoginForm> createState() => _NotFirstLoginFormState();
}

class _NotFirstLoginFormState extends State<NotFirstLoginForm> {
  final LoginController loginController = LoginController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late final TextEditingController _userController;
  late final TextEditingController _passController;

  final GlobalKey<FormFieldState<String?>> passwordFormKey =
      GlobalKey<FormFieldState<String?>>();
  final GlobalKey<FormFieldState<String?>>? otpFormKey =
      GlobalKey<FormFieldState<String?>>();

  final FocusNode passwordFocusNode = FocusNode();

  Timer? onUsernameStoppedTyping;
  Timer? onPasswordStoppedTyping;
  bool showPass = false;
  bool hasChanged = false;
  bool typingUsername = false;
  bool typingPassword = false;
  String? userNameInitialValue;
  Future<void> Function()? login;

  bool canCheckLogin = false;

  String? errorMsg;

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
        setState(() {
          errorMsg = null;
        });
        checkValidate();
      }),
    );
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
      if (passwordHasError) {
        login = null;
      } else {
        login = checkLogin;
      }
    });
  }

  bool get passwordHasError =>
      (passwordFormKey.currentState?.hasError ?? true) && !typingPassword;

  @override
  Widget build(BuildContext context) {
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Form(
      key: widget.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          const SizedBox(height: 10),
          ExpandedSection(
              expand: errorMsg != null,
              child: Text(
                errorMsg ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.semantic_03),
              )),
          // const SizedBox(height: 10),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                  );
                },
                child: Text(
                  S.of(context).forgot_password,
                  style: titleSmall?.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.primary_01),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

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
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: bioLogin,
                  child: SizedBox.square(
                    child: SvgPicture.asset(AppImages.login_face_id_icon),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () async {
              final change = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    textButtonAction: S.of(context).ok,
                    textButtonExit: S.of(context).later,
                    title: S.of(context).confirm,
                    content: S
                        .of(context)
                        .Are_you_sure_you_want_to_use_a_different_account,
                    action: () => Navigator.of(context).pop(true),
                    type: TypeAlert.notification,
                  );

                  //   AppDialog(
                  //   icon: const Icon(Icons.warning_amber_rounded),
                  //   title: const Text("Xác nhận"),
                  //   content: const Text(
                  //       "Bạn có chắc chắn muốn dùng tài khoản khác?"),
                  //   actions: [
                  //     Flexible(
                  //       child: InkWell(
                  //           onTap: () => Navigator.of(context).pop(false),
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             child: Text(S.of(context).cancel),
                  //           )),
                  //     ),
                  //     Flexible(
                  //       child: InkWell(
                  //           onTap: () => Navigator.of(context).pop(true),
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             decoration: const BoxDecoration(
                  //               border: Border(
                  //                 left: BorderSide(color: AppColors.neutral_05),
                  //               ),
                  //             ),
                  //             child: const Text("OK"),
                  //           )),
                  //     )
                  //   ],
                  // );
                },
              );
              if (change ?? false) {
                await loginController.changeAccount();
                widget.onBack?.call();
              }
            },
            child: Center(
              child: Text(
                S.of(context).login_with_another_account,
                style: titleSmall?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.primary_01),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkLogin() async {
    passwordFocusNode.unfocus();
    if (errorMsg != null) {
      setState(() {
        errorMsg = null;
      });
    }
    if (widget.loginFormKey.currentState!.validate()) {
      late final UserToken? userToken;
      try {
        userToken = await loginController.login(
            _userController.text, passwordFormKey.currentState!.value!);
      } catch (e) {
        userToken = null;
        logger.e(e);
        if (mounted) {
          setState(() {
            errorMsg = e.toString();
          });
          return;
          // return await showDialog(
          //   context: context,
          //   builder: (context) {
          //     return ErrorDialog(
          //       title: S.of(context).login_falied,
          //       content: e.toString(),
          //     );
          //   },
          // );
        }
      }
      widget.onSuccess.call(userToken!);
    }
  }

  Future<void> bioLogin() async {
    if (errorMsg != null) {
      setState(() {
        errorMsg = null;
      });
    }
    late final UserToken? userToken;
    try {
      userToken = await loginController.loginWithBio();
    } catch (e) {
      userToken = null;
      logger.e(e);
      if (mounted) {
        setState(() {
          errorMsg = e.toString();
        });
        return;
        // return await showDialog(
        //   context: context,
        //   builder: (context) {
        //     return ErrorDialog(
        //       title: S.of(context).login_falied,
        //       content: e.toString(),
        //     );
        //   },
        // );
      }
    }
    widget.onSuccess.call(userToken!);
  }
}
