import 'dart:io';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/ekyc/ekyc_controller.dart';
import 'package:dtnd/ui/screen/ekyc/page/indentity_inform.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../config/service/app_services.dart';
import '../../../../utilities/media_permission.dart';
import '../../../theme/app_color.dart';

class ValidatorIdentity extends StatefulWidget {
  const ValidatorIdentity({super.key, required this.style});

  final int style;

  @override
  State<ValidatorIdentity> createState() => _ValidatorIdentityState();
}

class _ValidatorIdentityState extends State<ValidatorIdentity> {
  final EkycController myController = Get.put(EkycController());
  File? identityFront;
  File? identityBack;

  ValueNotifier<bool> isContinue = ValueNotifier<bool>(false);

  bool get isContinueStep {
    return identityFront != null && identityBack != null;
  }

  @override
  void initState() {
    isContinue.value = isContinueStep;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            // logic.backStep();
            // state.identityFront = null;
            // state.identityBack = null;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                          color: themeMode.isLight
                              ? AppColors.bg_2
                              : AppColors.neutral_07)),
                  TextSpan(
                      text: ' để xác minh tài khoản',
                      style: titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_04)),
                ]),
              ),
              const SizedBox(height: 36),
              CardIdentityPick(
                icon: AppImages.personalCardWhite,
                initImage: identityFront,
                title: 'Mặt trước CMND/CCCD',
                onChanged: (File? file) {
                  identityFront = file;
                  isContinue.value = isContinueStep;
                },
              ),
              const SizedBox(height: 16),
              CardIdentityPick(
                icon: AppImages.card,
                initImage: identityBack,
                title: 'Mặt sau CMND/CCCD',
                onChanged: (File? file) {
                  identityBack = file;
                  isContinue.value = isContinueStep;
                },
              ),
              const SizedBox(height: 36),
              ValueListenableBuilder<bool>(
                valueListenable: isContinue,
                builder: (BuildContext context, isContinue, Widget? child) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: isContinue
                          ? () {
                              myController.updateFrontFile(identityFront!);
                              myController.updateBackFile(identityBack!);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const IdentityInform(),
                              ));
                            }
                          : null,
                      child: Text(S.of(context).next),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class CardIdentityPick extends StatefulWidget {
  final String icon;
  final String title;
  final File? initImage;
  final ValueChanged<File?> onChanged;

  const CardIdentityPick(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onChanged,
      this.initImage})
      : super(key: key);

  @override
  State<CardIdentityPick> createState() => _CardIdentityPickState();
}

class _CardIdentityPickState extends State<CardIdentityPick> {
  File? image;

  @override
  void initState() {
    image = widget.initImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral_04)),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(widget.icon, color: AppColors.bg_2),
              const SizedBox(width: 10),
              Expanded(child: Text(widget.title)),
              Visibility(
                visible: image != null,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      image = null;
                    });
                  },
                  child: SvgPicture.asset(AppImages.edit2),
                ),
              )
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
                        setState(() {
                          widget.onChanged.call(image);
                        });
                      }
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: themeMode.isLight
                            ? AppColors.neutral_06
                            : AppColors.text_black_1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.image,
                            color: AppColors.neutral_03,
                          ),
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
                    onTap: () async {
                      image = await MediaPermission.checkPermissionAndPickImage(
                          context, "camera");
                      if (image != null) {
                        setState(() {
                          widget.onChanged.call(image);
                        });
                      }
                      // context.pushNamed('camera');
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: themeMode.isLight
                            ? AppColors.neutral_06
                            : AppColors.text_black_1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.camera,
                            color: AppColors.neutral_03,
                          ),
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
                        image: FileImage(image!), fit: BoxFit.fill),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
