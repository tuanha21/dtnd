import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 168,
          child: Image.asset(AppImages.scene),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title ?? "Danh sách rỗng")],
        )
      ],
    );
  }
}
