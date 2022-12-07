import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/register_fill_otp.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/register_intro.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/register_registered.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';

class VirtualAssistantRegister extends StatefulWidget {
  const VirtualAssistantRegister({super.key});

  @override
  State<VirtualAssistantRegister> createState() =>
      _VirtualAssistantRegisterState();
}

class _VirtualAssistantRegisterState extends State<VirtualAssistantRegister> {
  final PageController pageController = PageController();
  bool initialized = false;
  bool accepted = false;

  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
  }

  void switchTermAgreement(bool? newValue) {
    setState(() {
      accepted = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(false),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          S.of(context).virtual_assistant,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          RegisterIntro(
            nextPage: nextPage,
          ),
          RegisterFillOTP(nextPage: nextPage),
          RegisterRegistered(nextPage: () => Navigator.of(context).pop(true)),
        ],
      ),
    );
  }
}
