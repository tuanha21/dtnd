import 'package:dtnd/=models=/response/market/stock.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/component/stock_component.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/logic/bottom_sheet_cmd.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:flutter/material.dart';

class AddFilterStock extends StatefulWidget {
  const AddFilterStock({super.key});

  @override
  State<AddFilterStock> createState() => _AddFilterStockState();
}

class _AddFilterStockState extends State<AddFilterStock> {
  final VirtualAssistantFilterController controller =
      VirtualAssistantFilterController();
  final IDataCenterService dataCenterService = DataCenterService();

  final List<String> listSuggestionCatalogs = ["VN30"];

  bool initalized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    await controller.getList30Stocks();
    setState(() {
      initalized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final color =
        themeMode.isDark ? AppColors.neutral_01 : AppColors.neutral_06;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).add_following_stock,
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Ink(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SearchStockField<Stock>(
                    suggestionsCallback: (String code) => dataCenterService
                        .searchStocksBySym(code, maxSuggestions: 5),
                    itemBuilder: (context, itemData) {
                      return SizedBox(
                        height: 72,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: const BoxDecoration(
                              color: AppColors.neutral_06,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(itemData.stockCode),
                              Text(itemData.nameShort ?? "-"),
                            ],
                          ),
                        ),
                      );
                    },
                    onSuggestionSelected: controller.addStock,
                  ),
                ),
                IconButton(
                    iconSize: 24,
                    padding: const EdgeInsets.all(12),
                    onPressed: () =>
                        Navigator.of(context).pop(BottomSheetCmd.toFilter),
                    icon: Image.asset(AppImages.tune_icon))
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: Builder(
                builder: (context) {
                  if (!initalized) {
                    return Center(
                      child: Text(S.of(context).loading),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => StockComponent(
                      model: controller.listSuggestionStocks.value![index],
                      onSelected: controller.addStock,
                    ),
                    itemCount: controller.listSuggestionStocks.value!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
