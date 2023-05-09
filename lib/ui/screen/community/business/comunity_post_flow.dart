import 'package:flutter/cupertino.dart';

import '../../../../=models=/ui_model/sheet.dart';
import '../../../../=models=/ui_model/user_cmd.dart';

abstract class ICommunityPostsSheet extends ISheet {
  ICommunityPostsSheet();
}

class CommunityPostsISheet extends ICommunityPostsSheet {
  CommunityPostsISheet();

  @override
  ISheet? back([dynamic cmd]) => null;

  @override
  ISheet? next([UserCmd? cmd]) => null;

  @override
  Future<void>? onResultBack([dynamic cmd]) => null;

  @override
  Future<void>? onResultNext([dynamic cmd]) => null;

  @override
  Widget? backWidget([UserCmd? cmd]) => null;

  @override
  Widget? nextWidget([UserCmd? cmd]) => null;
}
