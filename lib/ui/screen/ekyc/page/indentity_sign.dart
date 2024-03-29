import 'package:dtnd/ui/screen/ekyc/page/identity_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/service/app_services.dart';

class IdentitySign extends StatefulWidget {
  const IdentitySign({Key? key}) : super(key: key);

  @override
  State<IdentitySign> createState() => _IdentitySignState();
}

class _IdentitySignState extends State<IdentitySign> {
  ValueNotifier<bool> isContinue = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    final textTheme = Theme.of(context).textTheme;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Xác minh chữ ký',
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Tiến hành ghi nhận chữ ký để phục vụ cho quá trình đầu tư án toàn và chuyên nghiệp',
              style: titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral_03,
                  fontSize: 14),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppImages.personal_card,
                        color: themeMode.isLight
                            ? AppColors.text_grey_1
                            : AppColors.neutral_07,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text('Chữ ký cá nhân')
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: themeMode.isLight
                          ? AppColors.neutral_06
                          : AppColors.bg_2,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.edit_sign,
                            color: themeMode.isLight
                                ? AppColors.text_grey_1
                                : AppColors.neutral_07,
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bắt đầu ký',
                                  style: textTheme.bodySmall?.copyWith(
                                      color: themeMode.isLight
                                          ? AppColors.neutral_02
                                          : AppColors.neutral_05,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    'Chữ ký cần rõ nét, thể hiện đủ trong khung nhập liệu',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: themeMode.isLight
                                            ? AppColors.neutral_02
                                            : AppColors.neutral_05)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            ValueListenableBuilder<bool>(
              valueListenable: isContinue,
              builder: (BuildContext context, isContinue, Widget? child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => const IdentityDialog());
                    },
                    child: const Text('Xác minh'),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      )),
    );
  }
}
