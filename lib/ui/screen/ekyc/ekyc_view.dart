import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ekyc_logic.dart';

class EkycPage extends StatefulWidget {
  @override
  _EkycPageState createState() => _EkycPageState();
}

class _EkycPageState extends State<EkycPage> {
  final logic = Get.put(EkycLogic());
  final state = Get.find<EkycLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<EkycLogic>();
    super.dispose();
  }
}