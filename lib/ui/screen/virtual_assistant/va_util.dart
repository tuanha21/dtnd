import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_controller.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/va_register.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_screen.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';

class VAUtil {
  static final IUserService userService = UserService();
  static void toVirtualAssistantScreen(BuildContext context) async {
    if (!userService.isLogin) {
      await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      ).then((toLogin) => Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ))
          .then((value) => toVirtualAssistantScreen(context)));
    } else {
      return _afterLogin(context);
    }
  }

  static void _afterLogin(BuildContext context) {
    if (VAController.instance.registered) {
      Navigator.of(context).push<void>(
          MaterialPageRoute(builder: (context) => const VAScreen()));
    } else {
      Navigator.of(context)
          .push<bool>(MaterialPageRoute(
              builder: (context) => VARegister(
                    onChanged: (bool? val) => {},
                  )))
          .then((registered) {
        if (registered ?? false) {
          Navigator.of(context).push<void>(
              MaterialPageRoute(builder: (context) => const VAScreen()));
        }
      });
    }
  }
}
