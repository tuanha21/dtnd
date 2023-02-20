import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_color.dart';
import '../../theme/app_image.dart';
import 'ekyc_logic.dart';
import 'page/ekyc_introduce_page.dart';

class EkycPage extends StatefulWidget {
  const EkycPage({super.key});

  @override
  State<EkycPage> createState() => _EkycPageState();
}

class _EkycPageState extends State<EkycPage> {
  final logic = Get.put(EkycLogic());
  final state = Get.find<EkycLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return logic.backStep();
      },
      child: Obx(() {
        return state.step.value.widget;
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<EkycLogic>();
    super.dispose();
  }
}
