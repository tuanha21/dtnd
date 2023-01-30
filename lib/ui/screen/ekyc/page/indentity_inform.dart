import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class IdentityInform extends StatefulWidget {
  const IdentityInform({Key? key}) : super(key: key);

  @override
  State<IdentityInform> createState() => _IdentityInformState();
}

class _IdentityInformState extends State<IdentityInform> {
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Xác minh tài khoản ',
            style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
