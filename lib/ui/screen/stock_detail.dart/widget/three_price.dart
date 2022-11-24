import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
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
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.buy,
                      data: stockModel.stockData.g1.value?.split("|"),
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
                    ThreePriceElement(
                      themeMode: themeMode.value,
                      side: Side.sell,
                      data: stockModel.stockData.g4.value?.split("|"),
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
    this.data,
  });
  final Side side;
  final ThemeMode themeMode;
  final List<String?>? data;

  @override
  State<ThreePriceElement> createState() => _ThreePriceElementState();
}

class _ThreePriceElementState extends State<ThreePriceElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(
            begin: 0, end: double.tryParse(widget.data?.elementAt(1) ?? "0"))
        .animate(controller);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant ThreePriceElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    animation = Tween<double>(
            begin: double.tryParse(oldWidget.data?.elementAt(1) ?? "0"),
            end: double.tryParse(widget.data?.elementAt(1) ?? "0"))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren;
    if (widget.side.isBuy) {
      rowChildren = [
        Text(widget.data?.first ?? "-"),
        Text(widget.data?.elementAt(1) ?? "-")
      ];
    } else {
      rowChildren = [
        Text(widget.data?.elementAt(1) ?? "-"),
        Text(widget.data?.first ?? "-"),
      ];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Stack(
        children: [
          AnimatedContainer(animation: animation),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        ],
      ),
    );
  }
}

class AnimatedContainer extends AnimatedWidget {
  const AnimatedContainer({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    print(animation.value);
    return Center(
      child: Container(
        height: 20,
        width: animation.value,
        color: AppColors.semantic_01,
      ),
    );
  }
}
