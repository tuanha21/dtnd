import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_home/va_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../config/service/app_services.dart';

class RegisterRegistered extends StatelessWidget {
  const RegisterRegistered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: MyAppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
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
        title: 'Trợ lý ảo',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Responsive.getMaxWidth(context) / 3,
              child: Image.asset(
                AppImages.virtual_assistant_registered,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).successfully_create_assistant_account,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              S
                  .of(context)
                  .the_DTND_virtual_assistant_will_help_you_with_successful_transaction,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: () { Navigator.of(context).push<void>(
                  MaterialPageRoute(
                      builder: (context) => const VaScreen()),
                );},
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: Text(
                  S.of(context).next,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral_07),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
