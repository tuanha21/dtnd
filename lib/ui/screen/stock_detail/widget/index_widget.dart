import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/stock_report_res.dart';
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

  late Future<StockReportRes> stockReport;

  @override
  void initState() {
    companyInfo =
        networkService.getCompanyInfo(widget.stockModel.stockData.sym);
    stockReport = networkService.getStockInfo(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.neutral_03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<CompanyInfo>(
              future: companyInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var info = snapshot.data;

                  return Row(
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
                  );
                }
                return const SizedBox();
              }),
          const SizedBox(height: 10),
          FutureBuilder<StockReportRes>(
              future: stockReport,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data!.content!;
                  var lnRong = list.firstWhere((element) => element.iD == 54);

                  var eps = list.firstWhere((element) => element.iD == 1);
                  var tongNoVCSH =
                      list.firstWhere((element) => element.iD == 46);
                  var roe = list.firstWhere((element) => element.iD == 14);

                  var pe = list.firstWhere((element) => element.iD == 3);
                  var tongNoTS = list.firstWhere((element) => element.iD == 42);
                  var roa = list.firstWhere((element) => element.iD == 16);

                  var pb = list.firstWhere((element) => element.iD == 4);
                  var thanhToan =
                      list.firstWhere((element) => element.iD == 55);
                  var tyXuatLN = list.firstWhere((element) => element.iD == 10);

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: boxData(
                                  "KLNN Mua",
                                  NumUtils.formatInteger(widget
                                      .stockModel.stockData.fBVol.value))),
                          const SizedBox(width: 5),
                          Expanded(
                              child: boxData(
                                  "KLNN Bán",
                                  NumUtils.formatInteger(widget
                                      .stockModel.stockData.fSVolume.value))),
                          const SizedBox(width: 5),
                          Expanded(
                              child: boxData("Biên LN ròng",
                                  "${NumUtils.formatInteger(lnRong.value1)}%"))
                        ],
                      ),
                      const SizedBox(height: 5),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: boxData1(
                              value1: NumUtils.formatInteger(eps.value1),
                              value2: NumUtils.formatInteger(tongNoVCSH.value1),
                              value3: "${NumUtils.formatInteger(roe.value1)}%",
                            )),
                            const SizedBox(width: 5),
                            Expanded(
                                child: boxData2(
                              value1: NumUtils.formatInteger(pe.value1),
                              value2: NumUtils.formatInteger(tongNoTS.value1),
                              value3: "${NumUtils.formatInteger(roa.value1)}%",
                            )),
                            const SizedBox(width: 5),
                            Expanded(
                                child: boxData3(
                              value1: NumUtils.formatInteger(pb.value1),
                              value2: NumUtils.formatInteger(thanhToan.value1),
                              value3:
                                  "${NumUtils.formatInteger(tyXuatLN.value1)}%",
                            ))
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              })
        ],
      ),
    );
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

  Widget columnData(String title, String value){
    return Column(
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
          columnData("EPS", value1),
          const SizedBox(height: 5),
          columnData("Tổng nợ/VCSH", value2),
          const SizedBox(height: 5),
          columnData("ROE", value3),
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
          columnData("PE", value1),
          const SizedBox(height: 5),
          columnData("Tổng nợ/Tổng TS", value2),
          const SizedBox(height: 5),
          columnData("ROA", value3),
        ],
      ),
    );
  }

  Widget boxData3(
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
          columnData("PB", value1),
          const SizedBox(height: 5),
          columnData("Thanh toán", value2),
          const SizedBox(height: 5),
          columnData("Tỷ suất LN gộp", value3),
        ],
      ),
    );
  }
}
