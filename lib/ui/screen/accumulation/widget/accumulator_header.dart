import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class AccumulatorHeader extends StatelessWidget {
  const AccumulatorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(AppImages.walletBackground), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).total_accumulation,
                  style:
                      textTheme.headlineSmall?.copyWith(color: Colors.white)),
              const SizedBox(
                height: 10,
              ),
              Text('200,000,000 đ',
                  style:
                      textTheme.headlineSmall?.copyWith(color: Colors.white)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.of(context).accumulate_today,
                      style:
                          textTheme.bodyLarge?.copyWith(color: Colors.white)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+ 68 đ',
                    style:
                        textTheme.bodyLarge?.copyWith(color: AppColors.graph_7),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
