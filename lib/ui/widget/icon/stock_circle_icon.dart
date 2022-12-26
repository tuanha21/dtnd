import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StockCirleIcon extends StatelessWidget {
  const StockCirleIcon({
    super.key,
    required this.stockCode,
  });
  final String stockCode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(
        child: ClipOval(
          child: SizedBox.square(
            dimension: 32.0,
            child: CachedNetworkImage(
              imageUrl: "https://info.sbsi.vn/logo/$stockCode",
              imageBuilder: (context, imageProvider) => Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
