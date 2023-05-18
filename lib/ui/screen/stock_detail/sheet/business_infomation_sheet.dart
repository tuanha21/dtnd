import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

import '../../../../=models=/response/introduct_company.dart';
import '../../../../generated/l10n.dart';
import '../../home/widget/home_section.dart';
import '../tab/general_info_tab.dart';
import '../tab/subsidiaries_info_tab.dart';

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
  final INetworkService iNetworkService = NetworkService();

  late Future<CompanyIntroductionResponse> introduce;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    introduce =
        iNetworkService.getCompanyIntroduction(widget.stockModel.stockData.sym);

    //getData();
  }

  void getData() async {
    widget.stockModel.businnessProfile ??= await dataCenterService
        .getBusinnessProfile(widget.stockModel.stock.stockCode);
    widget.stockModel.businnessLeaders ??= await dataCenterService
        .getBusinnessLeaders(widget.stockModel.stock.stockCode);

    // widget.stockModel.subsidiaries.subsidiaries ??= await dataCenterService
    //     .getSubsidiaries(widget.stockModel.stock.stockCode);
    //
    // widget.stockModel.subsidiaries.associatedCompany ??= await dataCenterService
    //     .getAssociatedCompany(widget.stockModel.stock.stockCode);
    // widget.stockModel.subsidiaries.other ??= await dataCenterService
    //     .getOtherCompany(widget.stockModel.stock.stockCode);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.light_bg,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thông tin doanh nghiệp",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: AppColors.primary_03,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          Icons.clear,
                          color: AppColors.text_black_1,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 36,
                color: AppColors.light_tabBar_bg,
                indent: 16,
                endIndent: 16,
                thickness: 1,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://info.sbsi.vn/logo/${widget.stockModel.stock.stockCode}',
                              imageBuilder: (context, provider) {
                                return Container(
                                  height: 63,
                                  width: 63,
                                  decoration: BoxDecoration(
                                      color: AppColors.neutral_06,
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: provider,
                                          fit: BoxFit.contain)),
                                );
                              },
                              errorWidget: (context, _, __) {
                                return Container(
                                  height: 63,
                                  width: 63,
                                  decoration: BoxDecoration(
                                      color: AppColors.neutral_06,
                                      borderRadius: BorderRadius.circular(4)),
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(widget.stockModel.stock.stockCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.stockModel.stock.postTo!.name} : ${widget.stockModel.stock.nameShort}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.neutral_04),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<CompanyIntroductionResponse>(
                        future: introduce,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            }
                            var profile = snapshot.data?.data?.profile;
                            var document = parse(profile!);
                            return HomeSection(
                              title: "Về ${widget.stockModel.stockData.sym}",
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: LayoutBuilder(builder: (context, ctx) {
                                  {
                                    return Text(
                                      document.body?.text.trim() ?? "",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    );
                                  }
                                }),
                              ),
                            );
                          }
                          return const SizedBox();
                        }),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: currentIndex == 1
                          ? SubsidiariesInfoTab(stockModel: widget.stockModel)
                          : GeneralInfoTab(stockModel: widget.stockModel),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
