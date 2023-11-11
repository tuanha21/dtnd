import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/exercise_right/business/rights_info_flow.dart';
import 'package:dtnd/ui/screen/exercise_right/sheet/registration_rights_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../=models=/response/account/i_account.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../theme/app_image.dart';
import '../../../widget/empty_list_widget.dart';
import '../../../widget/expanded_widget.dart';
import '../widget/rights_Info_widget.dart';

class RightsInfoTab extends StatefulWidget {
  const RightsInfoTab({super.key});

  @override
  State<RightsInfoTab> createState() => _RightsInfoTabState();
}

class _RightsInfoTabState extends State<RightsInfoTab> {
  final IUserService userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final account =
        userService.defaultAccount.value as BaseMarginPlusAccountModel?;

    account?.getListUnexecutedRight(userService, NetworkService());

    final listRightBuy = <UnexecutedRightModel>[];
    final listRightDividend = <UnexecutedRightModel>[];
    final listRightVote = <UnexecutedRightModel>[];
    final listRightStockDiv = <UnexecutedRightModel>[];

    for (final item in account?.getListRight ?? []) {
      switch (item.cBUSINESSCODE) {
        case 'RIGHT_BUY':
          listRightBuy.add(item);
          break;
        case 'RIGHT_DIVIDEND':
          listRightDividend.add(item);
          break;
        case 'RIGHT_STOCK_DIV':
        case 'RIGHT_STOCK_BONUS':
          listRightStockDiv.add(item);
          break;
        case 'RIGHT_VOTE':
          listRightVote.add(item);
          break;
        default:
          break;
      }
    }

    return Column(
      children: [
        if (account?.getListRight.isNotEmpty ?? false)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  itemGroup(listRightBuy, account as IAccountModel,
                      S.of(context).right_to_buy),
                  itemGroup(listRightDividend, account as IAccountModel,
                      S.of(context).cash_dividend),
                  itemGroup(listRightStockDiv, account as IAccountModel,
                      S.of(context).dividends_value),
                  itemGroup(listRightVote, account as IAccountModel,
                      S.of(context).other),
                ],
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: EmptyListWidget(),
          ),
      ],
    );
  }

  Widget itemGroup(List<UnexecutedRightModel> listData, IAccountModel account,
      String? title) {
    return listData.isNotEmpty
        ? Column(
            children: [
              const SizedBox(height: 12),
              _ExpandableRow(
                text: S.of(context).all,
                title: title ?? '',
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        RightsInfoWidget(
                          data: listData[index],
                          onChange: () {
                            RegistrationRightsFLowSheet().show(
                              context,
                              RegistrationRightsSheet(
                                data: listData[index],
                                accountModel: account,
                                onSuccessExecute: () =>
                                    account.getListUnexecutedRight(
                                        userService, NetworkService()),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}

class _ExpandableRow extends StatefulWidget {
  const _ExpandableRow({
    required this.text,
    required this.title,
    this.child,
  });

  final String text;
  final String title;
  final Widget? child;

  @override
  State<_ExpandableRow> createState() => __ExpandableRowState();
}

class __ExpandableRowState extends State<_ExpandableRow> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Ink(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 14, height: 1.5, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.text,
                        style: textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Center(
                        child: AnimatedRotation(
                          turns: expanded ? -0.5 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: SizedBox.square(
                            dimension: 10,
                            child: Image.asset(
                              AppImages.arrow_drop_down_rounded,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if (widget.child != null)
          ExpandedSection(expand: expanded, child: widget.child!),
      ],
    );
  }
}
