import 'dart:math';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/logic/stock_status.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
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
                ? AppColors.neutral_06
                : Colors.transparent,
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
                      data: stockModel.stockData.g1.value?.split("|"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      totalVol: stockModel.stockData.getTotalVol(Side.buy),
                      data: stockModel.stockData.g2.value?.split("|"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      totalVol: stockModel.stockData.getTotalVol(Side.buy),
                      data: stockModel.stockData.g3.value?.split("|"),
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
                      data: stockModel.stockData.g4.value?.split("|"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      totalVol: stockModel.stockData.getTotalVol(Side.sell),
                      data: stockModel.stockData.g5.value?.split("|"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      totalVol: stockModel.stockData.getTotalVol(Side.sell),
                      data: stockModel.stockData.g6.value?.split("|"),
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
  final List<String?>? data;
  double get vol => double.tryParse(data?.elementAt(1) ?? "0") ?? 0;
  double get ratio => totalVol == 0 ? 0 : vol / totalVol;

  @override
  State<ThreePriceElement> createState() => _ThreePriceElementState();
}

class _ThreePriceElementState extends State<ThreePriceElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;
  late Color color;

  double getBeginValue(ThreePriceElement oldWidget) {
    if (widget.totalVol == 0 || widget.vol == 0) return oldWidget.ratio;
    return widget.ratio;
  }

  double get endValue {
    if (widget.totalVol == 0 || widget.vol == 0) return 0;
    return widget.ratio;
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: endValue).animate(controller);
    color = SStatusHelper.fromString(widget.data?.elementAt(2) ?? "r").color;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void didUpdateWidget(ThreePriceElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalVol != widget.totalVol ||
        oldWidget.data?.elementAt(1) != widget.data?.elementAt(1)) {
      animation = Tween<double>(begin: getBeginValue(oldWidget), end: endValue)
          .animate(controller);
      controller.forward();
    }
    if (oldWidget.data?.elementAt(2) != widget.data?.elementAt(2)) {
      color = SStatusHelper.fromString(widget.data?.elementAt(2) ?? "r").color;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren;
    if (widget.side.isBuy) {
      rowChildren = [
        Text(
          widget.data?.elementAt(1) ?? "-",
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        ),
        Text(
          widget.data?.first ?? "-",
          style: AppTextStyle.labelSmall_10.copyWith(color: color),
        ),
      ];
    } else {
      rowChildren = [
        Text(
          widget.data?.first ?? "-",
          style: AppTextStyle.labelSmall_10.copyWith(color: color),
        ),
        Text(
          widget.data?.elementAt(1) ?? "-",
          style:
              AppTextStyle.labelSmall_10.copyWith(color: AppColors.neutral_04),
        )
      ];
    }
    return AnimatedContainer(
      side: widget.side,
      animation: animation,
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
  });
  final Side side;
  final double ratio;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = side.isBuy
          ? AppColors.three_prices_buy_bg
          : AppColors.three_prices_sell_bg;
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
  }) : super(listenable: animation);
  final Side side;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return CustomPaint(
      painter: VolBGPainter(side: side, ratio: animation.value),
      child: child,
    );
  }
}
