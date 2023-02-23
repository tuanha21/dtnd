import 'dart:async';
import 'dart:convert';

import 'package:dtnd/=models=/algo/filter.dart';
import 'package:dtnd/=models=/algo/stock_filter.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/app_snack_bar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import '../../../../../data/i_network_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../theme/app_color.dart';
import '../../../../widget/expanded_widget.dart';
import '../../../../widget/input/app_text_field.dart';
import '../../../../widget/my_appbar.dart';
import '../../filter_enum.dart';
import '../virtual_assistant_filter_screen.dart';

class ListStockFilter extends StatefulWidget {
  final Filter filter;

  const ListStockFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<ListStockFilter> createState() => _ListStockFilterState();
}

class _ListStockFilterState extends State<ListStockFilter> {
  final INetworkService iNetworkService = NetworkService();

  StreamController<List<StockFilter>> filterStream =
      StreamController.broadcast();

  late List<StockFilter> listStock;

  List<String> listFilterHeader = [];

  late LinkedScrollControllerGroup _controllers;

  late ScrollController _letters;
  late ScrollController _numbers;

  Future<void> getFilterApi() async {
    try {
      var list = await iNetworkService.getStockFilter(widget.filter);
      filterStream.sink.add(list);
      listStock = list;
    } catch (e) {
      filterStream.sink.addError("Có lỗi xảy ra");
    }
  }

  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers.addAndGet();
    _numbers = _controllers.addAndGet();
    getFilterApi();
    getListHead(widget.filter);
    super.initState();
  }

  Map get listFilterMap {
    Map<String, dynamic> map = {};
    for (var element in FilterEnum.values) {
      map.addAll(element.data);
    }
    return map;
  }

  void getListHead(Filter filter) {
    listFilterHeader = [
      'Sàn',
      "Ngành",
    ];
    for (var element in filter.list) {
      if (!listFilterHeader.contains(element.code)) {
        listFilterHeader.add(element.code!);
      }
    }
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 36,
          width: 90,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: index % 2 == 1
                  ? AppColors.neutral_04
                  : AppColors.neutral_04.withOpacity(0.5)),
          child: Text(listStock[index].sECURITYCODE ?? "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  int maxLength = 1;

  List<Widget> _buildCellsHeader(int count) {
    return List.generate(
      count,
      (index) {
        var text = "";
        if (index <= 1) {
          text = listFilterHeader[index];
        } else {
          text = listFilterMap[listFilterHeader[index]];
        }
        return Container(
          alignment: index <= 1 ? Alignment.centerLeft : Alignment.centerRight,
          width: index == 0 ? 70 : 140,
          child: Text(text,
              textAlign: index <= 1 ? TextAlign.left : TextAlign.right,
              maxLines: 4,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  List<Widget> _buildCells2(int count, int indexCell) {
    return List.generate(
      count,
      (index) {
        String text = "";
        if (index == 0) {
          text = listStock[indexCell].eXCHANGECODE ?? "";
        } else if (index == 1) {
          text = listStock[indexCell].iNDUSTRYNAME ?? "";
        } else {
          var map = listStock[indexCell].toJson();
          if (map.containsKey(listFilterHeader[index])) {
            text =
                NumUtils.formatInteger(map[listFilterHeader[index].toString()]);
          }
        }
        return Container(
          alignment: index <= 1 ? Alignment.centerLeft : Alignment.centerRight,
          height: 36,
          width: index == 0 ? 70 : 140,
          child: Text(text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral_02, fontWeight: FontWeight.w600)),
        );
      },
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) {
        return Container(
          decoration: BoxDecoration(
              color: index % 2 == 1
                  ? AppColors.neutral_04
                  : AppColors.neutral_04.withOpacity(0.5)),
          child: Row(
            children: _buildCells2(listFilterHeader.length, index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.filter.name ?? ""),
      body: StreamBuilder<List<StockFilter>>(
          stream: filterStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) return const SizedBox();
              return Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 90,
                              height: 60,
                              padding: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                  color: AppColors.neutral_04),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Mã CK",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: _letters,
                                child: Column(
                                  children: _buildCells(listStock.length),
                                ),
                              ),
                            )
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.neutral_04),
                                  child: SizedBox(
                                    height: 60,
                                    child: Row(
                                      children: _buildCellsHeader(
                                          listFilterHeader.length),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _numbers,
                                    child: Column(
                                      children: _buildRows(listStock.length),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                         var isRefresh = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return BottomEditFilter(filter: widget.filter);
                              });
                         if(isRefresh == true){
                           getFilterApi();
                           getListHead(widget.filter);

                         }
                        },
                        child: const Text('Chỉnh sửa bộ lọc'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }
}

class BottomEditFilter extends StatefulWidget {
  final Filter filter;

  const BottomEditFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<BottomEditFilter> createState() => _BottomEditFilterState();
}

class _BottomEditFilterState extends State<BottomEditFilter> {
  INetworkService iNetworkService = NetworkService();

  List<FilterRange> listFilterSelect = [];

  @override
  void initState() {
    listFilterSelect = widget.filter.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lưu bộ lọc', style: Theme.of(context).textTheme.bodyLarge),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.dark_bg,
                    )),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColors.neutral_05,
          height: 36,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return FilterBox(
                  filterEnum: FilterEnum.values[index],
                  filter: widget.filter,
                  onChanged: (FilterRange value, bool isSelect) {
                    /// check tồn tại hay chưa
                    var constantValue = listFilterSelect.firstWhereOrNull(
                            (element) => element.code == value.code) !=
                        null;
                    if (constantValue) {
                      /// xóa
                      if (!isSelect) {
                        listFilterSelect.removeWhere(
                            (element) => element.code == value.code);
                      } else {
                        /// update
                        var index = listFilterSelect.indexWhere(
                            (element) => element.code == value.code);
                        listFilterSelect[index] = value;
                      }
                    } else {
                      /// thêm
                      if (isSelect) {
                        listFilterSelect.add(value);
                      } else {
                        print('??????');
                      }
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemCount: FilterEnum.values.length),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await iNetworkService.setFilter(
                      widget.filter..criteria = jsonEncode(listFilterSelect),
                      "RU");
                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                } catch (e) {
                  print('lỗi cái lồn');
                }
              },
              child: const Text("Áp dụng"),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}

class FilterBox extends StatefulWidget {
  final FilterEnum filterEnum;
  final Filter filter;
  final OpTapCheckBox onChanged;

  const FilterBox(
      {Key? key,
      required this.filterEnum,
      required this.filter,
      required this.onChanged})
      : super(key: key);

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  bool isExpanded = false;

  var list = <MapEntry<String, dynamic>>[];

  FilterStockController get logic => Get.find<FilterStockController>();

  List<FilterRange> get listFilterSelect {
    return widget.filter.list;
  }

  @override
  void initState() {
    for (var e in widget.filterEnum.data.entries) {
      list.add(e);
    }
    super.initState();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.filterEnum.name,
                    style: Theme.of(context).textTheme.titleSmall),
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
                  return CheckBoxWidget(
                    title: list[index].value,
                    initValue: listFilterSelect.firstWhereOrNull(
                            (element) => element.code == list[index].key) !=
                        null,
                    initFilter: listFilterSelect.firstWhereOrNull(
                        (element) => element.code == list[index].key),
                    filterRange: logic.listFilterRange.firstWhere(
                        (element) => element.code == list[index].key),
                    onChanged: widget.onChanged,
                  );
                }),
          )
        ],
      ),
    );
  }
}

