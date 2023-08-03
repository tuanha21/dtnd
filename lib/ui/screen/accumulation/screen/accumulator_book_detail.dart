import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/widget/settlement_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/service/app_services.dart';
import '../widget/row_information.dart';

class AccumulatorBookDetail extends StatefulWidget {
  const AccumulatorBookDetail(
      {super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  State<AccumulatorBookDetail> createState() => _AccumulatorBookDetailState();
}

class _AccumulatorBookDetailState extends State<AccumulatorBookDetail> {
  final AccumulationController _controller = Get.put(AccumulationController());
  late ContractModel contract = _controller.getItemContract(widget.id);

  @override
  void initState() {
    super.initState();
    _controller.getSingleContract(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(
        title: widget.name,
      ),
      body: SingleChildScrollView(
        child: bodyWidget(textTheme, context),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 32),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: 48,
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.text_blue),
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return SettlementDialog(id: widget.id);
                },
              );
            },
            child: Text(S.of(context).final_settlement),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(TextTheme textTheme, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 5, bottom: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 0, top: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        S.of(context).accumulated_code,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.neutral_05),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        contract.contractCode.toString(),
                        textAlign: TextAlign.right,
                        softWrap: true,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RowInfomation(
                    leftText: S.of(context).profit,
                    rightText: '${contract.feeRate}%/năm'),
                RowInfomation(
                  leftText: S.of(context).expected_profit,
                  rightText: "${NumUtils.formatInteger(contract.fee)}đ",
                  differentColor: true,
                ),
                RowInfomation(
                  leftText: S.of(context).total_principal_and_interest,
                  rightText:
                      '${NumUtils.formatInteger(contract.currentValue)}đ',
                ),
                RowInfomation(
                    leftText: S.of(context).period,
                    rightText: contract.termName.toString()),
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).start_date,
                            style: textTheme.bodySmall
                                ?.copyWith(color: AppColors.neutral_05),
                          ),
                          Text(S.of(context).end_date,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutral_05)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(contract.openDate.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(contract.expiredDate.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 90,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).renewal_method,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral_05,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Obx(
                      () => Text(_controller.renewalMethod.value,
                          style: textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: AppColors.primary_03,
                      ),
                      onPressed: () {
                        openChangeMethod(context);
                      },
                      child: Text(
                        S.of(context).change,
                        style: textTheme.bodySmall?.copyWith(
                            color: AppColors.linear_01,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RowInfomation(
                    leftText: S.of(context).current_pre_maturity_interest,
                    rightText:
                        '${_controller.singleContract.value?.cLIQUIDRATE}%/năm'),
                const SizedBox(height: 4),
                Text(
                    NumUtils.formatDouble(
                                _controller.singleContract.value?.cLIQUIDFEE) ==
                            "0.0"
                        ? '0đ'
                        : '${_controller.singleContract.value?.cLIQUIDFEE}đ',
                    style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openChangeMethod(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final List<Map<String, dynamic>> methodList = [
          {
            'selected': _controller.singleContract.value?.cEXTENTNAME ==
                    "Tự động gia hạn gốc + lãi"
                ? true
                : false,
            'text': "Tự động gia hạn gốc + lãi",
          },
          {
            'selected': _controller.singleContract.value?.cEXTENTNAME ==
                    "Tự động gia hạn gốc"
                ? true
                : false,
            'text': "Tự động gia hạn gốc",
          },
          {
            'selected': _controller.singleContract.value?.cEXTENTNAME ==
                    "Không tự động gia hạn"
                ? true
                : false,
            'text': "Không tự động gia hạn",
          },
        ];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateSheet) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    S.of(context).choose_renewal_method,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: methodList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setStateSheet(
                              () {
                                for (int i = 0; i < methodList.length; i++) {
                                  if (i == index) {
                                    methodList[i]['selected'] = true;
                                  } else {
                                    methodList[i]['selected'] = false;
                                  }
                                }
                                switch (methodList[index]['text']) {
                                  case "Tự động gia hạn gốc + lãi":
                                    _controller.methodUpdate(
                                        widget.id, 'LAI_NHAP_GOC');
                                    break;
                                  case "Tự động gia hạn gốc":
                                    _controller.methodUpdate(
                                        widget.id, 'NGUYEN_GOC');
                                    break;
                                  case "Không tự động gia hạn":
                                    _controller.methodUpdate(
                                        widget.id, 'KHONG_GIA_HAN');
                                    break;
                                  default:
                                }
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                color: themeMode.isLight ? AppColors.neutral_07 : AppColors.neutral_01,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: methodList[index]['selected'] == true
                                        ? AppColors.primary_01
                                        : Colors.transparent)),
                            child: Text(
                              methodList[index]['text'],
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight:
                                    methodList[index]['selected'] == true
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(
      () {
        _controller.getSingleContract(widget.id);
      },
    );
  }
}
