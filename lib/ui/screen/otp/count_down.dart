import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class TimeCountDown extends StatefulWidget {
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback voidCallback;

  const TimeCountDown(
      {Key? key,
      required this.textStyle,
      required this.duration,
      required this.voidCallback})
      : super(key: key);

  @override
  State<TimeCountDown> createState() => _TimeCountDownState();
}

class _TimeCountDownState extends State<TimeCountDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Countdown(
        style: widget.textStyle,
        controller: _controller,
        voidCallback: widget.voidCallback,
        animation: StepTween(
          begin: widget.duration.inSeconds,
          end: 0,
        ).animate(_controller),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  final AnimationController controller;
  final VoidCallback voidCallback;

  const Countdown({
    Key? key,
    required this.animation,
    this.style,
    required this.controller,
    required this.voidCallback,
  }) : super(key: key, listenable: animation);
  final Animation<int> animation;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: () {
        if (clockTimer.inSeconds == 0) {
          controller.reset();
          controller.forward();
          voidCallback();
        }
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Gửi lại mã? ',
              style: style?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary_01) ??
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary_01)),
          TextSpan(
              text: timerText,
              style: style?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.neutral_04) ??
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.neutral_04)),
        ]),
      ),
    );
  }
}
