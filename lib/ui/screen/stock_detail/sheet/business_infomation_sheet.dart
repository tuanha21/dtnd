import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BusinessInformationSheet extends StatefulWidget {
  const BusinessInformationSheet({Key? key, required this.stockModel})
      : super(key: key);
  final StockModel stockModel;
  @override
  State<BusinessInformationSheet> createState() =>
      _BusinessInformationSheetState();
}

class _BusinessInformationSheetState extends State<BusinessInformationSheet> {
  final IDataCenterService dataCenterService = DataCenterService();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    widget.stockModel.businnessProfileModel ??= await dataCenterService
        .getBusinnessProfile(widget.stockModel.stock.stockCode);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SafeArea(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Text(S.of(context).loading),
          ),
        ),
      );
    }
    return SafeArea(
      child: Column(children: [
        SheetHeader(
          title: S.of(context).business_information,
          implementBackButton: false,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Giới thiệu"),
              Html(data: widget.stockModel.businnessProfileModel!.profile)
            ],
          ),
        )
      ]),
    );
  }
}
