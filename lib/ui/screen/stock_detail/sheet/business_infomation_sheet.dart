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
  late final TabController _tabController;
  final IDataCenterService dataCenterService = DataCenterService();
  bool loading = true;
  int currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;
    final tabbarBgColor =
        themeMode.isLight ? AppColors.neutral_05 : AppColors.neutral_01;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            SheetHeader(
              title: S.of(context).business_information,
              implementBackButton: false,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        SizedBox.square(
                          dimension: 60.0,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://info.sbsi.vn/logo/${widget.stockModel.stock.stockCode}",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: AppColors.neutral_06,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.scaleDown),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.stockModel.stock.nameShort ?? "",
                                style: textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${widget.stockModel.stock.postTo?.name ?? ""}: ${widget.stockModel.stock.nameVn ?? ""}",
                                style: textTheme.labelMedium!
                                    .copyWith(color: AppColors.neutral_04),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Giới thiệu",
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Html(
                      data: widget.stockModel.businnessProfile!.profile,
                      // customRenders: {
                      //   "p": (context, child, _, __) {
                      //     return MaterialButton(
                      //       onPressed: () {
                      //         Navigator.of(context.buildContext)
                      //             .pushNamed('/new-page');
                      //       },
                      //       child: child,
                      //     );
                      //   },
                      // },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: tabbarBgColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            onTap: (value) {
                              print(value);
                              if (currentIndex != value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              }
                            },
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: AppColors.primary_01,
                            ),
                            labelColor: AppColors.neutral_07,
                            unselectedLabelColor: themeMode.isLight
                                ? AppColors.neutral_01
                                : AppColors.neutral_07,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            padding: EdgeInsets.zero,
                            // indicatorSize: TabBarIndicatorSize.label,
                            tabs: <Widget>[
                              Text(S.of(context).general_information),
                              Text(S.of(context).subsidiaries),
                            ],
                          ),
                        ),
                      ],
                    ),
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
            )
          ]),
        ),
      ),
    );
  }
}
