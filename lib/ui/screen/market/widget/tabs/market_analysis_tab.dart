import 'package:dtnd/=models=/algo/match_type.dart';
import 'package:dtnd/=models=/algo/org_filter.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/indContrib.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/service/app_services.dart';
import '../../../../theme/app_color.dart';
import '../components/Fi_chart.dart';
import '../components/IndFvalue.dart';
import '../components/PI_chart.dart';

class MarketAnalysisTab extends StatefulWidget {
  const MarketAnalysisTab({super.key});

  @override
  State<MarketAnalysisTab> createState() => _MarketAnalysisTabState();
}

class _MarketAnalysisTabState extends State<MarketAnalysisTab>
    with AutomaticKeepAliveClientMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  late Future<IndContrib> piValue;
  late Future<IndContrib> fiValue;

  late Future<IndContrib> indFvalue;

  void initData() {
    // print(orgFilter.filterOrg.code);
    // print(orgFilter.filterInd.market);
    piValue = dataCenterService.getPIvalue(orgFilter.filterInd.market);
    fiValue = dataCenterService.getFIvalue(orgFilter.filterInd.market);
    indFvalue = dataCenterService.getIndFvalue(orgFilter.filterInd.market);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  OrgFilter orgFilter =
      OrgFilter(filterInd: Index.VNI, filterOrg: MatchType.Match);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData themeData = Theme.of(context);
    final ThemeMode = AppService.instance.themeMode.value;

    return ListView(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: themeData.colorScheme.background),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: themeData.colorScheme.background),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppColors.primary_02),
                                child: Center(
                                  child: Text(
                                    S.of(context).person,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.neutral_07,
                                            fontSize: 12),
                                  ),
                                )),
                            const SizedBox(height: 10),
                            FutureBuilder(
                              future: Future.wait([piValue, fiValue]),
                              builder: (context,
                                  AsyncSnapshot<List<dynamic>> snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }

                                var piValue = snapshot.data![0]; //piValue
                                var fiValue = snapshot.data![1]; //fiValue

                                final totalPiBuy =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? piValue.totalBuy
                                        : piValue.totalPTBuy;
                                final totalFiBuy =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? fiValue.totalBuy
                                        : fiValue.totalPTBuy;

                                final totalPiSell =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? piValue.totalSell
                                        : piValue.totalPTSell;
                                final totalFiSell =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? fiValue.totalSell
                                        : fiValue.totalPTSell;

                                var totalBuy = double.parse((totalPiBuy ?? '0')
                                        .replaceAll(RegExp(r','), '')) +
                                    double.parse((totalFiBuy ?? '0')
                                        .replaceAll(RegExp(r','), ''));
                                var totalSell = double.parse(
                                        (totalPiSell ?? '0')
                                            .replaceAll(RegExp(r','), '')) +
                                    double.parse((totalFiSell ?? '0')
                                        .replaceAll(RegExp(r','), ''));
                                return Text(
                                  '${NumUtils.formatDouble((totalSell - totalBuy))} Tỷ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: themeData
                                              .colorScheme.onBackground,
                                          fontSize: 16),
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                          ])),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: themeData.colorScheme.background),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppColors.primary_02),
                                child: Center(
                                  child: Text(
                                    S.of(context).self_employed,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.neutral_07,
                                            fontSize: 12),
                                  ),
                                )),
                            const SizedBox(height: 8),
                            FutureBuilder<IndContrib>(
                              future: piValue,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }

                                var piValue = snapshot.data!; //fiValue
                                final totalPiBuy =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? piValue.totalBuy
                                        : piValue.totalPTBuy;

                                final totalPiSell =
                                    orgFilter.filterOrg == MatchType.Match
                                        ? piValue.totalSell
                                        : piValue.totalPTSell;

                                var piTotal = double.parse((totalPiBuy ?? '0')
                                        .replaceAll(RegExp(r','), '')) -
                                    double.parse((totalPiSell ?? '0')
                                        .replaceAll(RegExp(r','), ''));
                                return Text(
                                  '${NumUtils.formatDouble(piTotal)} Tỷ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: themeData
                                              .colorScheme.onBackground,
                                          fontSize: 16),
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                          ])),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: themeData.colorScheme.background),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: AppColors.primary_02),
                            child: Center(
                              child: Text(
                                S.of(context).foreign,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutral_07,
                                        fontSize: 12),
                              ),
                            )),
                        const SizedBox(height: 8),
                        FutureBuilder<IndContrib>(
                          future: fiValue,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox();
                            }

                            var piValue = snapshot.data!; //fiValue
                            final totalPiBuy =
                                orgFilter.filterOrg == MatchType.Match
                                    ? piValue.totalBuy
                                    : piValue.totalPTBuy;

                            final totalPiSell =
                                orgFilter.filterOrg == MatchType.Match
                                    ? piValue.totalSell
                                    : piValue.totalPTSell;
                            var piTotal = double.parse((totalPiBuy ?? '0')
                                    .replaceAll(RegExp(r','), '')) -
                                double.parse((totalPiSell ?? '0')
                                    .replaceAll(RegExp(r','), ''));
                            return Text(
                              '${NumUtils.formatDouble(piTotal)} Tỷ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: themeData.colorScheme.onBackground,
                                      fontSize: 16),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).top_self_trading_stocks,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      backgroundColor: ThemeMode.isLight ? AppColors.light_bg : AppColors.neutral_01,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: ThemeMode.isLight ? AppColors.light_bg : AppColors.neutral_01,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            '${S.of(context).suggest_infomation} ${TimeUtilities.parseDateToString(DateTime.now())}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 14)),
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppImages.infoCircle,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () async {
                var index = await showCupertinoModalPopup<OrgFilter>(
                    context: context,
                    builder: (context) {
                      return BottomSheet(orgFilter: orgFilter);
                    });
                if (index != null) {
                  orgFilter = index;
                  setState(() {
                    initData();
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).filter,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.color_secondary),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(AppImages.filter),
                ],
              ),
            ),
          ]),
        ),
        PiValueChart(pIValue: piValue),
        FiChartValue(fIValue: fiValue),
        IndFvalue(
          fIValue: indFvalue,
        ),
        const SizedBox(height: 100)
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class BottomSheet extends StatefulWidget {
  final OrgFilter? orgFilter;

  const BottomSheet({Key? key, this.orgFilter}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  OrgFilter? orgFiltered;

  @override
  void initState() {
    orgFiltered = widget.orgFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color:
                themeMode.isLight ? AppColors.light_bg : AppColors.neutral_01,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).filter,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.clear,
                            color: themeMode.isLight
                                ? AppColors.text_black
                                : AppColors.neutral_05)),
                  ],
                ),
              ),
              const Divider(
                height: 32,
                thickness: 1,
                color: AppColors.light_tabBar_bg,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.of(context).stock_exchange,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: Index.values
                    .map((index) => CheckBoxMarket(
                          key: UniqueKey(),
                          index: index,
                          indexInit: orgFiltered?.filterInd,
                          onChanged: (Index index) {
                            setState(() {
                              orgFiltered?.filterInd = index;
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.of(context).type,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: MatchType.values
                    .map((index) => CheckBoxMatchType(
                          key: UniqueKey(),
                          matchType: index,
                          typeInit: orgFiltered?.filterOrg,
                          onChanged: (MatchType index) {
                            setState(() {
                              orgFiltered?.filterOrg = index;
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, orgFiltered);
                      },
                      child: Text(S.of(context).apply)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxMarket extends StatefulWidget {
  final Index index;
  final Index? indexInit;

  final ValueChanged<Index> onChanged;

  const CheckBoxMarket(
      {Key? key, required this.index, required this.onChanged, this.indexInit})
      : super(key: key);

  @override
  State<CheckBoxMarket> createState() => _CheckBoxMarketState();
}

class _CheckBoxMarketState extends State<CheckBoxMarket> {
  late bool _isSelect;

  @override
  void initState() {
    _isSelect = widget.index == widget.indexInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Material(
      color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01 ,
      child: ListTile(
        onTap: () {
          setState(() {
            _isSelect = !_isSelect;
            widget.onChanged.call(widget.index);
          });
        },
        minLeadingWidth: 20,
        leading: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: _isSelect
                      ? AppColors.color_secondary
                      : AppColors.neutral_03)),
          child: Visibility(
            visible: _isSelect,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.color_secondary),
            ),
          ),
        ),
        title: Text(
          widget.index.market,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  _isSelect ? AppColors.color_secondary : AppColors.neutral_03),
        ),
      ),
    );
  }
}

class CheckBoxMatchType extends StatefulWidget {
  final MatchType matchType;
  final MatchType? typeInit;

  final ValueChanged<MatchType> onChanged;

  const CheckBoxMatchType(
      {Key? key,
      required this.matchType,
      required this.onChanged,
      this.typeInit})
      : super(key: key);

  @override
  State<CheckBoxMatchType> createState() => _CheckBoxMatchTypeState();
}

class _CheckBoxMatchTypeState extends State<CheckBoxMatchType> {
  late bool _isSelect;

  @override
  void initState() {
    _isSelect = widget.matchType == widget.typeInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return Material(
      color : themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01 ,
      child: ListTile(
        onTap: () {
          setState(() {
            _isSelect = !_isSelect;
            widget.onChanged.call(widget.matchType);
          });
        },
        minLeadingWidth: 20,
        leading: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: _isSelect
                      ? AppColors.color_secondary
                      : AppColors.neutral_03)),
          child: Visibility(
            visible: _isSelect,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.color_secondary),
            ),
          ),
        ),
        title: Text(
          widget.matchType.typeName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  _isSelect ? AppColors.color_secondary : AppColors.neutral_03),
        ),
      ),
    );
  }
}
