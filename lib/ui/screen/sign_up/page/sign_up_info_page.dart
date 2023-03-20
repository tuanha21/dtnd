import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/sign_up/widget/sign_up_info_form.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignUpInfoPage extends StatefulWidget {
  const SignUpInfoPage({super.key, required this.onSuccess});
  final VoidCallback onSuccess;

  @override
  State<SignUpInfoPage> createState() => _SignUpInfoPageState();
}

class _SignUpInfoPageState extends State<SignUpInfoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            S.of(context).hi_you,
            style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text:
                      'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng',
                  style: titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.neutral_04)),
              TextSpan(
                  text: ' DTND ',
                  style: titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary_01)),
              TextSpan(
                  text: 'bạn nhé',
                  style: titleSmall?.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.neutral_04))
            ]),
          ),
          const SizedBox(height: 36),
          SignUpInfoForm(
            onSuccess: widget.onSuccess,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
