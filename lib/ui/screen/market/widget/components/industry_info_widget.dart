import 'dart:math';

import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/controller/industry_tab_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';

class IndustryInfoWidget extends StatefulWidget {
  const IndustryInfoWidget({super.key});

  @override
  State<IndustryInfoWidget> createState() => _IndustryInfoWidgetState();
}

class _IndustryInfoWidgetState extends State<IndustryInfoWidget> {
  final IndustryTabController controller = IndustryTabController();

  FieldTreeModel? currentIndustry;

  @override
  void initState() {
    super.initState();
    if (controller.model.isEmpty) {
      controller.getListIndustry();
    } else {
      setState(() {
        currentIndustry = controller.model.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.v(controller.model);
    if (controller.model.isEmpty || currentIndustry == null) {
      return Center(
        child: Text(S.of(context).loading),
      );
    } else {
      final textTheme = Theme.of(context).textTheme;
      return ListView(
        children: [
          Row(
            children: [
              Expanded(
                  child: DropdownButtonHideUnderline(
                child: DropdownButton<FieldTreeModel>(
                  value: currentIndustry,
                  // isDense: true,
                  isExpanded: true,
                  items: controller.model
                      .map<DropdownMenuItem<FieldTreeModel>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.iNDUSTRY,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  // selectedItemBuilder: (context) => controller.model
                  //     .map<Widget>(
                  //       (e) => Row(
                  //         children: [
                  //           FittedBox(
                  //             child: Text(
                  //               e.iNDUSTRY,
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //     .toList(),
                  onChanged: (value) {
                    setState(() {
                      currentIndustry = value;
                    });
                  },
                ),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            child: Image.network("https://picsum.photos/44")),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentIndustry!.iNDUSTRY,
                                style: textTheme.titleSmall,
                              ),
                              Text(
                                "${(Random().nextInt(100) + 25).toString()} mã",
                                style: textTheme.labelMedium!
                                    .copyWith(color: AppColors.neutral_04),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentIndustry!.tOTALKLGD.toString(),
                            style: textTheme.titleSmall,
                          ),
                          Builder(builder: (context) {
                            final per = Random().nextDouble() * 2 - 1;
                            Widget pre;
                            Color color;
                            if (per >= 0) {
                              pre = Image.asset(AppImages.prefix_up_icon);
                              color = AppColors.semantic_01;
                            } else {
                              pre = Image.asset(AppImages.prefix_down_icon);
                              color = AppColors.semantic_03;
                            }
                            return Text(
                              "${per.toStringAsPrecision(2)}%",
                              style:
                                  textTheme.labelMedium!.copyWith(color: color),
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
