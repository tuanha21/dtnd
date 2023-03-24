import 'package:dtnd/ui/screen/asset/screen/RealizedProditLoss/realized_profit_loss_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/share_earned_model.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/time_utils.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../widget/expanded_widget.dart';
import '../../../../widget/my_appbar.dart';
import '../../../../widget/overlay/custom_dialog.dart';
import '../../../../widget/overlay/login_first_dialog.dart';
import '../../../../widget/picker/datetime_picker_widget.dart';
import '../../../login/login_screen.dart';
import 'item_realized_widget.dart';

class RealizedProfitLoss extends StatefulWidget {
  const RealizedProfitLoss({super.key});

  @override
  State<RealizedProfitLoss> createState() => _RealizedProfitLossState();
}

class _RealizedProfitLossState extends State<RealizedProfitLoss> {
  final RealizedProfitLossController controller =
      RealizedProfitLossController();
  late final TextEditingController fromdayController;
  late final TextEditingController todayController;

  void onChanged(String code) {
    if (code.isNotEmpty) {
      setState(() {
        controller.searching = true;
        try {
          controller.listSearch =
              controller.dataCenterService.searchStocksBySym(code);
          // ignore: empty_catches
        } catch (e) {}
      });
    } else {
      setState(() {
        controller.searching = false;
      });
    }
  }

  void onFABTapped() async {
    if (controller.userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        if (result && mounted) {
          if (controller.localStorageService.biometricsRegistered) {
            final reg = await showDialog<bool>(
              context: context,
              builder: (context) {
                return CustomDialog(
                  textButtonAction: 'Đồng ý',
                  textButtonExit: 'Để sau',
                  title: 'Đăng nhập bằng sinh trắc học',
                  content:
                      'Bạn chưa đăng ký đăng nhập bằng sinh trắc học\nBạn có muốn đăng ký ngay bây giờ không?',
                  action: () => Navigator.of(context).pop(true),
                );
              },
            );
            if (reg ?? false) {
              if (!mounted) return;
              final auth = await controller.localStorageService
                  .biometricsValidate()
                  .onError((error, stackTrace) => false);
              if (auth) {
                await controller.localStorageService.registerBiometrics();
              }
            }
          }
          return onFABTapped();
        }
      }
    } else {
      // return StockOrderISheet(widget.stockModel).showSheet(context, );

      // StockOrderISheet(widget.stockModel).show(
      //     context,
      //     StockOrderSheet(
      //       stockModel: widget.stockModel,
      //       orderData: null,
      //     ));
    }
  }

  @override
  void initState() {
    fromdayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat
            .format(DateTime.now().subtract(const Duration(days: 7))));
    todayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat.format(DateTime.now()));
    super.initState();
    controller.init();

    controller.getAllShareEarned("01/01/2023", "01/03/2023");
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    // final textTheme = Theme.of(context).textTheme;
    // final data = userService.listAccountModel.value?.firstWhereOrNull(
    //         (element) => element.runtimeType == BaseMarginAccountModel)
    // as BaseMarginAccountModel?;

    return Scaffold(
      appBar: MyAppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(false),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        title: 'Lãi/lỗ đã thực hiện',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
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
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: DateTimePickerWidget(
                  controller: fromdayController,
                  onChanged: null,
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: DateTimePickerWidget(
                  controller: todayController,
                  onChanged: null,
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Tổng cộng"), Text("5.900.000")],
            ),
            Obx(
              () => Column(
                children: [
                  for (ShareEarnedDetailModel detail
                      in controller.shareEarnedModel.value?.listDetail ?? [])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ItemRealizedWidget(detail: detail),
                    )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            onTap: () {},
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.primary_01,
              ),
              child: SvgPicture.asset(
                AppImages.arrange_circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandableRow extends StatefulWidget {
  const _ExpandableRow({
    required this.icon,
    required this.text,
    required this.value,
    this.child,
  });

  final Widget icon;
  final String text;
  final Widget value;
  final Widget? child;

  @override
  State<_ExpandableRow> createState() => __ExpandableRowState();
}

class __ExpandableRowState extends State<_ExpandableRow> {
  bool expanded = false;

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
                children: [
                  SizedBox.square(
                    dimension: 32,
                    child: widget.icon,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
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
                    ),
                  ),
                  widget.value,
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
