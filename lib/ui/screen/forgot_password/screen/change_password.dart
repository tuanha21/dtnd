import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/forgot_password/%20widget/success_reset_password.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.accountInfo});

  final CheckAccountSuccessDataModel accountInfo;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool isValid = true;
  bool condition1 = false;
  bool condition2 = false;
  bool condition3 = false;
  bool condition4 = false;
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;
  String? _errorReset;
  final IUserService userService = UserService();

  Timer? _timer;

  void _onPasswordTyping() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 50), () {
      setState(() {
        isValid = condition1 && condition2 && condition3 && condition4;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordTyping);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordTyping);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 45, left: 16, right: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              S.of(context).reset_password,
              style: AppTextStyle.headlineSmall_24
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).title_change_password,
              style: AppTextStyle.titleSmall_14
                  .copyWith(color: AppColors.neutral_02),
            ),
            const SizedBox(height: 36),
            formChangePass(context)
          ]),
        ));
  }

  Form formChangePass(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              labelText: S.of(context).hint_password,
              hintText: S.of(context).hint_password,
              suffixIcon: IconButton(
                icon: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.text_black_1,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validatePassword,
            onSaved: (value) {
              // _name = value;
            },
          ),
          !(isValid) ? _showCodition(context) : Container(),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: _rePasswordVisible,
            controller: _rePasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  !_rePasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.text_black_1,
                ),
                onPressed: () {
                  setState(() {
                    _rePasswordVisible = !_rePasswordVisible;
                  });
                },
              ),
              hintText: S.of(context).hint_re_password,
              labelText: S.of(context).hint_re_password,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validate_null_repassword;
              } else if (value != _passwordController.text) {
                return S.of(context).validate_same_repassword;
              }
              return null;
            },
            onSaved: (value) {},
          ),
          ExpandedSection(
              expand: _errorReset != null,
              child: Row(
                children: [
                  Text(
                    _errorReset ?? "",
                    style: AppTextStyle.bodySmall_12
                        .copyWith(color: AppColors.semantic_03),
                  )
                ],
              )),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: AsyncButton(
              onPressed: onChangePass,
              child: Text(
                S.of(context).save_password,
                style: AppTextStyle.bodyMedium_14.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.neutral_07),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onChangePass() async {
    setState(() {
      _errorReset = null;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      List<int> inputPass = utf8.encode(_passwordController.text);
      Digest md5Hash = md5.convert(inputPass);
      String passCode = md5Hash.toString().toUpperCase();

      final result = await userService.resetPassword(
          widget.accountInfo.cCARDID!,
          widget.accountInfo.cCUSTMOBILE!,
          widget.accountInfo.cCUSTEMAIL!,
          passCode);
      if (result) {
        if (!mounted) {
          return;
        }
        return showDialog(
          context: context,
          builder: (context) {
            return SuccessResetPasswordPage(
              idResetUser: widget.accountInfo.cCARDID ?? '000001',
            );
          },
        );
      } else {
        setState(() {
          _errorReset = S.of(context).something_went_wrong;
        });
      }
    }
    return;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      condition1 = false;
      condition2 = false;
      condition3 = false;
      condition4 = false;
      return '';
    }
    (value.length < 8 || value.length > 16)
        ? condition1 = false
        : condition1 = true;

    (!value.contains(RegExp(r'[A-Z]')))
        ? condition2 = false
        : condition2 = true;

    (!value.contains(RegExp(r'[0-9]')))
        ? condition3 = false
        : condition3 = true;

    (!value.contains(RegExp(r'[!@#\$&*~]')))
        ? condition4 = false
        : condition4 = true;

    if (condition1 && condition2 && condition3 && condition4) {
      return null;
    }
    return '';
  }

  Widget getIcon(bool condition) {
    Widget child;
    if (condition) {
      child = Image.asset(
        AppImages.validate_check,
        height: 20,
        width: 20,
      );
    } else {
      child = Image.asset(
        AppImages.validate_fail,
        height: 20,
        width: 20,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: child,
    );
  }

  Widget _showCodition(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            getIcon(condition1),
            Text(
              S.of(context).condition_password1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition2),
            Text(
              S.of(context).condition_password2,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition3),
            Text(
              S.of(context).condition_password3,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition4),
            Text(S.of(context).condition_password4,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral_03)),
          ],
        ),
      ],
    );
  }
}