typedef OpTapCheckBox = Function(FilterRange filterRange, bool isSelect);

class CheckBoxWidget extends StatefulWidget {
  final String title;
  final bool? initValue;
  final FilterRange filterRange;
  final FilterRange? initFilter;
  final OpTapCheckBox onChanged;

  const CheckBoxWidget(
      {Key? key,
      required this.title,
      this.initValue,
      required this.filterRange,
      this.initFilter,
      required this.onChanged})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isCheckBox = false;
  late FilterRange filterRangeSelect;

  @override
  void initState() {
    if (widget.initValue != null) {
      isCheckBox = widget.initValue!;
    }
    filterRangeSelect = widget.initFilter ?? widget.filterRange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isCheckBox = !isCheckBox;
              widget.onChanged.call(filterRangeSelect, isCheckBox);
            });
          },
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isCheckBox
                    ? AppColors.primary_05
                    : AppColors.light_tabBar_bg),
            child: Visibility(
              visible: isCheckBox,
              child: const Icon(
                Icons.check,
                color: AppColors.light_bg,
                size: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
            child: GestureDetector(
          onTap: () async {
            await showBottomEdit(context);
          },
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.neutral_02),
          ),
        ))
      ],
    );
  }

  Future<void> showBottomEdit(BuildContext context) async {
    var value = await showModalBottomSheet<FilterRange?>(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return EditFilterDetail(
            filterRange: widget.filterRange,
            initFilter: widget.initFilter,
          );
        });
    if (value != null) {
      filterRangeSelect = value;
      widget.onChanged.call(filterRangeSelect, isCheckBox);
    }
  }
}

class EditFilterDetail extends StatefulWidget {
  final FilterRange filterRange;
  final FilterRange? initFilter;

  const EditFilterDetail({Key? key, required this.filterRange, this.initFilter})
      : super(key: key);

  @override
  State<EditFilterDetail> createState() => _EditFilterDetailState();
}

class _EditFilterDetailState extends State<EditFilterDetail> {
  final min = TextEditingController();
  final max = TextEditingController();

  @override
  void initState() {
    if (widget.initFilter != null) {
      min.text = widget.initFilter?.low.toString() ?? "";
      max.text = widget.initFilter?.high.toString() ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Chỉ số lọc cổ phiếu',
                  style: Theme.of(context).textTheme.bodyLarge),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.dark_bg,
                    )),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColors.neutral_05,
          height: 36,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: min,
                  hintText: widget.filterRange.low?.toString(),
                ),
              ),
              const SizedBox(width: 23),
              Expanded(
                child: AppTextField(
                  controller: max,
                  hintText: widget.filterRange.high?.toString(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  num minValue = 0;
                  num maxValue = 0;
                  if (min.text.isEmpty) {
                    minValue = widget.filterRange.low ?? 0;
                  } else {
                    minValue = num.tryParse(min.text) ?? 0;
                  }
                  if (max.text.isEmpty) {
                    maxValue = widget.filterRange.high ?? 0;
                  } else {
                    maxValue = num.tryParse(max.text) ?? 0;
                  }
                  if (minValue > maxValue) {
                    return AppSnackBar.showError(context,
                        message: "Giá trị không hợp lệ");
                  }
                  var filter = FilterRange(
                      code: widget.filterRange.code,
                      high: maxValue,
                      low: minValue);
                  Navigator.pop(context, filter);
                },
                child: const Text('Lưu'),
              ),
            )),
        const SizedBox(height: 20),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    ));
  }
}
