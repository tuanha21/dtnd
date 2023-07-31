import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final double lineWidth;

  const NumberStepper({
    Key? key,
    required this.width,
    this.curStep = 0,
    required this.totalSteps,
    required this.lineWidth,
  }) : assert(curStep >= 0 && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      width: width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getLineColor(i) {
    var color = curStep >= i ? Colors.blue.withOpacity(0.4) : Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      var lineColor = getLineColor(i);
      if (i != totalSteps) {
        list.add(
          Expanded(
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Colors.transparent, end: lineColor),
              duration: const Duration(milliseconds: 300),
              builder: (_, Color? color, __) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  height: lineWidth,
                  color: color,
                );
              },
            ),
          ),
        );
      }
    }
    return list;
  }
}
