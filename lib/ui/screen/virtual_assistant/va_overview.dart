import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/trash_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../theme/app_color.dart';
import '../../theme/app_image.dart';
import '../../theme/app_textstyle.dart';
import '../home/home_controller.dart';
import '../home/widget/trash_component.dart';

class VaOverview extends StatefulWidget {
  const VaOverview({super.key});

  @override
  State<VaOverview> createState() => _VaOverviewState();
}

class _VaOverviewState extends State<VaOverview>
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
        switch (_tabController.index) {
          case 1:
            if (!up) {
              data = homeController.priceDecreaseToday.value;
            } else {
              data = homeController.priceIncreaseToday.value;
            }
            break;
          default:
            data = homeController.hotToday.value;
        }
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
                  setState(() {});
                  // setState(() {});
                },
                tabs: <Widget>[
                   const Text("Phổ biến"),
                  Row(
                    children: [
                      const Text("Top biến động"),
                      sortArrow,
                    ],
                  ),
                  const Text("Top khối lượng"),
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
