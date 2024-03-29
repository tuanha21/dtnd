import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../=models=/response/market/sec_event.dart';
import '../../../../config/service/app_services.dart';
import '../../../../data/i_data_center_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../l10n/generated/l10n.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_textstyle.dart';

class StockEvent extends StatefulWidget {
  final Future<List<SecEvent>?> listEvent;

  const StockEvent({Key? key, required this.listEvent}) : super(key: key);

  @override
  State<StockEvent> createState() => _StockEventState();
}

_launchURL(url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class _StockEventState extends State<StockEvent> {
  final IDataCenterService dataCenterService = DataCenterService();

  Future<List<SecEvent>> listEvent = Future.value([]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    return FutureBuilder<List<SecEvent>?>(
      future: widget.listEvent,
      builder: (context, snapshot) {
        if (snapshot.hasError || (snapshot.data?.isEmpty ?? true)) {
          return EmptyListWidget(
            title: S.of(context).no_data,
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: themeMode.isLight
                  ? AppColors.neutral_07
                  : AppColors.bg_share_inside_nav,
            ),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EventCard(event: snapshot.data![index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                    color: themeMode.isLight
                        ? AppColors.neutral_06
                        : AppColors.neutral_01,
                    height: 16,
                  );
                },
                itemCount: snapshot.data!.length),
          );
        }
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
    final ThemeData themeData = Theme.of(context);
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return GestureDetector(
      onTap: () {
        print(event.link);
        _launchURL(event.link);
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: themeData.colorScheme.onSurface,
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              themeMode.isLight ? null : AppColors.neutral_07),
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
