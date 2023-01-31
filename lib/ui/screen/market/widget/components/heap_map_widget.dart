import 'package:dtnd/=models=/ui_model/field_tree_element_model.dart';
import 'package:dtnd/ui/screen/market/controller/industry_tab_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

enum _Type { gt, kl }

extension _TypeX on _Type {
  String get label {
    switch (this) {
      case _Type.kl:
        return "Khối lượng";
      default:
        return "Giá trị";
    }
  }

  String get api {
    switch (this) {
      case _Type.kl:
        return "KL";
      default:
        return "GT";
    }
  }
}

class HeapMapWidget extends StatefulWidget {
  const HeapMapWidget({super.key});

  @override
  State<HeapMapWidget> createState() => _HeapMapWidgetState();
}

class _HeapMapWidgetState extends State<HeapMapWidget> {
  final IndustryTabController controller = IndustryTabController();
  final List<FieldTreeElementModel> _datas = [];

  double _total = 0;
  _Type chartType = _Type.kl;
  bool initialized = false;
  @override
  void initState() {
    // widget._datas.forEach((element) {
    //   _datas.addAll(element.stocks);
    //   _total += element.tOTALKLGD;
    // });
    // _datas.removeWhere((element) => element.kLGD < _total / 10000);
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HeapMapWidget oldWidget) {
    newData();
    super.didUpdateWidget(oldWidget);
  }

  void init() async {
    await controller.getListIndustry();
    await newData();
    if(mounted){
      setState(() {
        initialized = true;
      });
    }
  }

  Future<void> newData() async {
    _datas.clear();
    if(mounted){
      setState(() {});
    }
    _total = 0;

    if (chartType == _Type.kl) {
      await Future.forEach<FieldTreeModel>(controller.model, (element) {
        _datas.addAll(element.stocks);
        _total += element.tOTALKLGD;
      });
    } else {
      final _list = [];
      num __total = 0;
      await Future.forEach<FieldTreeModel>(controller.model, (element) {
        __total += element.tOTALKLGD;
        _list.add(element.tOTALKLGD);
      });
      await Future.forEach<FieldTreeModel>(controller.model, (element) {
        if (element.tOTALKLGD > __total / 1000) {
          _datas.addAll(element.stocks);
          _total += element.tOTALKLGD;
        }
      });
    }

    _datas.removeWhere((element) {
      if (chartType == _Type.kl) {
        return (element.kLGD ?? 0) < _total / 10000;
      } else {
        return (element.gTGD ?? 0) < _total / 1000;
      }
    });
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget map;
    if (!initialized) {
      map = Container();
    } else {
      map = SfTreemap(
        dataCount: _datas.length,
        weightValueMapper: (int index) {
          final _data = _datas[index];
          if (chartType == _Type.kl) {
            return _data.kLGD?.toDouble() ?? 0;
          } else {
            return _data.gTGD?.toDouble() ?? 0;
          }
        },
        onSelectionChanged: (TreemapTile tile) {
          // if (tile.level.colorValueMapper != null) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => StockDetailPage(
          //         stockCode: tile.group,
          //         pushStockOrder: widget.pushStockOrder,
          //       ),
          //     ),
          //   );
          // }
        },
        selectionSettings:
            const TreemapSelectionSettings(color: Colors.transparent),
        levels: [
          TreemapLevel(
            color: AppColors.neutral_06,
            groupMapper: (index) {
              // print(_datas[index].iNDUSTRY);
              return _datas[index].iNDUSTRY ?? "";
            },
            labelBuilder: (BuildContext context, TreemapTile tile) {
              return IgnorePointer(
                child: Center(
                  child: Text(
                    tile.group,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
          TreemapLevel(
            groupMapper: (int index) => _datas[index].sTOCKCODE ?? "",
            colorValueMapper: (tile) => _datas[tile.indices[0]].stockColor,
            labelBuilder: (BuildContext context, TreemapTile tile) {
              return IgnorePointer(
                //  _datas[tile.indices[0]].kLGD < _total / 10000
                //     ? Container()
                //     :
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tile.group,
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${_datas[tile.indices[0]].pERCENTCHANGE}%",
                            style: const TextStyle(fontSize: 8),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
    return map;
  }
}
