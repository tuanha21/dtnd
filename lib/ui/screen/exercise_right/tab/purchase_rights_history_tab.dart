import 'package:dtnd/data/implementations/network_service.dart';
import 'package:flutter/material.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../=models=/response/account/unexecuted_right_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../../utilities/time_utils.dart';
import '../../../widget/calendar/day_input.dart';
import '../../../widget/empty_list_widget.dart';

class PurchaseRightsHistoryTab extends StatefulWidget {
  const PurchaseRightsHistoryTab({super.key});

  @override
  State<StatefulWidget> createState() => _PurchaseRightsHistoryTabState();
}

class _PurchaseRightsHistoryTabState extends State<PurchaseRightsHistoryTab> {
  final IUserService userService = UserService();
  List<UnexecutedRightModel>? listOrderShow;

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    super.initState();
  }

  Future<List<UnexecutedRightModel>?> _getData(
      {DateTime? fromDay, DateTime? toDay}) async {
    final account =
        userService.defaultAccount.value as BaseMarginPlusAccountModel?;
    listOrderShow =
        await account?.getListHistoryBuy(userService, NetworkService());
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayInput(
                      initialDay: fromDay,
                      firstDay: firstDay,
                      lastDay: lastDay,
                      onChanged: (value) {
                        setState(() {
                          fromDay = value;
                        });
                        _getData();
                      }),
                  const SizedBox(
                    width: 16,
                    child: Text('-'),
                  ),
                  DayInput(
                    initialDay: toDay,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    onChanged: (value) {
                      setState(() {
                        toDay = value;
                      });
                      _getData();
                    },
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
