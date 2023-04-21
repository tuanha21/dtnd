import 'package:dtnd/=models=/algo/match_type.dart';
import 'package:dtnd/=models=/algo/org_filter.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/indContrib.dart';
import 'package:dtnd/=models=/response/index_board.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';
import '../components/liquidity_chart.dart';
import '../components/money_chart.dart';
import '../components/top_index_widget.dart';

class MarketIndustryTab extends StatefulWidget {
  const MarketIndustryTab({super.key});

  @override
  State<MarketIndustryTab> createState() => _MarketIndustryTabState();
}

class _MarketIndustryTabState extends State<MarketIndustryTab>
    with AutomaticKeepAliveClientMixin {
  final IDataCenterService dataCenterService = DataCenterService();

  // late Future<List<TopInfluenceModel>> topInfluenceList;
  late Future<List<IndexBoard>> indexBoard;
  late Future<LiquidityModel> liquidityModel;
  late Future<IndContrib> topIndex;

  late Future<IndContrib> indFvalue;

  OrgFilter orgFilter =
      OrgFilter(filterInd: Index.VNI, filterOrg: MatchType.Match);

  void initData() {
    // topInfluenceList = dataCenterService.getTopInfluence(orgFilter.filterInd);
    indexBoard =
        dataCenterService.getIndexBoard(orgFilter.filterInd.exchangeName);
    liquidityModel = dataCenterService.getLiquidity(orgFilter.filterInd);
    topIndex = dataCenterService.getIndContrib(orgFilter.filterInd.market);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).liquidity,
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
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.light_bg,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            '${S.of(context).chart_comparing_the_cash}${TimeUtilities.parseDateToString(DateTime.now())}',
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
        //TopInfluenceChart(topInfluenceList: topInfluenceList),
        LiquidityChart(liquidityModel: liquidityModel),
        MoneyChart(indexBoard: indexBoard),
        TopIndexWidgetChart(topIndex: topIndex),
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
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.light_bg,
            borderRadius: BorderRadius.only(
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
                        child: const Icon(Icons.clear,
                            color: AppColors.text_black)),
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
    return Material(
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
    return Material(
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
