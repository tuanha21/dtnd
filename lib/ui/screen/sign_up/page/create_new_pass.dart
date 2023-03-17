import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../utilities/regex.dart';
import '../../../theme/app_color.dart';
import '../../../widget/input/app_text_field.dart';
import '../widget/state_validator.dart';

class CreateNewPassPage extends StatefulWidget {
  const CreateNewPassPage({Key? key}) : super(key: key);

  @override
  State<CreateNewPassPage> createState() => _CreateNewPassPageState();
}

class _CreateNewPassPageState extends State<CreateNewPassPage>
    with ValidatorPass, AppValidator {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  final ValueNotifier<bool> isPassLength8to16 = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isUpperCase = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPassMatchSpecial = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isHasNumberCharacter = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isValidatorPass = ValueNotifier<bool>(false);

  final confirmPass = GlobalKey<FormState>();

  final ValueNotifier<bool> isShowAction = ValueNotifier<bool>(false);

  void checkPass() {
    isValidatorPass.value = isPassLength8to16.value &&
        isUpperCase.value &&
        isHasNumberCharacter.value &&
        isPassMatchSpecial.value;
  }

  void checkShowAction() {
    isShowAction.value =
        confirmPass.currentState!.validate() && isValidatorPass.value;
  }

  @override
  void initState() {
    isPassLength8to16.addListener(checkPass);
    isUpperCase.addListener(checkPass);
    isPassMatchSpecial.addListener(checkPass);
    isHasNumberCharacter.addListener(checkPass);
    isValidatorPass.addListener(checkShowAction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tạo mật khẩu",
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: 'DTND',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary_01)),
                TextSpan(
                    text: ' bạn nhé',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
              ]),
            ),
            const SizedBox(height: 36),
            AppTextField(
              controller: passController,
              labelText: "Mật khẩu",
              obscureText: true,
              onChanged: (pass) {
                isPassLength8to16.value = passWordLength8to16(pass);
                isUpperCase.value = hasMinUpperCaseChar(pass, 1);
                isHasNumberCharacter.value = hasMinNumericChar(pass, 1);
                isPassMatchSpecial.value = checkPassMatchSpecial(pass);
              },
            ),
            ValueListenableBuilder<bool>(
                valueListenable: isValidatorPass,
                builder: (context, isValidator, child) {
                  return Visibility(
                    visible: !isValidator,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        StateValidator(
                          state: isPassLength8to16,
                          title: '8 -16 ký tự',
                        ),
                        const SizedBox(height: 16),
                        StateValidator(
                          state: isUpperCase,
                          title: '1 chữ cái viết hoa',
                        ),
                        const SizedBox(height: 16),
                        StateValidator(
                          state: isHasNumberCharacter,
                          title: '1 chữ số',
                        ),
                        const SizedBox(height: 16),
                        StateValidator(
                          state: isPassMatchSpecial,
                          title: ' tối thiểu 1 ký tự đặc biệt',
                        )
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 16),
            Form(
              key: confirmPass,
              child: AppTextField(
                controller: confirmPassController,
                labelText: "Nhập lại mật khẩu",
                obscureText: true,
                onChanged: (pass) {
                  confirmPass.currentState?.validate();
                  checkShowAction();
                },
                validator: (pass) {
                  return checkConfirmPass(pass!, passController.text);
                },
              ),
            ),
            const SizedBox(height: 36),
            ValueListenableBuilder<bool>(
              valueListenable: isShowAction,
              builder: (BuildContext context, isShowAction, Widget? child) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: isShowAction
                            ? () {
                                context.pushNamed('reference');
                              }
                            : null,
                        child: const Text('Lưu mật khẩu')));
              },
            )
          ],
        ),
      ),
    );
  }
}

mixin ValidatorPass {
  // check nếu có ít nhất n số
  bool passWordLength8to16(String password) {
    return password.length >= 8 && password.length <= 16;
  }

  // check nếu có ít nhất n số
  bool hasMinNumericChar(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return password.contains(RegExp(pattern));
  }

  // check nếu có ít nhất n ký tự
  bool hasMinUpperCaseChar(String password, int normalCount) {
    String pattern = '^(.*?[A-Z]){$normalCount,}';
    return password.contains(RegExp(pattern));
  }

  bool checkPassMatchSpecial(String pass) {
    if (pass.isEmpty) return false;
    return !specialCharacters.hasMatch(pass);
  }
}
