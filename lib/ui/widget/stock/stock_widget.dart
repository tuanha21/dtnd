import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_color.dart';

class StockWidget extends StatelessWidget {
  const StockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 20, top: 16, bottom: 16),
      decoration: BoxDecoration(
          color: AppColors.light_bg, borderRadius: BorderRadius.circular(12)),
      child: IntrinsicHeight(
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
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cổ phiếu HPG ️🎉',
                    style: titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mã cổ phiếu HPG đang tăng 8%',
                    style: titleSmall?.copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            SvgPicture.asset(AppImages.arrow_right)
          ],
        ),
      ),
    );
  }
}
