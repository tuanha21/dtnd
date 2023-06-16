import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/num_utils.dart';
import '../controller/accumulation_controller.dart';

class AccumulatorHeader extends StatelessWidget {
  AccumulatorHeader({super.key});

  final AccumulationController controller = AccumulationController();


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
        child: Obx(
          () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).total_accumulation,
                    style:
                        textTheme.headlineSmall?.copyWith(color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                Text('${NumUtils.formatInteger(controller.sumCapital.value)}đ',
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
                      '+ ${NumUtils.formatInteger(controller.sumCurrentFee.value)} đ',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.graph_7),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
