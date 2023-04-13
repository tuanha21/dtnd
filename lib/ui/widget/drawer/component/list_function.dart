import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/drawer/logic/function_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListFunction extends StatefulWidget {
  const ListFunction({super.key, required this.list});
  final List<FunctionData> list;

  @override
  State<ListFunction> createState() => _ListFunctionState();
}

class _ListFunctionState extends State<ListFunction> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => FunctionComponentDraw(
          data: widget.list.elementAt(index),
          expanded: currentIndex == index,
          onTap: () {
            setState(() {
              if (currentIndex == index) {
                currentIndex = null;
              } else {
                currentIndex = index;
              }
            });
            if (widget.list.elementAt(index).subFunction == null &&
                widget.list.elementAt(index).function == null) {
              EasyLoading.showToast("Tính năng đang phát triển");
            }
          },
        ),
      ),
    );
  }
}

// class FunctionComponent extends StatelessWidget {
//   const FunctionComponent(
//       {super.key,
//       required this.data,
//       required this.expanded,
//       required this.onTap});
//   final FunctionData data;
//   final bool expanded;
//   final VoidCallback onTap;
//   @override
//   Widget build(BuildContext context) {
//     if (data.subFunction != null) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Column(
//           children: [
//             Material(
//               borderRadius: const BorderRadius.all(Radius.circular(4)),
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   if (data.function != null) {
//                     data.function!.call();
//                     return;
//                   }
//
//                   onTap.call();
//                   return;
//                 },
//                 borderRadius: const BorderRadius.all(Radius.circular(4)),
//                 child: Ink(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                   child: Row(
//                     children: [
//                       SizedBox.square(
//                           dimension: 24, child: Image.asset(data.iconPath!)),
//                       const SizedBox(width: 8),
//                       Expanded(
//                           child: Text(
//                         data.title,
//                         style: Theme.of(context).textTheme.bodyMedium,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       )),
//                       AnimatedRotation(
//                         turns: expanded ? -0.5 : 0,
//                         duration: const Duration(milliseconds: 500),
//                         child: SizedBox.square(
//                           dimension: 10,
//                           child: Image.asset(DrawerIconAsset.expand_more_icon),
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             ExpandedSection(
//                 expand: expanded,
//                 child: Column(
//                   children: [
//                     for (var element in data.subFunction!)
//                       SubFunctionComponent(
//                         data: element,
//                       )
//                   ],
//                 ))
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Material(
//           borderRadius: const BorderRadius.all(Radius.circular(4)),
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () {
//               if (data.function != null) {
//                 data.function!.call();
//                 return;
//               }
//               onTap.call();
//               return;
//             },
//             borderRadius: const BorderRadius.all(Radius.circular(4)),
//             child: Ink(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(4)),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox.square(
//                       dimension: 24, child: Image.asset(data.iconPath!)),
//                   const SizedBox(width: 8),
//                   Expanded(
//                       child: Text(
//                     data.title,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )),
//                   const SizedBox(width: 15),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }

class FunctionComponentDraw extends StatelessWidget {
  const FunctionComponentDraw(
      {super.key,
      required this.data,
      required this.expanded,
      required this.onTap});

  final FunctionData data;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (data.function != null) {
                  data.function!.call();
                  return;
                }
                onTap.call();
                return;
              },
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Ink(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox.square(
                        dimension: 24, child: Image.asset(data.iconPath!)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        data.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // SvgPicture.asset(AppImages.around_right_icon),
                    data.title != 'Xác thực tài khoản - eKYC'
                        ? const Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 24,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SubFunctionComponent extends StatelessWidget {
//   const SubFunctionComponent({super.key, required this.data, this.onTap});
//
//   final FunctionData data;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Column(
//         children: [
//           Material(
//             borderRadius: const BorderRadius.all(Radius.circular(4)),
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
//                 if (data.function != null) {
//                   data.function!.call();
//                   return;
//                 } else {
//                   EasyLoading.showToast("Tính năng đang phát triển");
//                 }
//               },
//               borderRadius: const BorderRadius.all(Radius.circular(4)),
//               child: Ink(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(4)),
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 32),
//                     Expanded(
//                         child: Text(
//                       data.title,
//                       style: Theme.of(context)
//                           .textTheme
//                           .displaySmall!
//                           .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
