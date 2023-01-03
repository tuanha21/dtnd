import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/widget/stock/stock_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_color.dart';
import '../../theme/app_image.dart';
import '../../theme/app_textstyle.dart';

class StockWidgetChart extends StatelessWidget {
  const StockWidgetChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.light_bg, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 36,
            width: 36,
            child: CachedNetworkImage(
              imageUrl: "https://info.sbsi.vn/logo/HPG",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.scaleDown),
                ),
              ),
              placeholder: (context, url) => Container(
                decoration: const BoxDecoration(
                    color: AppColors.accent_light_01, shape: BoxShape.circle),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                "HPG",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text.rich(
                TextSpan(children: [
                  WidgetSpan(
                      child: Image.asset(
                    AppImages.prefix_down_icon,
                    height: 12,
                    width: 12,
                  )),
                  const TextSpan(
                    text: " -0.98%",
                  )
                ]),
                maxLines: 1,
                style: AppTextStyle.labelMedium_12.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.semantic_03,
                ),
              )
            ],
          ),
          const SizedBox(width: 24),
          const Flexible(
              child: LineChartSample2(
            height: 35,
          ))
        ],
      ),
    );
  }
}
