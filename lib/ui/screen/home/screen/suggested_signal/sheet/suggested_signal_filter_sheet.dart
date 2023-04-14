import 'package:dtnd/=models=/response/signal_type.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/checkbox/circle_checkbox_with_title.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class SuggestedSignalFilterSheet extends StatefulWidget {
  const SuggestedSignalFilterSheet(
      {super.key, required this.listOptions, this.selected});
  final List<SignalType> listOptions;
  final SignalType? selected;
  @override
  State<SuggestedSignalFilterSheet> createState() =>
      _SuggestedSignalFilterSheetState();
}

class _SuggestedSignalFilterSheetState
    extends State<SuggestedSignalFilterSheet> {
  late final List<SignalType?> listOptions;
  late SignalType? selected;
  @override
  void initState() {
    listOptions = [null, ...widget.listOptions];
    selected = widget.selected;
    // listSelected = List.filled(listOptions.length + 1, false);
    // if (widget.listSelected != null) {
    //   for (SignalType type in widget.listSelected!) {
    //     listSelected[listOptions.indexWhere((element) => element == type)] =
    //         true;
    //   }
    // } else {
    //   listSelected[0] = true;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              implementBackButton: false,
              title: S.of(context).filter,
            ),
            const SizedBox(height: 20),
            _FilterField<SignalType>(
              currentValue: selected,
              onChanged: (value) {
                if (value != selected) {
                  setState(() {
                    selected = value;
                  });
                }
              },
              title: S.of(context).signal_type,
              values: listOptions,
              name: (SignalType? value) =>
                  value?.signalDetail ?? S.of(context).all,
            ),
            const SizedBox(height: 20),
            SingleColorTextButton(
              color: AppColors.primary_01,
              text: "Áp dụng",
              onTap: () {
                // late final List<SignalType>? listReturn;
                // if (listSelected[0]) {
                //   listReturn = null;
                // } else {
                //   listReturn = [];
                //   for (var i = 0; i < listSelected.length; i++) {
                //     if (listSelected.elementAt(i)) {
                //       listReturn.add(listOptions.elementAt(i)!);
                //     }
                //   }
                // }
                Navigator.of(context).pop(NextCmd(selected));
              },
            )
          ],
        ),
      ),
    );
  }
}

class _FilterField<T> extends StatefulWidget {
  const _FilterField(
      {required this.onChanged,
      required this.values,
      required this.currentValue,
      required this.title,
      required this.name});
  final List<T?> values;
  final T? currentValue;
  final ValueChanged<T?> onChanged;
  final String Function(T?) name;
  final String title;
  @override
  State<_FilterField<T>> createState() => __FilterFieldState<T>();
}

class __FilterFieldState<T> extends State<_FilterField<T>> {
  // void onChanged(int index) {
  //   switch (index) {
  //     case 0:
  //       setState(() {
  //         if (!widget.listSelect[0]) {
  //           for (var i = 1; i < widget.listSelect.length; i++) {
  //             widget.listSelect[i] = false;
  //           }
  //           widget.listSelect[0] = true;
  //         }
  //       });

  //       break;
  //     default:
  //       setState(() {
  //         widget.listSelect[index] = !widget.listSelect[index];
  //         if (widget.listSelect[0]) {
  //           widget.listSelect[0] = false;
  //         }
  //       });
  //       int count = 0;
  //       for (var i = 1; i < widget.listSelect.length; i++) {
  //         if (widget.listSelect.elementAt(i)) {
  //           count++;
  //         }
  //       }
  //       if (count == widget.listSelect.length - 1 || count == 0) {
  //         setState(() {
  //           for (var i = 1; i < widget.listSelect.length; i++) {
  //             widget.listSelect[i] = false;
  //           }
  //           widget.listSelect[0] = true;
  //         });
  //       }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        for (int i = 0; i < widget.values.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CircleCheckboxWithTitle(
              title: widget.name.call(widget.values.elementAt(i)),
              onCheck: () => widget.onChanged.call(widget.values.elementAt(i)),
              ischeck: widget.values.elementAt(i) == widget.currentValue,
            ),
          )
      ],
    );
  }
}
