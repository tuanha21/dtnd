import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/accumulation/screen/acumulation_confirm.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../widget/row_information.dart';

class AccumulationRegister extends StatefulWidget {
  const AccumulationRegister({
    super.key,
  });

  @override
  State<AccumulationRegister> createState() => _AccumulationRegisterState();
}

class _AccumulationRegisterState extends State<AccumulationRegister> {
  final _moneyController = TextEditingController();
  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  final List<bool> _selectedMethod = <bool>[false, false, false];
  final List<String> _textMethod = <String>[
    '1,000,000',
    '5,000,000',
    '50,000,000'
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).registration_for_accumulation,
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
                    builder: (context) => const AccumulationConfirm()),
              );
            },
            child: Text(S.of(context).next),
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
            decoration: InputDecoration(
              labelText: S.of(context).the_principal_amount,
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
                      S.of(context).profit,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.text_black),
                    ),
                    Text('5.5%/năm',
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
                          leftText: S.of(context).expected_profit,
                          rightText: '+45,205đ',
                          differentColor: true,
                        ),
                        RowInfomation(
                            leftText:
                                S.of(context).total_principal_and_interest,
                            rightText: '10,045,205đ'),
                      ]),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(S.of(context).the_IFIS_community_often_prefers,
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
