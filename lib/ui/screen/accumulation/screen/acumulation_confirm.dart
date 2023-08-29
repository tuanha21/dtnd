import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/widget/accumulation_dialog.dart';
import 'package:dtnd/ui/screen/accumulation/widget/error_register_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/service/app_services.dart';
import '../../../../generated/l10n.dart';
import '../widget/row_information.dart';

class AccumulationConfirm extends StatefulWidget {
  const AccumulationConfirm({
    super.key,
    required this.id,
    required this.money,
    required this.openDay,
    required this.endDay,
  });

  final String id;
  final num money;
  final String openDay;
  final String endDay;

  @override
  State<AccumulationConfirm> createState() => _AccumulationConfirmState();
}

class _AccumulationConfirmState extends State<AccumulationConfirm> {
  final AccumulationController _controller = Get.put(AccumulationController());
  late FeeRateModel feeRate = _controller.getItemFeeRate(widget.id);
  final List<bool> _selectedMethod = <bool>[true, false, false];
  final IUserService userService = UserService();
  late UserInfo userInfo;

  final List<String> _textMethod = <String>[
    'Tự động gia hạn gốc + lãi',
    'Tự động gia hạn gốc',
    'Không tự động gia hạn'
  ];
  late String _method = _textMethod.first;
  final DateTime nowDate = DateTime.now();

  String getFutureDay() {
    DateTime futureDate =
        nowDate.add(Duration(days: int.parse(feeRate.termCode ?? '1')));
    return DateFormat('dd/MM/yyyy').format(futureDate);
  }

  String getToDay() {
    return DateFormat('dd/MM/yyyy').format(nowDate);
  }

  String getExtendType() {
    if (_method == _textMethod.first) {
      return 'LAI_NHAP_GOC';
    } else if (_method == _textMethod[1]) {
      return 'NGUYEN_GOC';
    }
    return 'KHONG_GIA_HAN';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).confirm_savings,
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
            onPressed: () async {
              try {
                await userService.updateContract(
                    feeRate.termCode!, widget.money, getExtendType());
                if (!mounted) return;
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AccumulationDialog(
                    content: S
                        .of(context)
                        .you_have_completed_the_cumulative_registration,
                    title: S.of(context).successfully_registered,
                  ),
                );
              } catch (e) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => ErrorRegisterDialog(
                    error: e.toString(),
                  ),
                );
              }
              // if (updateSuccess) {
              //   if (!mounted) return;
              //   showDialog(
              //       barrierDismissible: false,
              //       context: context,
              //       builder: (_) => const AccumulationDialog());
              // } else {
              //   if (!mounted) return;
              //   showDialog(
              //       barrierDismissible: false,
              //       context: context,
              //       builder: (_) => const ErrorRegisterDialog());
              // }
            },
            child: Text(S.of(context).confirm),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(TextTheme textTheme, BuildContext context) {
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
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 0, top: 16),
            child: Column(
              children: [
                RowInfomation(
                    leftText: S.of(context).product,
                    rightText: feeRate.productName.toString()),
                RowInfomation(
                  leftText: S.of(context).profit,
                  rightText: '${feeRate.feeRate.toString()}%/${S.of(context).year}',
                ),
                RowInfomation(
                    leftText: S.of(context).period,
                    rightText: feeRate.termName.toString()),
                RowInfomation(
                    leftText: S.of(context).start_date,
                    rightText: widget.openDay),
                RowInfomation(
                    leftText: S.of(context).end_date, rightText: widget.endDay),
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
                      color: themeMode.isLight ? AppColors.neutral_02 : AppColors.neutral_05,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(_method,
                        style: textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
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
                    leftText: S.of(context).total_amount,
                    rightText: '${NumUtils.formatInteger(widget.money)}đ'),
                const SizedBox(height: 4),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: themeMode.isLight ? AppColors.neutral_06 : AppColors.neutral_02,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).payment_required,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: themeMode.isLight ? AppColors.neutral_02 : AppColors.neutral_07),
                      ),
                      Text('${NumUtils.formatInteger(widget.money)}đ',
                          style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: themeMode.isLight ? AppColors.text_black : AppColors.neutral_07)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openChangeMethod(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
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
                    itemCount: _selectedMethod.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setStateSheet(
                            () {
                              for (int i = 0; i < _selectedMethod.length; i++) {
                                if (i == index) {
                                  _selectedMethod[i] = true;
                                } else {
                                  _selectedMethod[i] = false;
                                }
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
                              color: themeMode.isLight ? Colors.white : AppColors.bg_share_inside_nav,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: _selectedMethod[index] == true
                                      ? AppColors.primary_01
                                      : Colors.transparent)),
                          child: Text(
                            _textMethod[index],
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
          );
        });
      },
    ).whenComplete(() {
      String method = '';
      for (int i = 0; i < _selectedMethod.length; i++) {
        if (_selectedMethod[i] == true) {
          method = _textMethod[i];
        }
      }
      setState(() {
        _method = method;
      });
    });
  }
}
