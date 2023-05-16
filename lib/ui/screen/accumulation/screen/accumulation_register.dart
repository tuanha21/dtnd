import 'dart:async';

import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/screen/acumulation_confirm.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../widget/row_information.dart';

class AccumulationRegister extends StatefulWidget {
  const AccumulationRegister({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<AccumulationRegister> createState() => _AccumulationRegisterState();
}

class _AccumulationRegisterState extends State<AccumulationRegister> {
  Timer? _timer;

  final AccumulationController _controller = Get.put(AccumulationController());
  late FeeRateModel feeRate = _controller.getItemFeeRate(widget.id);
  final _moneyController = TextEditingController(text: '0');
  late num profit = 0;
  late num sum = 0;
  late num coppyMoney = 0;
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
    _timer = Timer(const Duration(milliseconds: 50), () {
      setState(() {
        profit = (num.parse(_moneyController.text.replaceAll(',', '')) *
            (feeRate.feeRate! / 100));
        sum = num.parse(_moneyController.text.replaceAll(',', '')) + profit;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _moneyController.addListener(_onPasswordTyping);
  }

  @override
  void dispose() {
    _moneyController.removeListener(_onPasswordTyping);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const SimpleAppbar(
        title: 'Đăng ký tích lũy',
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccumulationConfirm(
                        id: widget.id,
                        money: num.parse(
                          _moneyController.text.replaceAll(',', ''),
                        )),
                  ));
            },
            child: const Text('Tiếp tục'),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(TextTheme textTheme, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 5, bottom: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _moneyController,
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(15)],
            onChanged: (string) {
              string = _formatNumber(string.replaceAll(',', ''));
              _moneyController.value = TextEditingValue(
                text: string,
                selection: TextSelection.collapsed(offset: string.length),
              );
            },
            decoration: const InputDecoration(
              labelText: 'Số tiền gốc',
              suffixText: 'đ',
              suffixStyle: TextStyle(color: Colors.grey),
            ),
            onSaved: (value) {},
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 0, top: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lãi suất',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.text_black),
                    ),
                    Text('${feeRate.feeRate.toString()}%/năm',
                        style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.text_blue)),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral_06,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RowInfomation(
                          leftText: 'Lãi dự tính',
                          rightText: NumUtils.formatInteger(profit),
                          differentColor: true,
                        ),
                        RowInfomation(
                            leftText: 'Tổng tiền gốc và lãi',
                            rightText: NumUtils.formatInteger(sum)),
                      ]),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Cộng đồng IFIS thường hay chọn',
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              )),
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
                                        : Colors.transparent)),
                            child: Text('${_textMethod[index]}đ',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: _selectedMethod[index] == true
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ))),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
