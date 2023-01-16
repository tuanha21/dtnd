import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/ekyc_introduce_page.dart';
import 'page/ekyc_select_type.dart';

class EkycState {
  final step = EkycPageStep.intro.obs;

  EkycState() {
    ///Initialize variables
  }
}

enum EkycPageStep {
  intro(EkycIntroducePage()),
  selectType(EkycSelectType()),
  validator(SizedBox()),
  validatorError(SizedBox()),
  identityInform(SizedBox()),
  success(SizedBox());

  const EkycPageStep(this.widget);

  final Widget widget;
}
