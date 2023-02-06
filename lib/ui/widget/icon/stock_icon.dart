import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class StockIcon extends StatelessWidget {
  const StockIcon({
    super.key,
    required this.stockCode,
    this.size = 40,
    this.border,
  });
  final String stockCode;
  final double size;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Center(
        child: ClipOval(
          child: SizedBox.square(
            dimension: size,
            child: CachedNetworkImage(
              imageUrl: "https://info.sbsi.vn/logo/$stockCode",
              imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: border ?? Border.all(color: AppColors.neutral_05),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.scaleDown),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
