import 'dart:async';

import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class IdentityFace extends StatefulWidget {
  const IdentityFace({Key? key}) : super(key: key);

  @override
  State<IdentityFace> createState() => _IdentityFaceState();
}

class _IdentityFaceState extends State<IdentityFace> {
  EkycState get state => logic.state;

  ValueNotifier<bool> isContinue = ValueNotifier<bool>(true);
  final logic = Get.find<EkycLogic>();

  int countdownSeconds = 2;
  Timer? timer;
  bool isIdentity = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownSeconds > 0) {
          countdownSeconds--;
        } else {
          timer.cancel();
          isIdentity = true;
          Future.delayed(const Duration(seconds: 4), () {
            logic.nextStep();
          });
        }
      });
    });
  }

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
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Xác minh khuôn mặt',
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Giữ khuôn hình trong vòng 5 giây để hệ thống xác minh khuôn mặt. Vui lòng thực hiện ở nơi có ánh sáng tốt để có chất lượng hình ảnh tốt nhất.',
              style: titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral_03,
                  fontSize: 14),
            ),
            const SizedBox(height: 86),
            isIdentity
                ? Center(
                    child: Image.asset(
                      AppImages.tick_vertification,
                      height: 230,
                      width: 230,
                    ),
                  )
                : Container()
          ],
        ),
      )),
    );
  }
}
