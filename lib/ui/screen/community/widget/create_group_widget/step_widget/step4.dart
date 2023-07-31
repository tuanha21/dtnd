import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../create_group_controller.dart';

class Step4CreateGroup extends StatefulWidget {
  const Step4CreateGroup({Key? key}) : super(key: key);

  @override
  State<Step4CreateGroup> createState() => _Step4CreateGroupState();
}

class _Step4CreateGroupState extends State<Step4CreateGroup> {
  final CreateGroupController controller = CreateGroupController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Text(
            "Bạn có thể chỉnh sửa lại các ảnh này sau khi đã tạo nhóm thành công",
          ),
          const SizedBox(
            height: 20,
          ),
          _buildImageSelectorWithTitle(
              "Ảnh đại diện*", () => controller.pickImageAvatar()),
          Obx(() {
            final image = controller.imageBackground.value;
            return _buildImagePreview(image);
          }),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildImageSelectorWithTitle(
              "Ảnh bìa", () => controller.pickImageBackground()),
          Obx(() {
            final image = controller.imageBackground.value;
            return _buildImagePreview(image);
          }),
        ],
      ),
    );
  }
}

Widget _buildImageSelectorWithTitle(String title, VoidCallback onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      InkWell(
        onTap: onPressed,
        child: const Text(
          "Tải ảnh lên",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ],
  );
}

Widget _buildImagePreview(image) {
  return image != null
      ? Image.file(image)
      : CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.image_outlined,
            color: Colors.grey,
          ),
        );
}
