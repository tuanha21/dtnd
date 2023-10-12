import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class WelcomeOverlay extends StatelessWidget {
  const WelcomeOverlay({super.key, required this.onSkip, required this.onNext});
  final void Function() onSkip;
  final void Function() onNext;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Container(
            color: AppColors.primary_01.withOpacity(0.8),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    S.of(context).welcome_overlay_qoute1,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.labelLarge_18,
                  ))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    S.of(context).welcome_overlay_qoute2,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.labelLarge_18,
                  ))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: onNext,
                    child: Text(
                      "${S.of(context).next} >>",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.labelLarge_18,
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
        _buildSkip(context)
      ],
    );
  }

  Widget _buildSkip(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SafeArea(
        child: InkWell(
          onTap: onSkip,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              S.of(context).skip.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
