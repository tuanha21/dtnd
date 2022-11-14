import 'dart:async';

import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.loginFormKey,
    required this.usernameFormKey,
    required this.passwordFormKey,
    this.otpFormKey,
    this.onUsernameChanged,
    this.onPasswordChanged,
    this.canCheckLogin,
    this.usernameValidator,
    this.passwordValidator,
    this.otpValidator,
    required this.otpRequired,
  }) : super(key: key);

  final GlobalKey<FormState> loginFormKey;
  final GlobalKey<FormFieldState<String?>> usernameFormKey;
  final GlobalKey<FormFieldState<String?>> passwordFormKey;
  final GlobalKey<FormFieldState<String?>>? otpFormKey;
  final OnTextFormFieldChanged? onUsernameChanged;
  final OnTextFormFieldChanged? onPasswordChanged;
  final Rx<bool>? canCheckLogin;
  final FormFieldValidator<String?>? usernameValidator;
  final FormFieldValidator<String?>? passwordValidator;
  final FormFieldValidator<String?>? otpValidator;
  final Rx<bool> otpRequired;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Timer? onUsernameStoppedTyping;
  Timer? onPasswordStoppedTyping;
  bool hasChanged = false;
  bool typingUsername = false;
  bool typingPassword = false;

  late String _initUsernameValue = "";
  late String _initPasswordValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userController.addListener(() {
        print(
            "widget.usernameFormKey.currentState ${widget.usernameFormKey.currentState}");
        widget.usernameFormKey.currentState!.didChange(_userController.text);
      });
      _passController.addListener(() {
        widget.passwordFormKey.currentState!.didChange(_passController.text);
      });
    });
  }

  void _onUsernameChangeHandler(String value) {
    // state?.didChange(value);
    const duration = Duration(milliseconds: 500);
    if (onUsernameStoppedTyping != null) {
      setState(() {
        typingUsername = true;
      }); // clear timer
      onUsernameStoppedTyping!.cancel();
    }
    setState(
      () => onUsernameStoppedTyping = Timer(duration, () {
        print(typingUsername);
        typingUsername = false;
        checkValidate();
        widget.usernameFormKey.currentState?.validate();
      }),
    );
  }

  void _onPasswordChangeHandler(String value) {
    // state?.didChange(value);
    const duration = Duration(milliseconds: 500);
    if (onPasswordStoppedTyping != null) {
      setState(() {
        typingPassword = true;
        onPasswordStoppedTyping!.cancel();
      }); // clear timer
    }
    setState(
      () => onPasswordStoppedTyping = Timer(duration, () {
        typingPassword = false;
        checkValidate();
        widget.passwordFormKey.currentState?.validate();
      }),
    );
  }

  void checkValidate() {
    print(widget.usernameFormKey.currentState?.value);
    if (usernameHasError || passwordHasError) {
      widget.canCheckLogin?.value = false;
    } else {
      widget.canCheckLogin?.value = true;
    }
  }

  bool get usernameHasError =>
      (widget.usernameFormKey.currentState?.hasError ?? false) &&
      !typingUsername;

  bool get passwordHasError =>
      (widget.passwordFormKey.currentState?.hasError ?? false) &&
      !typingPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.loginFormKey,
        child: Column(
          children: [
            FormField<String?>(
                key: widget.usernameFormKey,
                initialValue: _initUsernameValue,
                validator: widget.usernameValidator,
                builder: (state) => TextField(
                      controller: _userController,
                      onChanged: _onUsernameChangeHandler,
                      decoration: InputDecoration(
                        labelText: S.of(context).username,
                        hintText: S.of(context).username,
                        errorText: usernameHasError
                            ? widget.usernameFormKey.currentState?.errorText
                            : null,
                      ),
                    )),
            const SizedBox(
              height: 20,
            ),
            FormField<String?>(
              key: widget.passwordFormKey,
              initialValue: _initPasswordValue,
              validator: widget.passwordValidator,
              builder: (state) => TextField(
                controller: _passController,
                onChanged: _onPasswordChangeHandler,
                decoration: InputDecoration(
                  labelText: S.of(context).password,
                  hintText: S.of(context).password,
                  errorText: passwordHasError
                      ? widget.passwordFormKey.currentState?.errorText
                      : null,
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
          ],
        ));
  }
}
