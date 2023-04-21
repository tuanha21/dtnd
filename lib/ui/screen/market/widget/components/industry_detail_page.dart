import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../=models=/response/stock_data.dart';
import '../../../../../generated/l10n.dart';

class IndustryDetailPage extends StatefulWidget {
  final List<StockData> listStock;
  final String title;

  const IndustryDetailPage(
      {Key? key, required this.listStock, required this.title})
      : super(key: key);

  @override
  State<IndustryDetailPage> createState() => _IndustryDetailPageState();
}

class _IndustryDetailPageState extends State<IndustryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/industry_banned.png',
                height: MediaQuery.of(context).size.height * 300 / 875,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: BackButton(
                  color: AppColors.light_bg,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.light_bg),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.listStock.length} ${S.of(context).stock_symbol}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.light_bg),
                        ),
                        const SizedBox(height: 16)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    var stock = widget.listStock[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Text(
                              stock.sym,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${stock.lastPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${stock.changePc}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: stock.color),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      thickness: 2,
                      color: Color.fromRGBO(245, 248, 255, 1),
                    );
                  },
                  itemCount: widget.listStock.length))
        ],
      ),
    );
  }
}
