import 'dart:io';

import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/media_permission.dart';
import '../../../theme/app_color.dart';
import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class ValidatorIdentity extends StatefulWidget {
  const ValidatorIdentity({Key? key}) : super(key: key);

  @override
  State<ValidatorIdentity> createState() => _ValidatorIdentityState();
}

class _ValidatorIdentityState extends State<ValidatorIdentity> {
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
            Text(
              'Xác minh tài khoản ',
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: 'Chụp ảnh ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: "2 mặt CMND/CCCD",
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.light_bg)),
                TextSpan(
                    text: ' để xác minh tài khoản',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
              ]),
            ),
            const SizedBox(height: 36),
            const CardIdentityPick(
              icon: AppImages.personalCardWhite,
              title: 'Mặt trước CMND/CCCD',
            ),
            const SizedBox(height: 16),
            const CardIdentityPick(
              icon: AppImages.card,
              title: 'Mặt sau CMND/CCCD',
            )
          ],
        ),
      ),
    );
  }
}

class CardIdentityPick extends StatefulWidget {
  final String icon;
  final String title;

  const CardIdentityPick({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  State<CardIdentityPick> createState() => _CardIdentityPickState();
}

class _CardIdentityPickState extends State<CardIdentityPick> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral_04)),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(widget.icon),
              const SizedBox(width: 10),
              Expanded(child: Text(widget.title)),
              Visibility(
                  visible: image != null,
                  child: GestureDetector(
                    onTap: (){
                      MediaPermission.bottomDialog(context, "title", "content");
                    },
                      child: SvgPicture.asset(AppImages.edit2)))
            ],
          ),
          const SizedBox(height: 18),
          Visibility(
            visible: image == null,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      image = await MediaPermission.checkPermissionAndPickImage(
                          context, "gallery");
                      if (image != null) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: AppColors.text_black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.image),
                          const SizedBox(width: 10),
                          Text(
                            'Tải ảnh lên',
                            style: bodySmall?.copyWith(
                                color: AppColors.neutral_04),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed('camera');
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: AppColors.text_black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.camera),
                          const SizedBox(width: 10),
                          Text(
                            'Chụp ảnh',
                            style: bodySmall?.copyWith(
                                color: AppColors.neutral_04),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          image != null
              ? Container(
                  height: 195,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: FileImage(image!), fit: BoxFit.fill)),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
