import 'package:dtnd/=models=/response/filter_criterion.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/component/filter_criterion_section.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/logic/bottom_sheet_cmd.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';

class FilterStocks extends StatefulWidget {
  const FilterStocks({super.key});

  @override
  State<FilterStocks> createState() => _FilterStocksState();
}

class _FilterStocksState extends State<FilterStocks> {
  final VirtualAssistantFilterController controller =
      VirtualAssistantFilterController();
  final IDataCenterService dataCenterService = DataCenterService();

  bool initialized = false;

  final Set<FilterCriterionFigure> listSelected = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await controller.getFilterCriterion();
    setState(() {
      initialized = true;
    });
  }

  void addFilterCriterionFigure(FilterCriterionFigure value) {
    listSelected.add(value);
  }

  void removeFilterCriterionFigure(FilterCriterionFigure value) {
    listSelected.remove(value);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final color =
        themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return SizedBox(
      width: size.width,
      height: size.height - padding.top - padding.bottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).pop(BottomSheetCmd.back),
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Text(
                          S.of(context).filter_stock,
                          style: textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Ink(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filterCriterions.length,
                  itemBuilder: (context, index) {
                    if (!initialized) {
                      return Center(
                        child: Text(S.of(context).loading),
                      );
                    }
                    return FilterCriterionSection(
                      criterion: controller.filterCriterions[index],
                      add: addFilterCriterionFigure,
                      remove: removeFilterCriterionFigure,
                    );
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            if (listSelected.isEmpty) {
                              return;
                            }
                            Navigator.of(context).pop(listSelected);
                          },
                          child: Text(S.of(context).next))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
