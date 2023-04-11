import 'package:dtnd/=models=/response/suggested_signal_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/home/screen/signal/signal_screen.dart';
import 'package:dtnd/ui/screen/home/screen/suggested_signal/component/suggested_signal_component.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

enum _Period { w1, m1, m3, m6 }

extension _PeriodX on _Period {
  String get title {
    switch (this) {
      case _Period.w1:
        return '1W';
      case _Period.m1:
        return "1M";
      case _Period.m3:
        return "3M";
      case _Period.m6:
        return "6M";
      default:
        throw Exception();
    }
  }

  int get period {
    switch (this) {
      case _Period.w1:
        return 7;
      case _Period.m1:
        return 30;
      case _Period.m3:
        return 90;
      case _Period.m6:
        return 180;
      default:
        throw Exception();
    }
  }
}

class SuggestedSignalScreen extends StatefulWidget {
  const SuggestedSignalScreen({super.key});

  @override
  State<SuggestedSignalScreen> createState() => _SuggestedSignalScreenState();
}

class _SuggestedSignalScreenState extends State<SuggestedSignalScreen> {
  final IDataCenterService dataCenterService = DataCenterService();

  late _Period currentPeriod = _Period.m3;
  final List<SuggestedSignalModel> datas = <SuggestedSignalModel>[];
  @override
  void initState() {
    super.initState();
    getData(_Period.values.first);
  }

  Future<void> getData(_Period period) async {
    setState(() {
      currentPeriod = period;
    });
    final listRes = await dataCenterService.getSuggestedSignal(period.period);
    datas.clear();
    datas.addAll(listRes);
    setState(() {});
  }

  void onTap(SuggestedSignalModel model) {
    dataCenterService
        .getStockModelFromStockCode(model.cSHARECODE)
        .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignalScreen(
                code: model.cSHARECODE,
                type: model.cTYPE,
                stockModel: value,
                defaulPeriod: currentPeriod.title,
                defaulday: currentPeriod.period,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppbar(
        title: "Hiệu quả tín hiệu",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: [
                    for (_Period period in _Period.values)
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 6),
                        child: _PeriodButton(
                          period: period,
                          onTap: getData,
                          selectedPeriod: currentPeriod,
                        ),
                      ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (datas.isEmpty)
              const EmptyListWidget()
            else
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (int i = 0; i < datas.length; i++)
                        if (i != 0)
                          Column(
                            children: [
                              const Divider(
                                height: 8,
                              ),
                              SuggestedSignalComponent(
                                  onTap: onTap, data: datas.elementAt(i)),
                            ],
                          )
                        else
                          SuggestedSignalComponent(
                              onTap: onTap, data: datas.elementAt(i)),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton(
      {required this.period,
      required this.selectedPeriod,
      required this.onTap});
  final _Period period;
  final _Period selectedPeriod;
  final ValueChanged<_Period> onTap;
  @override
  Widget build(BuildContext context) {
    return SingleColorTextButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      text: period.title,
      textStyle: AppTextStyle.labelMedium_12.copyWith(
        fontSize: 14,
        color: selectedPeriod == period ? Colors.white : AppColors.primary_01,
      ),
      color: selectedPeriod == period
          ? AppColors.primary_01
          : AppColors.neutral_05,
      onTap: () => onTap.call(period),
    );
  }
}
