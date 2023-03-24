import 'package:dtnd/=models=/gender.dart';
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
  final UserInfo? userInfo;
  @override
  State<UserInfoDetailSheet> createState() => _UserInfoDetailSheetState();
}

class _UserInfoDetailSheetState extends State<UserInfoDetailSheet> {
  late final Map<String, Map<String, String?>> data;
  @override
  void initState() {
    super.initState();
    final userInfo = widget.userInfo;
    data = {
      "Thông tin cá nhân": {
        "Số tài khoản": userInfo?.customerCode,
        "Họ và tên": userInfo?.custFullName,
        "CMND/ĐKKD": userInfo?.cardId,
        "Ngày cấp": userInfo?.idIssueDate,
        "Nơi cấp": userInfo?.idIssuePlace,
        "Ngày sinh": userInfo?.custBirthday,
        "Giới tính": userInfo?.custGender?.call,
      },
      "Thông tin liên lạc": {
        "Địa chỉ": userInfo?.contactAddress,
        "Điện thoại": userInfo?.custMobile,
        "Email": userInfo?.custEmail,
        "Người liên hệ": null,
        "Điện thoại (Người liên hệ)": null,
      },
      "Nhân viên chăm sóc": {
        "Tên nhân viên": "DTNT",
        "Chi nhánh": "KINH DOANH SỐ",
      },
    };
  }

  @override
  void didUpdateWidget(covariant UserInfoDetailSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userInfo != oldWidget.userInfo) {
      final userInfo = widget.userInfo;
      data = {
        "Thông tin cá nhân": {
          "Số tài khoản": userInfo?.customerCode,
          "Họ và tên": userInfo?.custFullName,
          "CMND/ĐKKD": userInfo?.cardId,
          "Ngày cấp": userInfo?.idIssueDate,
          "Nơi cấp": userInfo?.idIssuePlace,
          "Ngày sinh": userInfo?.custBirthday,
          "Giới tính": userInfo?.custGender?.call,
        },
        "Thông tin liên lạc": {
          "Địa chỉ": userInfo?.contactAddress,
          "Điện thoại": userInfo?.custMobile,
          "Email": userInfo?.custEmail,
          "Người liên hệ": null,
          "Điện thoại (Người liên hệ)": null,
        },
        "Nhân viên chăm sóc": {
          "Tên nhân viên": "DTNT",
          "Chi nhánh": "KINH DOANH SỐ",
        },
      };
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
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
  final Map<String, String?> data;
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
                      data.values.toList().elementAt(i) ?? "-",
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
