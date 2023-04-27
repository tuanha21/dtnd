import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../=models=/algo/filter.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../widget/expanded_widget.dart';
import 'check_box_component.dart';

class MarketBox extends StatefulWidget {
  final Filter? filter;
  final OpTapCheckBox onChanged;

  const MarketBox({Key? key,  this.filter, required this.onChanged})
      : super(key: key);

  @override
  State<MarketBox> createState() => _MarketBoxState();
}

class _MarketBoxState extends State<MarketBox> {
  bool isExpanded = false;

  List<String> get list => ["HOSE", "HNX", "UPCOM"];

  List<String> get listFilterSelect {
    return widget.filter?.listMarket ?? [];
  }

  int get count {
    int count = 0;
    for (var element in listFilterSelect) {
      for (var element1 in list) {
        if (element1 == element) {
          count++;
        }
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              children: [
                Text(S.of(context).floor, style: Theme.of(context).textTheme.titleSmall),
                Visibility(
                    visible: count > 0,
                    child: Text(
                      ' (${count.toString()})',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.primary_01),
                    )),
                const Spacer(),
                SvgPicture.asset(
                    !isExpanded ? AppImages.arrowUp1 : AppImages.arrowDown)
              ],
            ),
          ),
          ExpandedSection(
            expand: isExpanded,
            child: GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return CheckBoxComponent(
                    initValue: listFilterSelect.contains(list[index]),
                    text: list[index],
                    initText: listFilterSelect
                        .firstWhereOrNull((element) => element == list[index]),
                    onChanged: widget.onChanged,
                  );
                }),
          )
        ],
      ),
    );
  }
}
