import 'package:dtnd/ui/screen/ekyc/page/validator_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/service/app_services.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_image.dart';

class EkycSelectType extends StatefulWidget {
  const EkycSelectType({Key? key}) : super(key: key);

  @override
  State<EkycSelectType> createState() => _EkycSelectTypeState();
}

class _EkycSelectTypeState extends State<EkycSelectType> {
  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                AppImages.illust07,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Chọn loại giấy tờ xác minh',
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        'Hãy đảm bảo giấy tờ xác minh của bạn chưa hết hạn và bị hư hỏng như rách, mờ thông tin,...',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
              ]),
            ),
            const SizedBox(height: 24),
            CardTitle(
              icon: AppImages.personalCard,
              title: 'CMND/CCCD',
              onTap: () {
                // Get.find<EkycLogic>().nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ValidatorIdentity(
                      style: 1,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CardTitle(
              icon: AppImages.documentCopy,
              title: 'Hộ chiếu',
              onTap: () {
                // Get.find<EkycLogic>().nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ValidatorIdentity(
                      style: 2,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CardTitle(
              icon: AppImages.personalCard,
              title: 'Bằng lái xe',
              onTap: () {
                // Get.find<EkycLogic>().nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ValidatorIdentity(
                      style: 3,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const CardTitle(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return ListTile(
      onTap: onTap,
      tileColor: themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_01,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.light_tabBar_bg),
        child: SvgPicture.asset(
          icon,
          color: AppColors.color_primary_1,
        ),
      ),
      title: Text(title),
      trailing:
          SvgPicture.asset(AppImages.arrow_right, color: AppColors.neutral_04),
    );
  }
}
