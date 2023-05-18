import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:flutter/cupertino.dart';

import '../../../../=models=/ui_model/sheet.dart';
import '../../../../=models=/ui_model/user_cmd.dart';

class ToRegisterCmd extends NextCmd {
  const ToRegisterCmd([super.data]);
}

class ToCancelCmd extends NextCmd {
  const ToCancelCmd([super.data]);
}

abstract class IRegistrationRightsSheet extends ISheet {
  IRegistrationRightsSheet();
}

class RegistrationRightsFLowSheet extends IRegistrationRightsSheet {
  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  Widget? nextWidget([cmd]) => null;

  @override
  Future<void>? onResultBack([dynamic cmd]) => null;

  @override
  Future<void>? onResultNext([dynamic cmd]) => null;

  @override
  IOverlay? next([UserCmd? cmd]) => null;

  @override
  Widget? backWidget([UserCmd? cmd]) => null;
}
