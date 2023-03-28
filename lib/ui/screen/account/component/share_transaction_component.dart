import 'package:dtnd/=models=/response/share_transaction_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class ShareTransactionComponent extends StatefulWidget {
  const ShareTransactionComponent({super.key, required this.data});

  final ShareTransactionModel data;

  @override
  State<ShareTransactionComponent> createState() =>
      _ShareTransactionComponentState();
}

class _ShareTransactionComponentState extends State<ShareTransactionComponent> {
  final IDataCenterService dataCenterService = DataCenterService();
  Stock? stock;

  @override
  void initState() {
    super.initState();
    if (widget.data.cSHARECODE != null && widget.data.cSHARECODE!.length == 3) {
      stock = dataCenterService.getStockFromStockCode(widget.data.cSHARECODE!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              StockIcon(
                color: Colors.white,
                stockCode: widget.data.cSHARECODE,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.data.cSHARECODE ?? "-",
                            style: textTheme.titleSmall,
                          ),
                        ),
                        Text(
                          widget.data.cSTATUSNAME ?? "-",
                          style: textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Text(
                      stock?.nameShort ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.labelSmall_10
                          .copyWith(color: AppColors.neutral_03),
                    ),
                    // Text(
                    //   "${(widget.volPc ?? 0).toStringAsFixed(2)}%",
                    //   style: textTheme.bodySmall!
                    //       .copyWith(color: AppColors.neutral_04),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).time,
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.data.cTRANSACTIONDATE ?? "",
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Phát sinh tăng/giảm",
                    style: AppTextStyle.bodySmall_8.copyWith(
                      color: AppColors.neutral_04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${NumUtils.formatInteger(widget.data.change)}CP",
                    style: AppTextStyle.titleSmall_14
                        .copyWith(color: widget.data.color),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                  child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Chi tiết: ",
                            style: AppTextStyle.labelSmall_10
                                .copyWith(color: AppColors.neutral_01)),
                        TextSpan(
                            text: widget.data.cCONTENT,
                            style: AppTextStyle.labelSmall_10.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutral_03,
                            )),
                      ])))
            ],
          )
        ],
      ),
    );
  }
}
