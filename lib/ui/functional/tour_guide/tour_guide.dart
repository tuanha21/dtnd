import 'dart:async';

import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/tour_guide/welcome_overlay.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

typedef TutorialAdd = void Function(TargetFocus value);

class TourGuide {
  static final TourGuide _instance = TourGuide._();

  final List<TargetFocus> targets = [];

  OverlayEntry? _overlayEntry;

  TourGuide._();

  factory TourGuide() => _instance;

  static void clear() => _instance.targets.clear();

  static List<TargetFocus> add(TargetFocus targetFocus) {
    _instance.targets.add(targetFocus);
    return _instance.targets;
  }

  static List<TargetFocus> addAll(List<TargetFocus> targets) {
    _instance.targets.addAll(targets);
    return _instance.targets;
  }

  static void showWelcome(BuildContext context, {void Function()? onNext}) {
    OverlayState? overlayState = Overlay.of(context);
    _instance._overlayEntry = OverlayEntry(
        builder: (context) => WelcomeOverlay(
              onSkip: () {
                _instance._overlayEntry?.remove();
              },
              onNext: () {
                _instance._overlayEntry?.remove();
                onNext?.call();
              },
            ));
    overlayState.insert(_instance._overlayEntry!);
  }

  static void showTutorial(BuildContext context,
      {FutureOr<void> Function(TargetFocus)? onClickTarget}) {
    TutorialCoachMark(
      targets: _instance.targets, // List<TargetFocus>
      colorShadow: AppColors.primary_01, // DEFAULT Colors.black
      alignSkip: Alignment.topRight,
      textSkip: S.of(context).skip.toUpperCase(),
      // paddingFocus: 10,
      // opacityShadow: 0.8,
      onClickTarget: onClickTarget,
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print(target);
      },
      onSkip: () {
        print("skip");
      },
      onFinish: () {
        print("finish");
      },
    ).show(context: context);
  }
}
