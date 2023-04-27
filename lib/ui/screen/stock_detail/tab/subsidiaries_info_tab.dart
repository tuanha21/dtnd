import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/subsidiaries_model.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../generated/l10n.dart';

class SubsidiariesInfoTab extends StatefulWidget {
  const SubsidiariesInfoTab({
    super.key,
    required this.stockModel,
  });

  final StockModel stockModel;

  @override
  State<SubsidiariesInfoTab> createState() => _SubsidiariesInfoTabState();
}

class _SubsidiariesInfoTabState extends State<SubsidiariesInfoTab> {
  IDataCenterService iDataCenterService = DataCenterService();

  late Future<List<SubsidiariesModel>?> listSubsidiaries;

  late Future<List<SubsidiariesModel>?> associatedCompany;

  late Future<List<SubsidiariesModel>?> other;

  @override
  void initState() {
    listSubsidiaries =
        iDataCenterService.getSubsidiaries(widget.stockModel.stock.stockCode);

    associatedCompany = iDataCenterService
        .getAssociatedCompany(widget.stockModel.stock.stockCode);

    other =
        iDataCenterService.getOtherCompany(widget.stockModel.stock.stockCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.of(context).subsidiaries,
              style:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<SubsidiariesModel>?>(
            future: listSubsidiaries,
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) return const SizedBox();
                var list = snapshot.data!;
                if (list.isNotEmpty) {
                  list.removeWhere((element) => element.ownerShip == 0);
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      var index = list[i];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.neutral_06,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                index.relatedCompanyName ?? "-",
                                style: textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 24 / 16),
                              ),
                            ),
                            Expanded(child: LayoutBuilder(
                              builder: (context, ctx) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${index.charterCapital?.toString() ?? "-"} ${S.of(context).billion_lowercase}",
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: ctx.maxWidth *
                                              index.ownerShip! /
                                              400,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: AppColors.graph_2),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${index.ownerShip?.toStringAsFixed(2) ?? "-"}%",
                                          style: textTheme.labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: list.length);
              }
              return const SizedBox();
            }),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              S.of(context).associated_company,
              style:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<SubsidiariesModel>?>(
            future: associatedCompany,
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) return const SizedBox();
                var list = snapshot.data!;
                if (list.isNotEmpty) {
                  list.removeWhere((element) => element.ownerShip == 0);
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      var index = list[i];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.neutral_06,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                index.relatedCompanyName ?? "-",
                                style: textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 24 / 16),
                              ),
                            ),
                            Expanded(child: LayoutBuilder(
                              builder: (context, ctx) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${index.charterCapital?.toString() ?? "-"} ${S.of(context).billion_lowercase}",
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: ctx.maxWidth *
                                              index.ownerShip! /
                                              400,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: AppColors.graph_2),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${index.ownerShip?.toStringAsFixed(2) ?? "-"}%",
                                          style: textTheme.labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: list.length);
              }
              return const SizedBox();
            }),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              S.of(context).other,
              style:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<SubsidiariesModel>?>(
            future: other,
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) return const SizedBox();
                var list = snapshot.data!;
                if (list.isNotEmpty) {
                  list.removeWhere((element) => element.ownerShip == 0);
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      var index = list[i];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.neutral_06,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                index.relatedCompanyName ?? "-",
                                style: textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 24 / 16),
                              ),
                            ),
                            Expanded(child: LayoutBuilder(
                              builder: (context, ctx) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${index.charterCapital?.toString() ?? "-"} ${S.of(context).billion_lowercase}",
                                      style: textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: ctx.maxWidth *
                                              index.ownerShip! /
                                              400,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: AppColors.graph_2),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${index.ownerShip?.toStringAsFixed(2) ?? "-"}%",
                                          style: textTheme.labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: list.length);
              }
              return const SizedBox();
            }),
        const SizedBox(height: 16),
      ],
    );
  }
}
