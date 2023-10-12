import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

import 'foreign_widget_signal.dart';

class SignalEffective extends StatefulWidget {
  const SignalEffective({
    super.key,
    required this.code,
    required this.type,
  });

  final String code;
  final String type;

  @override
  State<SignalEffective> createState() => _SignalEffectiveState();
}

class _SignalEffectiveState extends State<SignalEffective> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(12)),
      //     color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox.square(
                    dimension: 36, child: Image.asset(AppImages.signal_icon)),
                const SizedBox(width: 12),
                Text(
                  S.of(context).effective,
                  style: AppTextStyle.titleSmall_14
                      .copyWith(color: AppColors.primary_01),
                )
              ],
            ),
          ),
          ForeignWidgetSignal(
            code: widget.code,
            type: widget.type,
          ),
        ],
      ),
    );
  }
}
