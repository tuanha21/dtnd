import 'package:dtnd/ui/widget/input/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_color.dart';

class ReferencePage extends StatefulWidget {
  const ReferencePage({Key? key}) : super(key: key);

  @override
  State<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  final referenceCode = TextEditingController();
  final reference = TextEditingController();

  final ValueNotifier<bool> isShowAction = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chào bạn",
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: 'DTND',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary_01)),
                TextSpan(
                    text: ' bạn nhé',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
              ]),
            ),
            const SizedBox(height: 36),
            AppTextField(
              controller: referenceCode,
              onChanged: (code) {
                isShowAction.value = code.isNotEmpty;
              },
              labelText: 'Mã giới thiệu',
              hintText: 'Nhập mã giới thiệu',
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: reference,
              readOnly: true,
              labelText: 'Người giới thiệu',
              hintText: 'Nhập tên người giới thiệu',
            ),
            const SizedBox(height: 36),
            ValueListenableBuilder(
              valueListenable: isShowAction,
              builder: (BuildContext context, bool value, Widget? child) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: value ? () {
                          context.pushNamed('success');
                        } : null,
                        child: const Text("Lưu")));
              },
            ),
            const SizedBox(height: 36),
            GestureDetector(
              onTap: (){
                context.pushNamed('success');
              },
              child: Center(
                  child: Text(
                'Bỏ qua',
                style: titleSmall?.copyWith(color: AppColors.primary_01),
              )),
            )
          ],
        ),
      ),
    );
  }
}
