import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/company_info.dart';
import '../../../theme/app_color.dart';

class IndexWidget extends StatefulWidget {
  final StockModel stockModel;

  const IndexWidget({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<IndexWidget> createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> {
  final INetworkService networkService = NetworkService();
  late Future<CompanyInfo> companyInfo;

  @override
  void initState() {
    companyInfo =
        networkService.getCompanyInfo(widget.stockModel.stockData.sym);
    networkService.getStockInfo(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyInfo>(
        future: companyInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var info = snapshot.data;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: AppColors.neutral_03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Visibility(
                          visible: info?.isMargin == true,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: AppColors.neutral_05)),
                              child: Text(
                                'Margin',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.light_bg),
                              ))),
                      Visibility(
                          visible: info?.isFTSE == true,
                          child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: AppColors.neutral_05)),
                              child: Text(
                                'FTSE',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.light_bg),
                              ))),
                      Visibility(
                          visible: info?.isVNMETF == true,
                          child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: AppColors.neutral_05)),
                              child: Text(
                                'VNMETF',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.light_bg),
                              ))),
                      Visibility(
                          visible: info?.isVN30 == true,
                          child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: AppColors.neutral_05)),
                              child: Text(
                                'VN30',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.light_bg),
                              )))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: boxData(
                              "KLNN Mua",
                              NumUtils.formatInteger(
                                  widget.stockModel.stockData.fBVol.value))),
                      const SizedBox(width: 5),
                      Expanded(
                          child: boxData(
                              "KLNN Bán",
                              NumUtils.formatInteger(
                                  widget.stockModel.stockData.fSVolume.value))),
                      const SizedBox(width: 5),
                      Expanded(
                          child: boxData("SD khả dụng",
                              "${NumUtils.formatInteger(widget.stockModel.stockData.fSValue.value)}đ"))
                    ],
                  ),
                  const SizedBox(height: 5),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                            child: boxData1(
                          value1: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                          value2: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                          value3: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                        )),
                        const SizedBox(width: 5),
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: boxData("KL khả dụng",
                                      "${NumUtils.formatInteger(widget.stockModel.stockData.fBValue.value)}đ"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1),
                            Row(
                              children: [
                                Expanded(
                                  child: boxData("KL khác",
                                      "${NumUtils.formatInteger(widget.stockModel.stockData.fBValue.value)}đ"),
                                ),
                              ],
                            ),
                          ],
                        )),
                        const SizedBox(width: 5),
                        Expanded(
                            child: boxData2(
                          value1: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                          value2: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                          value3: NumUtils.formatInteger(
                              widget.stockModel.stockData.lot.value),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget boxData(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral_04, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget boxData1(
      {required String value1,
      required String value2,
      required String value3}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Khối lượng",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral_04, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng KL",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value1,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "KL thường",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "KL FS",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value3,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget boxData2(
      {required String value1,
      required String value2,
      required String value3}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "KL mua trở về",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral_04, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "T0",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value1,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "T1",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "T2",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.neutral_04),
              ),
              Text(
                value3,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          )
        ],
      ),
    );
  }
}
