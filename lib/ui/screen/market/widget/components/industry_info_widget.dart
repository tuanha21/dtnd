import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/controller/industry_tab_controller.dart';
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
    Widget dropdown;
    logger.v(controller.model);
    if (controller.model.isEmpty) {
      dropdown = Center(
        child: Text(S.of(context).loading),
      );
    } else {
      dropdown = DropdownButtonHideUnderline(
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
      );
    }
    return ListView(
      children: [
        Row(
          children: [
            Expanded(child: dropdown),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Row(children: [],),
        )
      ],
    );
  }
}
