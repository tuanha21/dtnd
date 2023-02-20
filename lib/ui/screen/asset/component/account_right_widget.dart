import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

const List<Color> plate = [
  AppColors.graph_1,
  AppColors.graph_2,
  AppColors.graph_7,
];

class AccountRightWidget extends StatelessWidget {
  const AccountRightWidget({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 35,
                child: Text(
                  "0$index",
                  style: textTheme.headlineSmall!.copyWith(
                    color: plate[index % 3],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TK: 24123435454",
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "3 quyền",
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.neutral_03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
              const Icon(
                Icons.chevron_right_rounded,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
