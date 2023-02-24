import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverboughtSellWidget extends StatefulWidget {
  const OverboughtSellWidget({super.key, required this.stockModel});
  final StockModel stockModel;
  @override
  State<OverboughtSellWidget> createState() => _OverboughtSellWidgetState();
}

class _OverboughtSellWidgetState extends State<OverboughtSellWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: OverboughtSellRatioPainter(
                        widget.stockModel.stockData.getTotalVol(Side.buy) /
                            (widget.stockModel.stockData.getTotalVol(Side.buy) +
                                widget.stockModel.stockData
                                    .getTotalVol(Side.sell))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Dư mua ",
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_03),
                    ),
                    Text(
                      NumUtils.getMoneyWithPostfixThousand(
                          widget.stockModel.stockData.getTotalVol(Side.buy),
                          context),
                      style: AppTextStyle.labelMedium_12.copyWith(
                          color: AppColors.semantic_01,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Dư bán ",
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_03),
                    ),
                    Text(
                      NumUtils.getMoneyWithPostfixThousand(
                          widget.stockModel.stockData.getTotalVol(Side.sell),
                          context),
                      style: AppTextStyle.labelMedium_12.copyWith(
                          color: AppColors.semantic_03,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class OverboughtSellRatioPainter extends CustomPainter {
  const OverboughtSellRatioPainter(this.buyRatio);
  final num buyRatio;
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    const radius = Radius.circular(4);
    Paint paint = Paint()
      ..color = AppColors.semantic_01
      // ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, (width * buyRatio) - 1, 4),
        topLeft: radius,
        bottomLeft: radius,
      ),
      paint,
    );
    paint.color = AppColors.semantic_03;
    canvas.translate((width * buyRatio) + 1, 0);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, (width * (1 - buyRatio)) - 1, 4),
        topRight: radius,
        bottomRight: radius,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(OverboughtSellRatioPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(OverboughtSellRatioPainter oldDelegate) => false;
}
