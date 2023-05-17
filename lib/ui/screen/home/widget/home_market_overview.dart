import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';
import 'trash_component.dart';

class HomeMarketOverview extends StatefulWidget {
  const HomeMarketOverview({super.key});

  @override
  State<HomeMarketOverview> createState() => _HomeMarketOverviewState();
}

class _HomeMarketOverviewState extends State<HomeMarketOverview>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = HomeController();
  late final TabController _tabController;
  bool up = true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<bool>>((initialized) {
      if (!initialized.value) {
        return Center(
          child: Text(S.of(context).loading),
        );
      }
      List<TrashModel>? data;
      final Widget sortArrow = Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Opacity(
              opacity: up ? 1.0 : 0.3,
              child: const Icon(
                Icons.expand_less_rounded,
                size: 12,
              ),
            ),
            Opacity(
              opacity: !up ? 1.0 : 0.3,
              child: const Icon(
                Icons.expand_more_rounded,
                size: 12,
              ),
            ),
          ],
        ),
      );
      Widget list = Obx(() {
        data = homeController.hotToday.value;

        return Column(
          children: [
            for (int i = 0; i < (data?.length ?? 0); i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SizedBox(
                  height: 72,
                  child: TrashComponent(
                    snapshotData: data![i],
                  ),
                ),
              )
          ],
        );
      });
      Widget grid = Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: (value) async {
                  if (!_tabController.indexIsChanging && value == 1) {
                    up = !up;
                    await homeController.changeList(_tabController.index, up,
                        data?.map((e) => e.sTOCKCODE).toList());
                  } else {
                    await homeController.changeList(_tabController.index, true,
                        data?.map((e) => e.sTOCKCODE).toList());
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                tabs: <Widget>[
                  // const Text("🔥HOT"),
                  Text(S.of(context).popular),
                  Row(
                    children: [
                      Text(S.of(context).top_changes),
                      sortArrow,
                    ],
                  ),
                  Text(S.of(context).top_volume),
                ],
              ),
            ),
          ),
          list,
        ],
      );
      return grid;
    }, homeController.topInitialized);
  }
}
