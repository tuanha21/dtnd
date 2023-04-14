import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListFunction2 extends StatefulWidget {
  const ListFunction2({super.key, required this.list});
  final List<FunctionData> list;

  @override
  State<ListFunction2> createState() => _ListFunctionState();
}

class _ListFunctionState extends State<ListFunction2> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        dividerColor: Colors.transparent,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            widget.list[index].isExpanded = !isExpanded;
          });
        },
        children: widget.list.map<ExpansionPanel>((FunctionData item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox.square(
                      dimension: 24, child: Image.asset(item.iconPath!)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
            body: item.subTitle?.isNotEmpty == true
                ? MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: item.subTitle?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding:
                                  const EdgeInsets.only(left: 40, bottom: 10),
                              height: 40,
                              child: Text(item.subTitle![index]));
                        }),
                  )
                : Container(),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}
