import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_controller.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/virtual_assistant_register.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_screen.dart';
import 'package:flutter/material.dart';

class VirtualAsisstantUtil {
  static void toVirtualAssistantScreen(BuildContext context) async {
    if (VirtualAssistantController.instance.registered) {
      return Navigator.of(context).push<void>(MaterialPageRoute(
          builder: (context) => const VirtualAssistantScreen()));
    } else {
      final bool? registered = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
              builder: (context) => const VirtualAssistantRegister()));
      if (registered ?? false) {
        return Navigator.of(context).push<void>(MaterialPageRoute(
            builder: (context) => const VirtualAssistantScreen()));
      }
    }
  }
}
