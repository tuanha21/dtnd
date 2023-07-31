import 'dart:async';

import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/screen/acumulation_confirm.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../=models=/response/accumulation/fee_rate_model.dart';
import '../widget/row_information.dart';

class AccumulationRegister extends StatefulWidget {
  const AccumulationRegister({
    Key? key,
    required this.id,
    required this.capMin,
    required this.capMax,
  }) : super(key: key);

  final String id;
  final num capMax;
  final num capMin;

  @override
  State<AccumulationRegister> createState() => _AccumulationRegisterState();
}

class _AccumulationRegisterState extends State<AccumulationRegister> {
  Timer? _timer;

  final AccumulationController _controller = Get.put(AccumulationController());
  late FeeRateModel feeRate;
  final _moneyController = TextEditingController();
  late num profit;
  late num sum;
  late num copyMoney;
  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  final List<bool> _selectedMethod = <bool>[false, false, false];
  final List<String> _textMethod = <String>[
    '1,000,000',
    '5,000,000',
    '50,000,000'
  ];

  void _onPasswordTyping() {
    if (_timer != null) {
      _timer!.cancel();
    }

    if (_moneyController.text.isNotEmpty) {
      _timer = Timer(const Duration(milliseconds: 50), () {
        setState(() {
          profit = (num.parse(_moneyController.text.replaceAll(',', '')) *
              (feeRate.feeRate! / 100));
          sum = num.parse(_moneyController.text.replaceAll(',', '')) + profit;
        });
      });
    }
  }

  @override
  void initState() {
    feeRate = _controller.getItemFeeRate(widget.id);
    profit = 0;
    sum = 0;
    copyMoney = 0;
    _controller.contractFee.value?.cCASHVALUE = 0;
    _controller.contractFee.value?.cFEEVALUE = 0;
    super.initState();
    _moneyController.addListener(_onPasswordTyping);
  }

  @override
  void dispose() {
    _moneyController.removeListener(_onPasswordTyping);
    _controller.contractFee.value?.cCASHVALUE = 0;
    _controller.contractFee.value?.cFEEVALUE = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).registration_for_accumulation,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 5, bottom: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  onTapOutside: (value) {
                    _controller.getProvisionalFee(feeRate.termCode ?? '',
                        _moneyController.text.replaceAll(',', ''));
                  },
                  controller: _moneyController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).please_fill_in_this_field;
                    } else {
                      double? parsedValue =
                          double.tryParse(value.replaceAll(',', ''));
                      if (parsedValue == null) {
                        return '${S.of(context).enter_the_word} ${NumUtils.formatInteger(widget.capMin)} ${S.of(context).to} ${NumUtils.formatInteger(widget.capMax)}';
                      } else if (parsedValue < widget.capMin ||
                          parsedValue > widget.capMax) {
                        return '${S.of(context).enter_the_word} ${NumUtils.formatInteger(widget.capMin)} ${S.of(context).to} ${NumUtils.formatInteger(widget.capMax)}';
                      }
                    }
                    return null;
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      value = _formatNumber(value.replaceAll(',', ''));
                      _moneyController.value = TextEditingValue(
                        text: value,
                        selection:
                            TextSelection.collapsed(offset: value.length),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    labelText: S.of(context).the_principal_amount,
                    suffixText: 'đ',
                    suffixStyle: const TextStyle(color: Colors.grey),
                    hintText: S.of(context).input_the_amount,
                  ),
                  onFieldSubmitted: (value) {
                    _controller.getProvisionalFee(feeRate.termCode ?? '',
                        _moneyController.text.replaceAll(',', ''));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 0,
                  top: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).profit,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.text_black),
                        ),
                        Text(
                          '${feeRate.feeRate.toString()}%/${S.of(context).year}',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.text_blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        top: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.neutral_06,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(
                        () {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RowInfomation(
                                leftText: S.of(context).expected_profit,
                                rightText:
                                    "+${NumUtils.formatInteger(_controller.contractFee.value?.cFEEVALUE)}đ",
                                differentColor: true,
                              ),
                              RowInfomation(
                                leftText:
                                    S.of(context).total_principal_and_interest,
                                rightText:
                                    "${NumUtils.formatInteger((_controller.contractFee.value?.cCASHVALUE ?? 0) + (_controller.contractFee.value?.cFEEVALUE ?? 0))}đ",
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                S.of(context).the_IFIS_community_often_prefers,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 58,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 30);
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _selectedMethod.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              for (int i = 0; i < _selectedMethod.length; i++) {
                                if (i == index) {
                                  _selectedMethod[i] = true;
                                  _moneyController.text = _textMethod[i];
                                  _controller.getProvisionalFee(
                                    feeRate.termCode ?? '',
                                    _moneyController.text.replaceAll(',', ''),
                                  );
                                } else {
                                  _selectedMethod[i] = false;
                                }
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 375 * 95,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedMethod[index] == true
                                    ? AppColors.primary_01
                                    : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              '${_textMethod[index]}đ',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: _selectedMethod[index] == true
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
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 32),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 48,
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.text_blue),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccumulationConfirm(
                    id: widget.id,
                    money: num.parse(
                      _moneyController.text.replaceAll(',', ''),
                    ),
                    openDay: _controller.contractFee.value?.cOPENDATE ?? '',
                    endDay: _controller.contractFee.value?.cEXPIREDATE ?? '',
                  ),
                ),
              );
            },
            child: Text(S.of(context).next),
          ),
        ),
      ),
    );
  }
}
