import 'package:dtnd/=models=/local/i_local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/service/app_services.dart';
import '../../../../../data/i_local_storage_service.dart';
import '../../../../../data/implementations/local_storage_service.dart';
import '../../../../../utilities/logger.dart';
import '../../../../theme/app_image.dart';
import '../../../../theme/app_textstyle.dart';

class DeleteCatalogDialog extends StatefulWidget {
  const DeleteCatalogDialog({
    super.key,
    required this.savedCatalog,
    required this.catalog,
  });

  final SavedCatalog savedCatalog;
  final LocalCatalog catalog;

  @override
  State<DeleteCatalogDialog> createState() => _DeleteCatalogDialogState();
}

class _DeleteCatalogDialogState extends State<DeleteCatalogDialog> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final mediaQueryData = MediaQuery.of(context);

    return Stack(
      children: <Widget>[
        Container(
          width: mediaQueryData.size.width,
          padding: const EdgeInsets.only(
              top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: Material(
            color: themeMode.isLight ? AppColors.light_bg : AppColors.dark_stronger_bg,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          color:  themeMode.isLight ? AppColors.light_bg : AppColors.dark_stronger_bg ,
                          child: Container(
                            padding: EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).delete_catalog,
                                        style: AppTextStyle.labelLarge_18
                                            .copyWith(
                                                color: AppColors.neutral_01),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                      S
                                          .of(context)
                                          .are_you_sure_to_delete_catalog(
                                              widget.catalog.name),
                                      style: AppTextStyle.bodyMedium_14
                                          .copyWith(
                                              color: AppColors.neutral_04),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            child: Container(
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: AppColors.neutral_06,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(S.of(context).abort,
                                                  style: AppTextStyle
                                                      .bodyMedium_14
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary_01)),
                                            ),
                                            onTap: () => Navigator.of(context)
                                                .pop(const BackCmd()),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              try {
                                                widget.savedCatalog
                                                    .removeCatalog(
                                                        widget.catalog);
                                                final ILocalStorageService
                                                    localStorageService =
                                                    LocalStorageService();
                                                localStorageService
                                                    .putSavedCatalog(
                                                        widget.savedCatalog);
                                                Navigator.of(context)
                                                    .pop(const NextCmd(true));
                                              } catch (e) {
                                                logger.e(e.toString());
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: AppColors.primary_01,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                S.of(context).confirm,
                                                style: AppTextStyle
                                                    .bodyMedium_14
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutral_07),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: mediaQueryData.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary_03,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SvgPicture.asset(AppImages.icon_delete_dialog)),
            ],
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CustomDialog(
  //       title: S.of(context).delete_catalog,
  //       content: "",
  //       actionBack: () => Navigator.of(context).pop(const BackCmd()),
  //       action: () {
  //         try {
  //           widget.savedCatalog.removeCatalog(widget.catalog);
  //           final ILocalStorageService localStorageService =
  //               LocalStorageService();
  //           localStorageService.putSavedCatalog(widget.savedCatalog);
  //           Navigator.of(context).pop(const NextCmd(true));
  //         } catch (e) {
  //           logger.e(e.toString());
  //         }
  //       });

  // Container(
  //   padding: const EdgeInsets.all(16),
  //   decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
  //       color: AppColors.light_bg),
  //   child: Column(
  //     children: [
  //       const Icon(Icons.warning_amber_rounded, size: 30),
  //       const SizedBox(height: 10),
  //       Text(S.of(context).delete_catalog,
  //           style: Theme.of(context)
  //               .textTheme
  //               .titleMedium
  //               ?.copyWith(fontWeight: FontWeight.w700)),
  //       const SizedBox(height: 20),
  //       Row(
  //         children: [
  //           Flexible(
  //             child: InkWell(
  //                 onTap: () => Navigator.of(context).pop(const BackCmd()),
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   child: Text(S.of(context).cancel),
  //                 )),
  //           ),
  //           Flexible(
  //             child: InkWell(
  //                 onTap: () {
  //                   try {
  //                     widget.savedCatalog.removeCatalog(widget.catalog);
  //                     final ILocalStorageService localStorageService =
  //                         LocalStorageService();
  //                     localStorageService
  //                         .putSavedCatalog(widget.savedCatalog);
  //                     Navigator.of(context).pop(const NextCmd(true));
  //                   } catch (e) {
  //                     logger.e(e.toString());
  //                   }
  //                 },
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       left: BorderSide(color: AppColors.neutral_05),
  //                     ),
  //                   ),
  //                   child: const Text("OK"),
  //                 )),
  //           )
  //         ],
  //       )
  //     ],
  //   ),
  // );

  // return AppDialog(
  //   icon: const Icon(Icons.warning_amber_rounded),
  //   title: Text(S.of(context).delete_catalog),
  //   content: Text(S.of(context).are_you_sure_to_delete_catalog(widget.catalog.name)),
  //   actions: [
  //     Flexible(
  //       child: InkWell(
  //           onTap: () => Navigator.of(context).pop(const BackCmd()),
  //           child: Container(
  //             alignment: Alignment.center,
  //             child: Text(S.of(context).cancel),
  //           )),
  //     ),
  //     Flexible(
  //       child: InkWell(
  //           onTap: () {
  //             try {
  //               widget.savedCatalog.removeCatalog(widget.catalog);
  //               final ILocalStorageService localStorageService =
  //                   LocalStorageService();
  //               localStorageService.putSavedCatalog(widget.savedCatalog);
  //               Navigator.of(context).pop(const DeleteCatalogCmd());
  //             } catch (e) {
  //               logger.e(e.toString());
  //             }
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             decoration: const BoxDecoration(
  //               border: Border(
  //                 left: BorderSide(color: AppColors.neutral_05),
  //               ),
  //             ),
  //             child: const Text("OK"),
  //           )),
  //     )
  //   ],
  // );
}
