import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class UserInfoDetailSheet extends StatefulWidget {
  const UserInfoDetailSheet({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  final UserInfo userInfo;
  @override
  State<UserInfoDetailSheet> createState() => _UserInfoDetailSheetState();
}

class _UserInfoDetailSheetState extends State<UserInfoDetailSheet> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> data = {
      "Thông tin cá nhân": {
        "Số tài khoản": "005C193380",
        "Họ và tên": "Nguyễn Trung Kiên",
        "CMND/ĐKKD": "031200003055",
        "Ngày cấp": "07/09/2015",
        "Nơi cấp": "CỤC TRƯỞNG CỤC CẢNH SÁT ",
        "Ngày sinh": "23/07/2000",
        "Giới tính": "Nam",
      },
      "Thông tin liên lạc": {
        "Địa chỉ": "Chùa Hàng, Dư Hàng, Lê Chân, Hải Phòng",
        "Điện thoại": "0989999999",
        "Email": "dat9d3@gmail.com",
        "Người liên hệ": "",
        "Điện thoại (Người liên hệ)": "",
      },
      "Nhân viên chăm sóc": {
        "Tên nhân viên": "DTNT",
        "Chi nhánh": "KINH DOANH SỐ",
      },
    };
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              implementBackButton: false,
              title: S.of(context).account_infomation,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < data.keys.toList().length; i++)
                    _Panel(
                      label: data.keys.toList().elementAt(i),
                      data: data.values.toList().elementAt(i),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    Key? key,
    required this.label,
    required this.data,
  }) : super(key: key);
  final String label;
  final Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.neutral_06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:
                  textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            for (int i = 0; i < data.keys.toList().length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.keys.toList().elementAt(i),
                      style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_03),
                    ),
                    Text(
                      data.values.toList().elementAt(i),
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
