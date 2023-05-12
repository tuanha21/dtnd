import 'package:dtnd/data/implementations/network_service.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/empty_list_widget.dart';
import '../widget/registration_rights_widget.dart';

class RegisterTheRightToBuyTab extends StatefulWidget {
  const RegisterTheRightToBuyTab({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterTheRightToBuyTabState();
}

class _RegisterTheRightToBuyTabState extends State<RegisterTheRightToBuyTab> {
  final IUserService userService = UserService();
  List<UnexecutedRightModel>? listOrderShow;

  Future<List<UnexecutedRightModel>?> _getData() async {
    final account =
        userService.defaultAccount.value as BaseMarginPlusAccountModel?;
    listOrderShow =
        await account?.getListRightBuy(userService, NetworkService());
    return listOrderShow;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UnexecutedRightModel>?>(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.only(top: 100),
            child: EmptyListWidget(),
          );
        } else {
          return Column(
            children: [
              listOrderShow?.isEmpty == false
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOrderShow?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RegistrationRightsWidget(
                            data: listOrderShow?.elementAt(index),
                          );
                        },
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: EmptyListWidget(),
                    )
            ],
          );
        }
      },
    );
  }
}
