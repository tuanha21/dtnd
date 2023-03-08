import 'package:dtnd/=models=/response/stock_derivative_model.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dtnd/ui/theme/app_color.dart';

class DerivativeComponent extends StatefulWidget {
  final DerivativeResModel model;

  const DerivativeComponent({Key? key, required this.model}) : super(key: key);

  @override
  State<DerivativeComponent> createState() => _DerivativeComponentState();
}

class _DerivativeComponentState extends State<DerivativeComponent> {
  @override
  Widget build(BuildContext context) {
    print(widget.model?.sym ?? "");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(widget.model?.sym ?? "",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: widget.model
                        .getPriceColor(widget.model.lastPrice ?? 0))),
          ),
          Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ((widget.model?.lastPrice == 0
                                  ? widget.model?.r
                                  : widget.model?.lastPrice) ??
                              0)
                          .toString() ??
                      "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.model
                          .getPriceColor(widget.model.lastPrice ?? 0)),
                )),
          ),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  NumUtils.formatDouble(((widget.model?.lastPrice == 0
                              ? widget.model?.r
                              : widget.model?.lastPrice) ??
                          0) -
                      (widget.model?.r ?? 0)),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.model
                          .getPriceColor(widget.model.lastPrice ?? 0)),
                ),
              )),
          Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  NumUtils.formatInteger(widget.model?.lot),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.neutral_04),
                ),
              ))
        ],
      ),
    );
  }
}
