import 'dart:async';

import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/tour_guide/welcome_overlay.dart';
import 'package:dtnd/ui/screen/tour_guide/widget/target_focus_builder.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class AppTutorial {
  static final AppTutorial _instance = AppTutorial._();

  static final List<TargetFocusBuilder> _targets = [];

  static TutorialCoachMark? _tutorialCoachMark;

  // welcome

  static OverlayEntry? _overlayEntry;

  AppTutorial._();

  factory AppTutorial() => _instance;

  static void addTarget({
    required GlobalKey<State<StatefulWidget>> keyTarget,
    required ContentAlign align,
    required String content,
    required AlignmentGeometry? alignSkip,
  }) {
    _targets.add(
      TargetFocusBuilder(
        keyTarget: keyTarget,
        align: align,
        content: content,
        alignSkip: alignSkip,
      ),
    );
  }

  static void addTargets(List<TargetFocusBuilder> list) {
    _targets.addAll(list);
  }

  static void showTutorial(
    BuildContext context, {
    FutureOr<void> Function(TargetFocus)? onClickTarget,
    void Function(dynamic)? onBuildNext,
    void Function(dynamic)? onBuildSkip,
  }) {
    final List<TargetFocus> list = [];
    for (var builder in _targets) {
      list.add(builder.build(
        onSkip: () {
          if (_tutorialCoachMark != null) {
            _tutorialCoachMark!.finish();
          }
          onBuildSkip?.call(builder.getIdentify());
        },
        onNext: () {
          if (_tutorialCoachMark != null) {
            _tutorialCoachMark!.next();
          }
          onBuildNext?.call(builder.getIdentify());
        },
      ));
    }
    _targets.clear();
    _tutorialCoachMark = TutorialCoachMark(
      targets: list,
      colorShadow: AppColors.primary_01,
      alignSkip: Alignment.topRight,
      hideSkip: true,
      textSkip: S.of(context).skip.toUpperCase(),
      // paddingFocus: 10,
      // opacityShadow: 0.8,
      onClickTarget: onClickTarget,
      // onClickTargetWithTapPosition: (target, tapDetails) {},
      // onClickOverlay: (target) {
      //   print(target);
      // },
      // onSkip: () {
      //   print("skip");
      // },
      // onFinish: () {
      //   print("finish");
      // },
    );
    _tutorialCoachMark!.show(context: context);
  }

  static void showWelcome(BuildContext context, {void Function()? onNext}) {
    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (context) => WelcomeOverlay(
              onSkip: () {
                _overlayEntry?.remove();
              },
              onNext: () {
                _overlayEntry?.remove();
                onNext?.call();
              },
            ));
    overlayState.insert(_overlayEntry!);
  }
}
