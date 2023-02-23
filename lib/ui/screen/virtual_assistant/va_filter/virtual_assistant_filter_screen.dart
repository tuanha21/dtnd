import 'dart:async';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../=models=/algo/filter.dart';
import '../../../widget/input/app_text_field.dart';
import '../filter_enum.dart';
import 'logic/list_stock_filter.dart';

class AssistantStockFilterScreen extends StatefulWidget {
  const AssistantStockFilterScreen({super.key});

  @override
  State<AssistantStockFilterScreen> createState() =>
      _AssistantStockFilterScreenState();
}

class _AssistantStockFilterScreenState
    extends State<AssistantStockFilterScreen> {
  final INetworkService iNetworkService = NetworkService();

  StreamController<List<Filter>> filterStream = StreamController.broadcast();

  var logic = Get.put(FilterStockController());

  @override
  void initState() {
    getFilterApi();
    super.initState();
  }

  Map get listFilterMap {
    Map<String, dynamic> map = {};
    for (var element in FilterEnum.values) {
      map.addAll(element.data);
    }
    return map;
  }

  Future<void> getFilterApi() async {
    try {
      var list = await iNetworkService.getFilterAccount();
      filterStream.sink.add(list);
    } catch (e) {
      filterStream.sink.addError("Có lỗi xảy ra");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(false),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          S.current.filter_stock,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            S.of(context).stocks_you_interested,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).choose_stocks_you_interested,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.neutral_03, height: 18 / 14),
          ),
          const SizedBox(height: 36),
          Text(
            S.of(context).following_catalog,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const AddFilterSheet();
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: AppColors.neutral_06,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.add_square),
                  const SizedBox(width: 10),
                  Text(
                    "Thêm bộ lọc",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.text_blue),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder<List<Filter>>(
              stream: filterStream.stream,
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  var list = snapshot.data!;
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var filter = list[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ListStockFilter(filter: filter)));
                          },
                          tileColor: AppColors.neutral_06,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: Text(
                            filter.name ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) {
                                var data = filter.list[index1];
                                return Text(
                                  '${listFilterMap[data.code]}: ${NumUtils.formatInteger10(data.low)} - ${NumUtils.formatInteger10(data.high)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColors.neutral_03,
                                          fontWeight: FontWeight.w500),
                                );
                              },
                              separatorBuilder: (context, index1) {
                                return const SizedBox(height: 5);
                              },
                              itemCount: filter.list.length),
                          trailing: const Icon(Icons.chevron_right_outlined),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: list.length);
                }
                return const SizedBox();
              })
        ],
      ),
    );
  }
}

class AddFilterSheet extends StatefulWidget {
  const AddFilterSheet({Key? key}) : super(key: key);

  @override
  State<AddFilterSheet> createState() => _AddFilterSheetState();
}

class FilterStockController extends GetxController {
  INetworkService iNetworkService = NetworkService();
  final listFilterRange = <FilterRange>[].obs;

  @override
  void onInit() {
    getListRanger();
    super.onInit();
  }

  Future<void> getListRanger() async {
    try {
      listFilterRange.value = await iNetworkService.getFilterRange();
    } catch (_) {}
  }
}

class _AddFilterSheetState extends State<AddFilterSheet> {
  final nameController = TextEditingController();

  GlobalKey nameKey = GlobalKey<FormState>();

  ValueNotifier<bool> isValidator = ValueNotifier<bool>(false);

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
                Text('Lưu bộ lọc',
                    style: Theme.of(context).textTheme.bodyLarge),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.dark_bg,
                    ))
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
            child: Form(
              key: nameKey,
              child: AppTextField(
                controller: nameController,
                labelText: 'Tên bộ lọc',
                onChanged: (name) {
                  isValidator.value = name.isNotEmpty;
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ValueListenableBuilder<bool>(
                    valueListenable: isValidator,
                    builder:
                        (BuildContext context, isValidator, Widget? child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: AppColors.neutral_05,
                              disabledForegroundColor: AppColors.neutral_04),
                          onPressed: isValidator ? () {} : null,
                          child: const Text("Lưu"));
                    })),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
