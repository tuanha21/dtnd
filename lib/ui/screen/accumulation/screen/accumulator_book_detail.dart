import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/ui/screen/accumulation/controller/accumulation_controller.dart';
import 'package:dtnd/ui/screen/accumulation/widget/settlement_dialog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final List<bool> _selectedMethod = <bool>[true, false, false];
  final List<String> _textMethod = <String>[
    'Tự động gia hạn gốc và lãi',
    'Tự động gia hạn gốc',
    'Không tự động gia hạn'
  ];
  late String _method = 'Tự động gia hạn gốc và lãi';
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
                  });
            },
            child: const Text('Tất toán'),
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
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
                        'Mã tích luỹ',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.neutral_02),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(contract.contractCode.toString(),
                          textAlign: TextAlign.right,
                          softWrap: true,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RowInfomation(
                    leftText: 'Lãi suất',
                    rightText: '${contract.feeRate}%/năm'),
                RowInfomation(
                  leftText: 'Lãi dự tính',
                  rightText: "${NumUtils.formatInteger(contract.fee)}đ",
                  differentColor: true,
                ),
                RowInfomation(
                  leftText: 'Tổng tiền gốc và lãi',
                  rightText:
                      '${NumUtils.formatInteger(contract.currentValue)}đ',
                ),
                RowInfomation(
                    leftText: 'Kỳ hạn',
                    rightText: contract.termName.toString()),
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral_06,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ngày bắt đầu',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutral_04),
                            ),
                            Text('Ngày kết thúc',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: AppColors.neutral_04)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(contract.openDate.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(contract.expiredDate.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ]),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Container(
          //     height: 40,
          //     decoration: const BoxDecoration(
          //       color: AppColors.primary_03,
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(12),
          //           bottomRight: Radius.circular(12)),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text('Xem lịch sử giao dịch',
          //             style: textTheme.bodySmall?.copyWith(
          //                 color: AppColors.primary_04,
          //                 fontWeight: FontWeight.w600)),
          //         const Icon(
          //           Icons.arrow_right,
          //           color: AppColors.primary_01,
          //           size: 24.0,
          //         ),
          //       ],
          //     )),
          const SizedBox(height: 24),
          Container(
              height: 90,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Phương thức gia hạn',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.neutral_02,
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
                          'Thay đổi',
                          style: textTheme.bodySmall?.copyWith(
                              color: AppColors.linear_01,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 24),
          Container(
              height: 80,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowInfomation(
                      leftText: 'Lãi hiện tại trước hạn',
                      rightText:
                          '${_controller.singleContract?.cLIQUIDRATE}%/năm'),
                  const SizedBox(height: 4),
                  Text('${_controller.singleContract?.cLIQUIDFEE}đ',
                      style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.semantic_01)),
                ],
              )),
        ],
      ),
    );
  }

  Future<void> openChangeMethod(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                Text('Chọn phương thức gia hạn',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _selectedMethod.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setStateSheet(() {
                              for (int i = 0; i < _selectedMethod.length; i++) {
                                if (i == index) {
                                  _selectedMethod[i] = true;
                                } else {
                                  _selectedMethod[i] = false;
                                }
                              }
                            });
                          },
                          child: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: _selectedMethod[index] == true
                                          ? AppColors.primary_01
                                          : Colors.transparent)),
                              child: Text(_textMethod[index],
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
