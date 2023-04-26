import 'package:dtnd/=models=/response/filter_criterion.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:flutter/material.dart';

class FilterCriterionSection extends StatefulWidget {
  const FilterCriterionSection({
    super.key,
    required this.criterion,
    this.add,
    this.remove,
  });

  final FilterCriterion criterion;
  final ValueChanged<FilterCriterionFigure>? add;
  final ValueChanged<FilterCriterionFigure>? remove;

  @override
  State<FilterCriterionSection> createState() => _FilterCriterionSectionState();
}

class _FilterCriterionSectionState extends State<FilterCriterionSection> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_01,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Ink(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.criterion.name,
                      style: textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
            ExpandedSection(
                expand: expanded,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.criterion.filterCriterionFigure.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 2, // width/height ratio
                    mainAxisSpacing: 0, // between rows
                    crossAxisSpacing: 0, // between columns
                    mainAxisExtent: 36,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return FilterCriterionSectionElement(
                      criterionFigure:
                          widget.criterion.filterCriterionFigure[index],
                      add: widget.add,
                      remove: widget.remove,
                    );
                  },
                )),
          ],
        ));
  }
}

class FilterCriterionSectionElement extends StatefulWidget {
  const FilterCriterionSectionElement({
    super.key,
    required this.criterionFigure,
    this.add,
    this.remove,
  });

  final FilterCriterionFigure criterionFigure;
  final ValueChanged<FilterCriterionFigure>? add;
  final ValueChanged<FilterCriterionFigure>? remove;

  @override
  State<FilterCriterionSectionElement> createState() =>
      _FilterCriterionSectionElementState();
}

class _FilterCriterionSectionElementState
    extends State<FilterCriterionSectionElement> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 20,
          child: Checkbox(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              value: selected,
              onChanged: (newValue) {
                setState(() {
                  selected = newValue ?? !selected;
                });
                if (selected) {
                  widget.add?.call(widget.criterionFigure);
                } else {
                  widget.remove?.call(widget.criterionFigure);
                }
              }),
        ),
        const SizedBox(width: 6),
        Expanded(
            child: Text(
          widget.criterionFigure.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ))
      ],
    );
  }
}
