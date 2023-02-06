import 'dart:math';

import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/controller/industry_tab_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../../=models=/response/stock_data.dart';
import '../../../../../data/i_data_center_service.dart';
import '../../../../../data/implementations/data_center_service.dart';
import 'industry_detail_page.dart';

class IndustryInfoWidget extends StatefulWidget {
  const IndustryInfoWidget({super.key});

  @override
  State<IndustryInfoWidget> createState() => _IndustryInfoWidgetState();
}

class _IndustryInfoWidgetState extends State<IndustryInfoWidget> {
  final TextEditingController searchController = TextEditingController();
  final IDataCenterService dataCenterService = DataCenterService();

  MapEntry<String, dynamic>? industry;

  late Future<List<List<String>>> getCodeIndustry;

  @override
  void initState() {
    super.initState();
    getCodeIndustry = Future.wait(listIndustry.entries
        .map((e) => dataCenterService.getSectors(e.key))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchWidget,
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<List<List<String>>>(
              future: getCodeIndustry,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data;
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return IndustryWidget(
                          key: ObjectKey(snapshot.data![index]),
                          listStock: snapshot.data![index],
                          title: industry?.value ??
                              listIndustry.entries.toList()[index].value,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: list!.length);
                }
                return const SizedBox();
              }),
        ),
        // const SizedBox(height: 16),
        // Container(
        //   padding: const EdgeInsets.all(16),
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(8)),
        //     color: Colors.white,
        //   ),
        //   child: Column(
        //     children: [
        //       for (int i = 0; i < (currentIndustry?.stocks.length ?? 0); i++)
        //         Builder(builder: (context) {
        //           Widget row = Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 16),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Expanded(
        //                   child: Row(
        //                     children: [
        //                       Text(currentIndustry!.stocks
        //                           .elementAt(i)
        //                           .sTOCKCODE ??
        //                           ""),
        //                       const SizedBox(width: 8),
        //                       Text(
        //                           "(${currentIndustry!.stocks.elementAt(i).stock.postTo?.name ?? ""})"),
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 80,
        //                   child: Align(
        //                     alignment: Alignment.centerRight,
        //                     child: Text(currentIndustry!.stocks
        //                         .elementAt(i)
        //                         .lASTPRICE
        //                         .toString()),
        //                   ),
        //                 ),
        //                 Expanded(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: [
        //                       Text(currentIndustry!.stocks
        //                           .elementAt(i)
        //                           .cHANGE
        //                           .toString()),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //           if (i == 0) {
        //             return row;
        //           } else {
        //             return Column(
        //               children: [const Divider(), row],
        //             );
        //           }
        //         }),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget get searchWidget {
    return TypeAheadField<MapEntry<String, dynamic>>(
        textFieldConfiguration: TextFieldConfiguration(
            controller: searchController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  industry = null;
                  getCodeIndustry = Future.wait(listIndustry.entries
                      .map((e) => dataCenterService.getSectors(e.key))
                      .toList());
                });
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.neutral_06,
                enabledBorder: InputBorder.none,
                hintText: 'Tìm ngành..',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    AppImages.search_appbar_icon,
                    height: 24,
                    width: 24,
                  ),
                ))),
        suggestionsCallback: (text) async {
          return listIndustry.entries.toList().where((element) =>
              element.value.toLowerCase().contains(text.toLowerCase()));
        },
        itemBuilder: (context, industry) {
          return ListTile(
            title: Text(industry.value),
          );
        },
        onSuggestionSelected: (suggestion) {
          searchController.text = suggestion.value;
          industry = suggestion;
          setState(() {
            getCodeIndustry =
                Future.wait([dataCenterService.getSectors(industry!.key)]);
          });
        },
        noItemsFoundBuilder: (context) {
          return ListTile(
              title: Text(
            'Ngành không hợp lệ',
            style: TextStyle(
                color: Theme.of(context).disabledColor, fontSize: 18.0),
          ));
        });
  }
}

class IndustryWidget extends StatefulWidget {
  final List<String> listStock;
  final String title;

  const IndustryWidget({Key? key, required this.listStock, required this.title})
      : super(key: key);

  @override
  State<IndustryWidget> createState() => _IndustryWidgetState();
}

class _IndustryWidgetState extends State<IndustryWidget> {
  final IDataCenterService dataCenterService = DataCenterService();
  late Future<List<StockData>> listStock;

  @override
  void initState() {
    listStock = dataCenterService.getListStockData(widget.listStock);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StockData>>(
        future: listStock,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var list = snapshot.data;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IndustryDetailPage(
                        listStock: list!, title: widget.title)));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child:
                                    Image.network("https://picsum.photos/44")),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${list!.length} mã',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColors.neutral_04),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         currentIndustry!.tOTALKLGD.toString(),
                    //         style: textTheme.titleSmall,
                    //       ),
                    //       Builder(builder: (context) {
                    //         final per = Random().nextDouble() * 2 - 1;
                    //         Widget pre;
                    //         Color color;
                    //         if (per >= 0) {
                    //           pre = Image.asset(
                    //             AppImages.prefix_up_icon,
                    //             width: 12,
                    //           );
                    //           color = AppColors.semantic_01;
                    //         } else {
                    //           pre = Image.asset(
                    //             AppImages.prefix_down_icon,
                    //             width: 12,
                    //           );
                    //           color = AppColors.semantic_03;
                    //         }
                    //         return Row(
                    //           children: [
                    //             pre,
                    //             Text(
                    //               "${per.toStringAsPrecision(2)}%",
                    //               style: textTheme.labelMedium!
                    //                   .copyWith(color: color),
                    //             ),
                    //           ],
                    //         );
                    //       }),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
