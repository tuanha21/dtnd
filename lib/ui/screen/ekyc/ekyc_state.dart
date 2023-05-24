import 'dart:io';

import 'package:dtnd/ui/widget/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/ekyc_introduce_page.dart';
import 'page/ekyc_select_type.dart';
import 'page/indentity_inform.dart';
import 'page/validator_identity.dart';

class EkycState {
  final step = EkycPageStep.intro.obs;

  File? identityFront;
  File? identityBack;

  EkycState() {
    ///Initialize variables
  }
}

enum EkycPageStep {
  intro(EkycIntroducePage()),
  selectType(EkycSelectType()),
  validator(ValidatorIdentity()),
  identityInform(IdentityInform()),
  success(SizedBox());

  const EkycPageStep(this.widget);

  final Widget widget;
}
