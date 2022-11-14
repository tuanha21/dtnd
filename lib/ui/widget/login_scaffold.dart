import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<ThemeMode>>(
      (data) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: data.value == ThemeMode.dark
                  ? AppColors.bg_2
                  : AppColors.bg_1,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                AppImages.login_top_circle,
                opacity: const AlwaysStoppedAnimation(0.3),
                scale: 3.0,
              ),
            ),
            Scaffold(
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              appBar: appBar,
              body: body,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              persistentFooterButtons: persistentFooterButtons,
              drawer: drawer,
              onDrawerChanged: onDrawerChanged,
              endDrawer: endDrawer,
              onEndDrawerChanged: onEndDrawerChanged,
              drawerScrimColor: drawerScrimColor,
              backgroundColor: Colors.transparent,
              bottomNavigationBar: bottomNavigationBar,
              bottomSheet: bottomSheet,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              primary: primary,
              drawerDragStartBehavior: drawerDragStartBehavior,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
              restorationId: restorationId,
            ),
          ],
        );
      },
      AppService().themeMode,
    );
  }
}
