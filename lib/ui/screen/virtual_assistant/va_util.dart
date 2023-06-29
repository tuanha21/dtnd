import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/register_info/register_intro_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_home/va_screen.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';

class VAUtil {
  static final IUserService userService = UserService();

  static void toVirtualAssistantScreen(BuildContext context) async {
    if (!userService.isLogin) {
      showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      ).then((toLogin) {
        if (toLogin ?? false) {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ))
              .then((result) {
            if (result ?? false) {
              return _afterLogin(context);
            } else {
              return;
            }
          });
        } else {
          return;
        }
      });
    } else {
      return userService
          .saveValueRegisterVa()
          .then((value) => _afterLogin(context));
    }
  }

  static void _afterLogin(BuildContext context) {
    if (userService.isRegisterVa.value == true) {
      Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const VaScreen()),
      );
    } else {
      Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const RegisterIntro()),
      );
    }
  }
}
