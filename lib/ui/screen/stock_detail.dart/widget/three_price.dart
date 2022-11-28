import 'dart:math';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/logic/stock_status.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreePrices extends StatelessWidget {
  const ThreePrices({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<ThemeMode>>(
      (themeMode) {
        return Container(
          decoration: BoxDecoration(
            color: themeMode.value.isDark
                ? Colors.transparent
                : AppColors.neutral_06,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ThreePriceHeader(
                      side: Side.buy,
                      themeMode: themeMode.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      totalVol: stockModel.stockData.getTotalVol(Side.buy),
                      data: stockModel.stockData.g1.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      totalVol: stockModel.stockData.getTotalVol(Side.buy),
                      data: stockModel.stockData.g2.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      totalVol: stockModel.stockData.getTotalVol(Side.buy),
                      data: stockModel.stockData.g3.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Column(
                  children: [
                    ThreePriceHeader(
                      side: Side.sell,
                      themeMode: themeMode.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      totalVol: stockModel.stockData.getTotalVol(Side.sell),
                      data: stockModel.stockData.g4.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      totalVol: stockModel.stockData.getTotalVol(Side.sell),
                      data: stockModel.stockData.g5.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      totalVol: stockModel.stockData.getTotalVol(Side.sell),
                      data: stockModel.stockData.g6.value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      AppService.instance.themeMode,
    );
  }
}

class ThreePriceHeader extends StatelessWidget {
  const ThreePriceHeader({
    super.key,
    required this.side,
    required this.themeMode,
  });
  final Side side;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(4);
    List<Widget> rowChildren;
    BorderRadius borderRadius;
    if (side.isBuy) {
      rowChildren = [Text(S.of(context).volumn), Text(side.name(context))];
      borderRadius = const BorderRadius.only(
        topLeft: radius,
      );
    } else {
      rowChildren = [Text(side.name(context)), Text(S.of(context).volumn)];
      borderRadius = const BorderRadius.only(
        topRight: radius,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    );
  }
}

class ThreePriceElement extends StatefulWidget {
  const ThreePriceElement({
    super.key,
    required this.side,
    required this.themeMode,
    required this.totalVol,
    this.data,
  });
  final Side side;
  final ThemeMode themeMode;
  final num totalVol;
  final String? data;

  String get price => data?.split('|').elementAt(0) ?? "0";

  double get vol => double.tryParse(data?.split('|').elementAt(1) ?? "0") ?? 0;

  String get status => data?.split('|').elementAt(2) ?? "r";

  double get ratio => totalVol == 0 ? 0 : vol / totalVol;

  @override
  State<ThreePriceElement> createState() => _ThreePriceElementState();
}

class _ThreePriceElementState extends State<ThreePriceElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Duration duration = const Duration(milliseconds: 500);
  late Animation<double> animation;
  late Color color;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    color = SStatusHelper.fromString(widget.status).color;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateTo(widget.ratio, duration: const Duration(seconds: 1));
    });
  }

  @override
  void didUpdateWidget(ThreePriceElement oldWidget) {
    if (oldWidget.totalVol != widget.totalVol || oldWidget.vol != widget.vol) {
      if (controller.isAnimating) {
        controller.stop();
        controller.animateTo(widget.ratio, duration: duration);
      } else if (controller.isCompleted) {
        controller.animateBack(widget.ratio, duration: duration);
      } else {
        controller.animateTo(widget.ratio, duration: duration);
      }
    }
    if (oldWidget.status != widget.status) {
      color = SStatusHelper.fromString(widget.status).color;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    List<Widget> rowChildren;
    if (double.tryParse(widget.price) == 0) {
      rowChildren = [
        Text(
          "",
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        ),
      ];
    } else if (widget.side.isBuy) {
      rowChildren = [
        Text(
          NumUtils.formatInteger10(widget.vol),
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        ),
        Text(
          widget.price.toString(),
          style: AppTextStyle.labelSmall_10.copyWith(color: color),
        ),
      ];
    } else {
      rowChildren = [
        Text(
          widget.price.toString(),
          style: AppTextStyle.labelSmall_10.copyWith(color: color),
        ),
        Text(
          NumUtils.formatInteger10(widget.vol),
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        )
      ];
    }
    final Color volColor = themeMode.isDark
        ? (widget.side.isBuy
            ? AppColors.accent_dark_01
            : AppColors.accent_dark_03)
        : (widget.side.isBuy
            ? AppColors.three_prices_buy_bg
            : AppColors.three_prices_sell_bg);
    return AnimatedContainer(
      side: widget.side,
      animation: animation,
      color: volColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    );
  }
}

class VolBGPainter extends CustomPainter {
  const VolBGPainter({
    required this.side,
    required this.ratio,
    required this.color,
  });
  final Side side;
  final double ratio;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    if (side.isBuy) {
      canvas.translate(size.width, size.height);
      canvas.rotate(pi);
    }
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, ratio * size.width, size.height),
        topRight: const Radius.circular(4),
        bottomRight: const Radius.circular(4),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(VolBGPainter oldDelegate) => true;
}

class AnimatedContainer extends AnimatedWidget {
  const AnimatedContainer({
    super.key,
    required Animation<double> animation,
    required this.child,
    required this.side,
    required this.color,
  }) : super(listenable: animation);
  final Side side;
  final Widget? child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return CustomPaint(
      painter: VolBGPainter(side: side, ratio: animation.value, color: color),
      child: child,
    );
  }
}
