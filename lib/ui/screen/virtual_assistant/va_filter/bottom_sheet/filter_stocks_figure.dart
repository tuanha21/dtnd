import 'package:dtnd/=models=/response/filter_criterion.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/logic/bottom_sheet_cmd.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/input/thousand_separator_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterStocksFigure extends StatefulWidget {
  const FilterStocksFigure({
    super.key,
    required this.listCriterionFigure,
  });

  final Set<FilterCriterionFigure> listCriterionFigure;

  @override
  State<FilterStocksFigure> createState() => _FilterStocksFigureState();
}

class _FilterStocksFigureState extends State<FilterStocksFigure> {
  final VirtualAssistantFilterController controller =
      VirtualAssistantFilterController();
  final IDataCenterService dataCenterService = DataCenterService();

  bool initialized = true;

  final Set<FilterCriterionFigure> listSelected = {};

  @override
  void initState() {
    super.initState();
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
                          S.of(context).filter_stock_figure,
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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.listCriterionFigure.length,
                    itemBuilder: (context, index) {
                      if (!initialized) {
                        return Center(
                          child: Text(S.of(context).loading),
                        );
                      }
                      return FilterStocksFigureRow(
                        criterionFigure:
                            widget.listCriterionFigure.elementAt(index),
                      );
                    },
                  ),
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
                            Navigator.of(context).pop(listSelected);
                          },
                          child: Text(S.of(context).create))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterStocksFigureRow extends StatelessWidget {
  const FilterStocksFigureRow({
    super.key,
    required this.criterionFigure,
  });

  final FilterCriterionFigure criterionFigure;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                criterionFigure.name,
                style:
                    textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _RowTextField(criterionFigure),
              const SizedBox(
                width: 20,
                child: Center(child: Text("-")),
              ),
              _RowTextField(criterionFigure),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowTextField extends StatelessWidget {
  const _RowTextField(this.criterionFigure);

  final FilterCriterionFigure criterionFigure;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        ThousandsSeparatorInputFormatter(),
      ],
      decoration: InputDecoration(
        suffixIcon: Center(
          child: Text(
            criterionFigure.valueType,
            style: AppTextStyle.labelSmall_10.copyWith(
              color: AppColors.neutral_03,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(maxWidth: 36),
      ),
    ));
  }
}
