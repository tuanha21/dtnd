import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AssetPerTypeWidget extends StatelessWidget {
  const AssetPerTypeWidget({
    Key? key,
    required this.values,
  }) : super(key: key);
  final List<MoneyType> values;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.label,
              style:
                  textTheme.labelSmall!.copyWith(color: AppColors.neutral_03),
            ),
            Text(
              data.value,
              style:
                  textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }
}
