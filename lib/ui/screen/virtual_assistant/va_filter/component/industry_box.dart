import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../=models=/algo/filter.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../widget/expanded_widget.dart';
import 'check_box_component.dart';

class IndustryBox extends StatefulWidget {
  final Filter? filter;
  final OpTapCheckBox onChanged;

  const IndustryBox({Key? key,  this.filter, required this.onChanged})
      : super(key: key);

  @override
  State<IndustryBox> createState() => _IndustryBoxState();
}

class _IndustryBoxState extends State<IndustryBox> {
  bool isExpanded = false;

  List<String> get list =>
      "1300,1700,2300,2700,3300,3500,3700,4530,4570,5300,5500,5700,6000,7530,7570,8300,8500,8600,8700,9000,0001"
          .split(",");

  List<String> get listFilterSelect {
    return widget.filter?.listIndustryCode ?? [];
  }

  int get count {
    int count = 0;
    for (var element in listFilterSelect) {
      for (var element1 in list) {
        if (element1 == element) {
          count++;
        }
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.neutral_06,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              children: [
                Text("Ngành", style: Theme.of(context).textTheme.titleSmall),
                Visibility(
                    visible: count > 0,
                    child: Text(
                      ' (${count.toString()})',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.primary_01),
                    )),
                const Spacer(),
                SvgPicture.asset(
                    !isExpanded ? AppImages.arrowUp1 : AppImages.arrowDown)
              ],
            ),
          ),
          ExpandedSection(
            expand: isExpanded,
            child: GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return CheckBoxComponent(
                    initValue: listFilterSelect.contains(list[index]),
                    text: mapIndustryList[list[index]] ?? "",
                    initText: listFilterSelect
                        .firstWhereOrNull((element) => element == list[index]),
                    onChanged: widget.onChanged,
                  );
                }),
          )
        ],
      ),
    );
  }
}

const mapIndustryList = {
  '0001': 'Dầu khí',
  '1300': 'Hóa chất',
  '1700': 'Tài nguyên cơ bản',
  '2300': 'Xây dựng và vật liệu',
  '2700': 'Hàng & Dịch vụ Công nghiệp',
  '3300': 'Ô tô và phụ tùng',
  '3500': 'Thực phẩm và đồ uống',
  '3700': 'Hàng cá nhân & Gia dụng',
  '4530': 'Thiết bị và Dịch vụ Y tế',
  '4570': 'Dược phẩm',
  '5300': 'Bán lẻ',
  '5500': 'Truyền thông',
  '5700': 'Du lịch và Giải trí',
  '6000': 'Viễn thông',
  '7530': 'Điện',
  '7570': 'Nước & Khí đốt',
  '8300': 'Ngân hàng',
  '8500': 'Bảo hiểm',
  '8600': 'Bất động sản',
  '8700': 'Dịch vụ Tài chính',
  '9000': 'Công nghệ thông tin',
  '0530': 'Sản xuất dầu khí',
  '0570': 'Thiết bị, Dịch vụ và Phân phối Dầu khí',
  '1350': 'Hóa chất',
  '1730': 'Lâm nghiệp và Giấy',
  '1750': 'Kim loại',
  '1770': 'Khai khoáng',
  '2350': 'Xây dựng và Vật liệu',
  '2710': 'Hàng không & Quốc phòng',
  '2720': 'Hàng công nghiệp',
  '2730': 'Điện tử & Thiết bị điện',
  '2750': 'Công nghiệp nặng',
  '2770': 'Vận tải',
  '2790': 'Tư vấn & Hỗ trợ Kinh doanh',
  '3350': 'Ô tô và phụ tùng',
  '3530': 'Bia và đồ uống',
  '3570': 'Sản xuất thực phẩm',
  '3720': 'Hàng gia dụng',
  '3740': 'Hàng hóa giải trí',
  '3760': 'Hàng cá nhân',
  '3780': 'Thuốc lá',
  '5330': 'Phân phối thực phẩm & dược phẩm',
  '5370': 'Bán lẻ',
  '5550': 'Truyền thông',
  '5750': 'Du lịch & Giải trí',
  '6530': 'Viễn thông cố định',
  '6570': 'Viễn thông di động',
  '8350': 'Ngân hàng',
  '8530': 'Bảo hiểm phi nhân thọ',
  '8570': 'Bảo hiểm nhân thọ',
  '8630': 'Bất động sản',
  '8770': 'Dịch vụ tài chính',
  '8980': 'Quỹ đầu tư',
  '8990': 'Quỹ đầu tư mạo hiểm',
  '9530': 'Phần mềm & Dịch vụ Máy tính',
  '9570': 'Thiết bị và Phần cứng',
};
