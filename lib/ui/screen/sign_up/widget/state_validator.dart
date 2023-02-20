import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/app_image.dart';

class StateValidator extends StatelessWidget {
  final ValueNotifier<bool> state;
  final String title;

  const StateValidator({Key? key, required this.state, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodySmall = Theme.of(context).textTheme.bodySmall;

    return ValueListenableBuilder<bool>(
        valueListenable: state,
        builder: (context, state, child) {
          return Row(
            children: [
              SvgPicture.asset(
                  state ? AppImages.icon_success : AppImages.icon_error),
              const SizedBox(width: 10),
              Text(
                title,
                style: bodySmall?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          );
        });
  }
}
