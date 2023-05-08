import 'package:dtnd/=models=/ui_model/overlay.dart';
import 'package:flutter/cupertino.dart';

import '../../../../=models=/ui_model/sheet.dart';
import '../../../../=models=/ui_model/user_cmd.dart';

class ToChangeOrderCmd extends NextCmd {
  const ToChangeOrderCmd([super.data]);
}

class ToStockOrderCmd extends NextCmd {
  const ToStockOrderCmd([super.data]);
}

class ToCancelOrderCmd extends NextCmd {
  const ToCancelOrderCmd([super.data]);
}

abstract class IRegistrationRightsSheet extends ISheet {
  IRegistrationRightsSheet();
}

class RegistrationRightsFLowSheet extends IRegistrationRightsSheet {
  RegistrationRightsFLowSheet();

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  Widget? backWidget([cmd]) => null;

  @override
  Widget? nextWidget([cmd]) {}

  @override
  Future<void>? onResultBack([dynamic cmd]) => null;

  @override
  Future<void>? onResultNext([dynamic cmd]) => null;

  @override
  IOverlay? next([UserCmd? cmd]) {
    throw UnimplementedError();
  }
}
