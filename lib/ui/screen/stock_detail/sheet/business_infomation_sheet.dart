import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/tab/general_info_tab.dart';
import 'package:dtnd/ui/screen/stock_detail/tab/subsidiaries_info_tab.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BusinessInformationSheet extends StatefulWidget {
  const BusinessInformationSheet({Key? key, required this.stockModel})
      : super(key: key);
  final StockModel stockModel;

  @override
  State<BusinessInformationSheet> createState() =>
      _BusinessInformationSheetState();
}

class _BusinessInformationSheetState extends State<BusinessInformationSheet>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  bool loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    widget.stockModel.businnessProfile ??= await dataCenterService
        .getBusinnessProfile(widget.stockModel.stock.stockCode);
    widget.stockModel.businnessLeaders ??= await dataCenterService
        .getBusinnessLeaders(widget.stockModel.stock.stockCode);
    widget.stockModel.subsidiaries.subsidiaries ??= await dataCenterService
        .getSubsidiaries(widget.stockModel.stock.stockCode);
    widget.stockModel.subsidiaries.associatedCompany ??= await dataCenterService
        .getAssociatedCompany(widget.stockModel.stock.stockCode);
    widget.stockModel.subsidiaries.other ??= await dataCenterService
        .getOtherCompany(widget.stockModel.stock.stockCode);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SafeArea(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Text(S.of(context).loading),
          ),
        ),
      );
    }
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.light_tabBar_bg),
                child: TabBar(
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  indicatorColor: AppColors.text_blue,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.text_blue),
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.symmetric(vertical: 4),
                  labelColor: AppColors.light_bg,
                  unselectedLabelColor: AppColors.text_black,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  tabs: [
                    Text(S.of(context).general_information),
                    Text(S.of(context).subsidiaries)
                  ],
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      currentIndex == 1
                          ? SubsidiariesInfoTab(stockModel: widget.stockModel)
                          : GeneralInfoTab(stockModel: widget.stockModel),
                      // Builder(
                      //   builder: (context) {
                      //     if (currentIndex == 1) {
                      //       return SubsidiariesInfoTab(
                      //           stockModel: widget.stockModel);
                      //     } else {
                      //       return GeneralInfoTab(stockModel: widget.stockModel);
                      //     }
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
