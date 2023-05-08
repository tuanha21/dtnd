import 'package:dtnd/ui/screen/exercise_right/business/rights_info_flow.dart';
import 'package:dtnd/ui/screen/exercise_right/sheet/registration_rights_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/network_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/empty_list_widget.dart';
import '../../exchange_stock/order_note/data/order_filter_data.dart';
import '../widget/rights_Info_widget.dart';

class RightsInfoTab extends StatefulWidget {
  const RightsInfoTab({super.key});

  @override
  State<RightsInfoTab> createState() => _RightsInfoTabState();
}

class _RightsInfoTabState extends State<RightsInfoTab> {
  final IUserService userService = UserService();
  List<UnexecutedRightModel>? listOrderShow;
  OrderFilterData? orderFilterData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final account =
        userService.defaultAccount.value as BaseMarginPlusAccountModel?;
    account?.getListUnexecutedRight(userService, NetworkService());

    return Column(
      children: [
        account?.listUnexecutedBuyRight.isEmpty == false
            ? Expanded(child: Builder(
                builder: (context) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: account?.listUnexecutedBuyRight.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RightsInfoWidget(
                          data:
                              account?.listUnexecutedBuyRight.elementAt(index),
                          onChange: () async {
                            RegistrationRightsFLowSheet().show(
                                context,
                                RegistrationRightsSheet(
                                  data: account?.listUnexecutedBuyRight
                                      .elementAt(index),
                                ));
                          },
                        );
                      });
                },
              ))
            : const Padding(
                padding: EdgeInsets.only(top: 100),
                child: EmptyListWidget(),
              )
      ],
    );
  }
}
