import 'dart:async';
import 'package:dtnd/=models=/response/stock_derivative_model.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widget/derivative_component.dart';

class DerivativeWidget extends StatefulWidget {
  const DerivativeWidget({
    super.key,
  });

  @override
  State<DerivativeWidget> createState() => _DerivativeWidgetState();
}

class _DerivativeWidgetState extends State<DerivativeWidget> {
  final DataCenterService dataCenterService = DataCenterService();

  late Future<List<DerivativeResModel>?> listStocks = Future.value([]);

  @override
  void initState() {
    super.initState();
    initDerivative();
  }

  void initDerivative() {
    // get list derivative
    listStocks = dataCenterService.getListDerivative();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Chỉ số phái sinh',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.of(context).stock_code,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700, color: AppColors.neutral_04),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    S.of(context).price,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral_04),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "+/-",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral_04),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    S.of(context).volumn,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral_04),
                  ),
                ),
              )
            ],
          ),
        ),
        FutureBuilder<List<DerivativeResModel>?>(
            future: listStocks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var list = snapshot.data;

                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list!.length,
                      itemBuilder: (context, index) {
                        return DerivativeComponent(model: list[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 2,
                          height: 0,
                          color: Color.fromRGBO(245, 248, 255, 1),
                        );
                      });
                } else {
                  return const SizedBox();
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        const SizedBox(height: 10)
      ],
    );
  }
}
