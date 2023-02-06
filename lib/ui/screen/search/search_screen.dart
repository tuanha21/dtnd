import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/ui/widget/input/search_stock.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  final IUserService userService = UserService();
  final TextEditingController controller = TextEditingController();
  late final TabController _tabController;
  List<StockModel> listSearchHistory = [];
  List<Stock> listSearch = [];
  List<Stock> listTopSearch = [];
  List<Stock> listVN30 = [];
  List<Stock> listHNX30 = [];
  bool hasHistory = false;
  bool searching = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    controller.addListener(() {});
    super.initState();
    getSearchHistory();
    getListTopSearch();
    getVN30();
    getHNX30();
  }

  void getSearchHistory() async {
    final list = await userService.getSearchHistory();
    final searchHistory =
        await dataCenterService.getStockModelsFromStockCodes(list);
    logger.v(searchHistory);
    setState(() {
      listSearchHistory = searchHistory;
      if (searchHistory.isNotEmpty) {
        hasHistory = true;
      } else {
        hasHistory = false;
      }
    });
  }

  void getListTopSearch() async {
    final list = await dataCenterService.getTopSearch();
    setState(() {
      listTopSearch = list;
    });
  }

  void getVN30() async {
    final list = await dataCenterService.getList30Stock("HSX30");
    setState(() {
      listVN30 = list;
    });
  }

  void getHNX30() async {
    final list = await dataCenterService.getList30Stock("HNX30");
    setState(() {
      listHNX30 = list;
    });
  }

  void onStockSelected(Stock stockCode) {}

  void onChanged(String code) {
    if (code.isNotEmpty) {
      setState(() {
        searching = true;
        try {
          listSearch = dataCenterService.searchStocksBySym(code);
          // ignore: empty_catches
        } catch (e) {}
      });
    } else {
      setState(() {
        searching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;

    final Widget view;
    if (!searching) {
      view = ListView(
        children: [
          if (hasHistory)
            Row(
              children: [
                Text(
                  S.of(context).search_history,
                  style: textTheme.titleSmall,
                )
              ],
            ),
          if (hasHistory)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: listSearchHistory.length,
                  itemBuilder: (context, index) {
                    final element = listSearchHistory.elementAt(index);
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(element.stock),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.neutral_07),
                        child: Row(
                          children: [
                            Text(element.stock.stockCode),
                            const SizedBox(width: 26),
                            Row(
                              children: [
                                element.stockData.prefixIcon(size: 12),
                                const SizedBox(width: 3),
                                Text(
                                  "${NumUtils.formatDouble(element.stockData.changePc.value, "-")}%",
                                  style:
                                      TextStyle(color: element.stockData.color),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 8),
                ),
              ),
            ),
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                padding: EdgeInsets.zero,
                onTap: (value) => setState(() {}),
                tabs: <Widget>[
                  Text(S.of(context).top_search),
                  const Text("VN30"),
                  const Text("HNX30"),
                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              print(_tabController.index);
              List<Stock> stocks = [];
              switch (_tabController.index) {
                case 1:
                  stocks = listVN30;
                  break;
                case 2:
                  stocks = listHNX30;
                  break;
                default:
                  stocks = listTopSearch;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: themeMode.isDark
                        ? AppColors.bg_2
                        : AppColors.neutral_07,
                  ),
                  child: Column(
                    children: [
                      for (var e in stocks)
                        Material(
                          color: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(e),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            child: Ink(
                              height: 80,
                              // alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    StockIcon(
                                      stockCode: e.stockCode,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                e.stockCode,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                e.postTo?.name ?? "",
                                                style: AppTextStyle
                                                    .bottomNavLabel
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutral_03),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Text(
                                              e.nameShort ?? "",
                                              style: AppTextStyle.labelMedium_12
                                                  .copyWith(
                                                      color:
                                                          AppColors.neutral_03),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      );
    } else {
      if (listSearch.isEmpty) {
        view = Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 200,
                    child: Image.asset(AppImages.scene),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).no_matching_results_were_found,
                    style: textTheme.labelLarge,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      S.of(context).try_searching_again_with_another_keyword,
                      textAlign: TextAlign.center,
                      // style: textTheme.labelLarge,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      } else {
        view = ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color:
                      themeMode.isDark ? AppColors.bg_2 : AppColors.neutral_07,
                ),
                child: Column(
                  children: [
                    for (var e in listSearch)
                      Material(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(e),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: Ink(
                            height: 80,
                            // alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Center(
                                      child: ClipOval(
                                        child: SizedBox.square(
                                          dimension: 40.0,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://info.sbsi.vn/logo/${e.stockCode}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.scaleDown),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              e.stockCode,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              e.postTo?.name ?? "",
                                              style: AppTextStyle.bottomNavLabel
                                                  .copyWith(
                                                      color:
                                                          AppColors.neutral_03),
                                            ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Text(
                                            e.nameShort ?? "",
                                            style: AppTextStyle.labelMedium_12
                                                .copyWith(
                                                    color:
                                                        AppColors.neutral_03),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    }
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).search,
        // showActions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: TextField(
                onChanged: onChanged,
                enableSuggestions: false,
                decoration: InputDecoration(
                    hintText: S.of(context).search_stock,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset(
                        AppImages.search_icon,
                      ),
                    ),
                    fillColor: AppColors.neutral_07,
                    suffixIconConstraints:
                        const BoxConstraints(maxWidth: 52, maxHeight: 20)),
              ),
            ),
            Expanded(child: view)
          ],
        ),
      ),
    );
  }
}
