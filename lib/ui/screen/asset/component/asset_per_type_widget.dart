import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AssetPerTypeWidget extends StatelessWidget {
  const AssetPerTypeWidget({
    Key? key,
    required this.values,
    this.padding,
    this.margin,
  }) : super(key: key);
  final List<MoneyType> values;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: margin ?? const EdgeInsets.symmetric(horizontal: 0),
          padding: padding ?? const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              for (int i = 0; i < values.length; i += 2)
                Column(
                  children: [
                    i != 0 ? const SizedBox(height: 16) : Container(),
                    Row(
                      children: [
                        Expanded(
                            child: _MoneyType(
                          data: values.elementAt(i),
                        )),
                        const SizedBox(width: 3),
                        Expanded(
                            child: _MoneyType(
                          data: values.elementAt(i + 1),
                        )),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoneyType extends StatelessWidget {
  const _MoneyType({
    Key? key,
    required this.data,
  }) : super(key: key);
  final MoneyType data;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          data.icon,
          width: 36,
          height: 36,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: textTheme.labelMedium!
                    .copyWith(color: AppColors.neutral_03),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                data.value,
                style: textTheme.labelMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
