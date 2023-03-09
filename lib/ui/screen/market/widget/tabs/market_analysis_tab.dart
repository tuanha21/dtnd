import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../=models=/index.dart';
import '../../../../../=models=/response/indContrib.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../generated/l10n.dart';
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
    piValue = dataCenterService.getPIvalue(indexSelect.market);
    fiValue = dataCenterService.getFIvalue(indexSelect.market);
    indFvalue = dataCenterService.getIndFvalue(indexSelect.market);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  Index indexSelect = Index.VNI;
  // bool _isPT = false;

  // void onChangedPT(bool? val) {
  //   setState(() {
  //     _isPT = val ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      children: [
        const SizedBox(height: 16),
        Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.light_bg),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.neutral_06),
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
                                      "Cá nhân",
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

                                  var totalBuy = double.parse(
                                          (piValue.totalBuy ?? '0')
                                              .replaceAll(RegExp(r','), '')) +
                                      double.parse((fiValue.totalBuy ?? '0')
                                          .replaceAll(RegExp(r','), ''));
                                  var totalSell = double.parse(
                                          (piValue.totalSell ?? '0')
                                              .replaceAll(RegExp(r','), '')) +
                                      double.parse((fiValue.totalSell ?? '0')
                                          .replaceAll(RegExp(r','), ''));
                                  return Text(
                                    '${NumUtils.formatDouble((totalSell - totalBuy))} Tỷ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary_02,
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
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.neutral_06),
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
                                      "Tự doanh",
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

                                  var piTotal = double.parse(
                                          (piValue.totalBuy ?? '0')
                                              .replaceAll(RegExp(r','), '')) -
                                      double.parse((piValue.totalSell ?? '0')
                                          .replaceAll(RegExp(r','), ''));
                                  return Text(
                                    '${NumUtils.formatDouble(piTotal)} Tỷ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary_02,
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
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.neutral_06),
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
                                      "Nước ngoài",
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
                                  var piTotal = double.parse(
                                          (piValue.totalBuy ?? '0')
                                              .replaceAll(RegExp(r','), '')) -
                                      double.parse((piValue.totalSell ?? '0')
                                          .replaceAll(RegExp(r','), ''));
                                  return Text(
                                    '${NumUtils.formatDouble(piTotal)} Tỷ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary_02,
                                            fontSize: 16),
                                  );
                                },
                              ),
                              const SizedBox(height: 4),
                            ])),
                  ),
                ]))),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Top mã tự doanh mua ròng',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            GestureDetector(
              onTap: () async {
                var index = await showCupertinoModalPopup<Index>(
                    context: context,
                    builder: (context) {
                      return BottomSheet(index: indexSelect);
                    });
                if (index != null) {
                  indexSelect = index;
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
  final Index? index;

  const BottomSheet({Key? key, this.index}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  Index? indexSelected;

  @override
  void initState() {
    indexSelected = widget.index;
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
                  "Sàn chứng khoán",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: Index.values
                    .map((index) => CheckBoxMarket(
                          key: UniqueKey(),
                          index: index,
                          indexInit: indexSelected,
                          onChanged: (Index index) {
                            setState(() {
                              indexSelected = index;
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
                        Navigator.pop(context, indexSelected);
                      },
                      child: const Text("Áp dụng")),
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
