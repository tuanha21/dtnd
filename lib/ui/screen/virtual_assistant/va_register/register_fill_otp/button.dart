import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';

class MyButton extends StatelessWidget {
  final Function? onTap;
  final String? iconPath;
  final String title;
  final Color colorTitle;
  final Color background;
  final RxBool cantTap;
  final EdgeInsetsGeometry padding;

  const MyButton({
    this.onTap,
    this.iconPath,
    required this.title,
    this.background = AppColors.color_secondary,
    this.colorTitle = AppColors.neutral_07,
    required this.cantTap,
    this.padding = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        child: Container(
          height: 44,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: cantTap.value ? background : AppColors.neutral_03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconPath != null
                  ? Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: SvgPicture.asset(
                        iconPath!,
                        color:
                            cantTap.value ? colorTitle : AppColors.neutral_03,
                        height: 16,
                        width: 16,
                      ),
                    )
                  : const SizedBox(),
              Text(title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral_07))
            ],
          ),
        ),
        onTap: () {
          if (cantTap.value && onTap != null) {
            onTap!();
          }
        },
      );
    });
  }
}
