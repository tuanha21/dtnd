import 'package:dtnd/ui/screen/account/logic/account_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/money_statement_sheet.dart';
import 'package:dtnd/ui/screen/account/sheet/share_statement_sheet.dart';
import 'package:dtnd/ui/screen/asset/screen/margin_debt/margin_debt_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/executed_profit_loss/realized_profit_loss.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_util.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:flutter/material.dart';

class ListFunction extends StatefulWidget {
  const ListFunction({super.key, required this.list});
  final List<FunctionData> list;

  @override
  State<ListFunction> createState() => _ListFunctionState();
}

class _ListFunctionState extends State<ListFunction> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
  }

  void onRouteBigTitle(String title, BuildContext context) {
    switch (title) {
      case 'Xác thực tài khoản - eKYC':
        break;
      default:
        break;
    }
  }

  void onRouteSubTitle(String title, BuildContext context) {
    switch (title) {
      case 'Giao dịch cơ sở':
        StockModelUtil.openSheet(context);
        break;
      case 'Lọc cổ phiếu':
        StockModelUtil.openSheet(context);
        break;
      case 'Sao kê tiền':
        const MoneyStatementISheet()
            .show(context, const MoneyStatementSheet(), wrap: false);
        break;
      case 'Sao kê chứng khoán':
        const ShareStatementISheet()
            .show(context, const ShareStatementSheet(), wrap: false);
        break;
      case 'Lịch sử lệnh':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OrderNoteScreen(defaultab: 2),
        ));
        break;
      case 'Lịch sử lãi lỗ':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RealizedProfitLoss(),
        ));
        break;
      case 'Công cụ margin':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MarginDebtScreen(),
        ));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          var item = widget.list[index];
          return ExpansionTile(
              // onExpansionChanged: (value) {
              //   onRouteBigTitle(item.title, context);
              // },
              iconColor: AppColors.text_black_1,
              tilePadding: const EdgeInsets.only(left: 4),
              leading: Image.asset(
                item.iconPath!,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
              title: Container(
                padding: EdgeInsets.zero, //
                child: Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: (index == 0 || index == 2 || index == 4 || index == 6)
                  ? const SizedBox.shrink()
                  : const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.neutral_01,
                    ),
              children: [
                item.subTitle!.isNotEmpty == true
                    ? MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(left: 21),
                            shrinkWrap: true,
                            itemCount: item.subTitle?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => onRouteSubTitle(
                                    item.subTitle![index], context),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 40, bottom: 10),
                                    height: 40,
                                    child: Text(
                                      item.subTitle![index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppColors.neutral_02),
                                    )),
                              );
                            }),
                      )
                    : Container(),
              ]);
        });
  }
}
