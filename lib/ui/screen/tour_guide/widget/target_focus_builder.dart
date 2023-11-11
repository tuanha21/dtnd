import 'package:dtnd/ui/screen/tour_guide/widget/app_target_focus.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TargetFocusBuilder {
  final dynamic identify;
  final GlobalKey<State<StatefulWidget>> keyTarget;
  final ContentAlign align;
  final String content;
  late final VoidCallback skip;
  late final VoidCallback next;
  final AlignmentGeometry? alignSkip;
  final ShapeLightFocus? shape;

  final String? skipLabel;
  final String? nextLabel;

  TargetFocusBuilder({
    this.identify,
    required this.keyTarget,
    required this.align,
    required this.content,
    this.alignSkip,
    this.shape,
    this.skipLabel,
    this.nextLabel,
  });

  TargetFocus build({
    required VoidCallback onSkip,
    required VoidCallback onNext,
  }) {
    return AppTargetFocus(
      identify: identify,
      keyTarget: keyTarget,
      align: align,
      content: content,
      skip: onSkip,
      next: onNext,
      shape: shape,
      skipLabel: skipLabel,
      nextLabel: nextLabel,
    );
  }

  String getIdentify() => identify ?? hashCode.toString();
}
