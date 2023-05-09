import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';
import '../widget/row_information.dart';

class AccumulatorBookDetail extends StatefulWidget {
  const AccumulatorBookDetail({super.key, required this.name});
  final String name;

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
            onPressed: () {},
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
                RowInfomation(
                    leftText: 'Mã tích lũy ',
                    rightText: '04FC711301F3C784D6695'),
                RowInfomation(leftText: 'Lãi suất', rightText: '5.5%/năm'),
                RowInfomation(
                  leftText: 'Lãi dự tính',
                  rightText: '+45,205đ',
                  differentColor: true,
                ),
                RowInfomation(
                    leftText: 'Tổng tiền gốc và lãi', rightText: '10,045,205đ'),
                RowInfomation(leftText: 'Kỳ hạn', rightText: '1 tháng'),
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
                          children: const [
                            Text('05/05/2023',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('04/06/2023',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )
                      ]),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.primary_03,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Xem lịch sử giao dịch',
                      style: textTheme.bodySmall?.copyWith(
                          color: AppColors.primary_04,
                          fontWeight: FontWeight.w600)),
                  const Icon(
                    Icons.arrow_right,
                    color: AppColors.primary_01,
                    size: 24.0,
                  ),
                ],
              )),
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
                      rightText: '1.2%/năm'),
                  const SizedBox(height: 4),
                  Text('789đ',
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
