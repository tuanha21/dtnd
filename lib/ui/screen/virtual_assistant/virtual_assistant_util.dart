import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_controller.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/virtual_assistant_register.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_screen.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';

class VirtualAsisstantUtil {
  static final IUserService userService = UserService();
  static void toVirtualAssistantScreen(BuildContext context) async {
    if (!userService.isLogin) {
      await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstCatalog();
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
    if (VirtualAssistantController.instance.registered) {
      Navigator.of(context).push<void>(MaterialPageRoute(
          builder: (context) => const VirtualAssistantScreen()));
    } else {
      Navigator.of(context)
          .push<bool>(MaterialPageRoute(
              builder: (context) => const VirtualAssistantRegister()))
          .then((registered) {
        if (registered ?? false) {
          Navigator.of(context).push<void>(MaterialPageRoute(
              builder: (context) => const VirtualAssistantScreen()));
        }
      });
    }
  }
}
