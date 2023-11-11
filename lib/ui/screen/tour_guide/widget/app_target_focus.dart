import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class AppTargetFocus extends TargetFocus {
  AppTargetFocus({
    dynamic identify,
    required GlobalKey<State<StatefulWidget>> keyTarget,
    required ContentAlign align,
    required String content,
    required VoidCallback skip,
    required VoidCallback next,
    String? skipLabel,
    String? nextLabel,
    AlignmentGeometry? alignSkip,
    ShapeLightFocus? shape,
  }) : super(
          identify: identify ?? keyTarget.hashCode,
          keyTarget: keyTarget,
          alignSkip: alignSkip ?? Alignment.topRight,
          enableOverlayTab: false,
          shape: shape,
          contents: [
            TargetContent(
              align: align,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            content,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: skip,
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.text_black,
                                foregroundColor: Colors.white),
                            child: Text(skipLabel ?? S.of(context).skip),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextButton(
                              onPressed: next,
                              style: TextButton.styleFrom(
                                  backgroundColor: AppColors.text_black,
                                  foregroundColor: AppColors.primary_01),
                              child: Text(nextLabel ?? S.of(context).next)),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        );
}
