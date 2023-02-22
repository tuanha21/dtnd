import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../=models=/response/sec_event.dart';
import '../../../../data/i_data_center_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../generated/l10n.dart';
import '../../../../utilities/logger.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_textstyle.dart';

class StockEvent extends StatefulWidget {
  final StockModel stockModel;

  const StockEvent({Key? key, required this.stockModel}) : super(key: key);

  @override
  State<StockEvent> createState() => _StockEventState();
}

class _StockEventState extends State<StockEvent> {
  final IDataCenterService dataCenterService = DataCenterService();

  Future<List<SecEvent>> listEvent = Future.value([]);

  @override
  void initState() {
    listEvent = dataCenterService.getListEvent(widget.stockModel.stockData.sym);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SecEvent>>(
      future: listEvent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var list = snapshot.data;
          if (list == null) return const SizedBox();
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: AppColors.neutral_07,
            ),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EventCard(event: list[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                    color: AppColors.neutral_06,
                    height: 16,
                  );
                },
                itemCount: list.length),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final SecEvent event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(event.link);
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: AppColors.neutral_06,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                        color: AppColors.primary_04,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4))),
                    child: Text(
                      DateFormat('MMMM')
                          .format(event.dateTime ?? DateTime.now()),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColors.light_tabBar_bg),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('dd').format(event.dateTime ?? DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('yyyy').format(event.dateTime ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary_04),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.title ?? "Title",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).event,
                        style: AppTextStyle.bottomNavLabel
                            .copyWith(color: AppColors.primary_01),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.semantic_02),
                      ),
                      const SizedBox(width: 5),
                      Text(event.source ?? "",
                          style: AppTextStyle.labelSmall_10
                              .copyWith(fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(height: 5)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
