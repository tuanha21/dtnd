import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class DevelopingFeature extends StatelessWidget {
  const DevelopingFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 200,
              child: Image.asset(AppImages.scene),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).developing_feature,
              style: textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
