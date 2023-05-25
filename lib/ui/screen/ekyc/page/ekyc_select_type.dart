import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_image.dart';
import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class EkycSelectType extends StatefulWidget {
  const EkycSelectType({Key? key}) : super(key: key);

  @override
  State<EkycSelectType> createState() => _EkycSelectTypeState();
}

class _EkycSelectTypeState extends State<EkycSelectType> {
  final logic = Get.find<EkycLogic>();

  EkycState get state => logic.state;

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            logic.backStep();
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
                Get.find<EkycLogic>().nextStep();
              },
            ),
            const SizedBox(height: 16),
            const CardTitle(
              icon: AppImages.documentCopy,
              title: 'Hộ chiếu',
            ),
            const SizedBox(height: 16),
            const CardTitle(
              icon: AppImages.personalCard,
              title: 'Bằng lái xe',
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
    return ListTile(
      onTap: onTap,
      tileColor: AppColors.neutral_06,
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
