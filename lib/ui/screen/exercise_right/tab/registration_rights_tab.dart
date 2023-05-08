import 'package:dtnd/data/implementations/network_service.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/empty_list_widget.dart';
import '../../exchange_stock/order_note/data/order_filter_data.dart';
import '../widget/registration_rights_widget.dart';

class RegisterTheRightToBuyTab extends StatefulWidget {
  const RegisterTheRightToBuyTab({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterTheRightToBuyTabState();
}

class _RegisterTheRightToBuyTabState extends State<RegisterTheRightToBuyTab> {
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
    account?.getListRightBuy(userService, NetworkService());
    return Column(
      children: [
        account?.listUnexecutedRightBuild.isEmpty == false
            ? Expanded(child: Builder(
          builder: (context) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: account?.listUnexecutedRightBuild.length,
                itemBuilder: (BuildContext context, int index) {
                  return RegistrationRightsWidget(
                    data:
                    account?.listUnexecutedRightBuild.elementAt(index),
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
