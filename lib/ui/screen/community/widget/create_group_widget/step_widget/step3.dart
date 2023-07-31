import 'package:flutter/material.dart';

class Step3CreateGroup extends StatefulWidget {
  const Step3CreateGroup({Key? key}) : super(key: key);

  @override
  State<Step3CreateGroup> createState() => _Step3CreateGroupState();
}

class _Step3CreateGroupState extends State<Step3CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Text(
            "Bổ sung các thông tin dưới đây sẽ giúp cho người tham gia nhóm hiểu rõ hơn về bạn và phong cách đầu tư của bạn",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildTextFieldWithTitle("Học vấn", "Tên trường của bạn"),
          const SizedBox(
            height: 20,
          ),
          _buildTextFieldWithTitle(
              "Nghề nghiệp", "Nghề nghiệp hiện tại của bạn"),
          const SizedBox(
            height: 20,
          ),
          _buildTextFieldWithTitle(
              "Nơi công tác", "Nơi công tác hiện tại của bạn"),
          const SizedBox(
            height: 20,
          ),
          _buildTextFieldWithTitle("Kinh nghiệm đầu tư", "Số năm kinh nghiệm"),
          const SizedBox(
            height: 20,
          ),
          _buildTextFieldWithTitle("Giới thiệu về bản thân",
              "Đôi điều giới thiệu về bản thân và phong cách đầu tư của bạn."),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: const Text("0/1000"),
          ),
        ],
      ),
    );
  }
}

Widget _buildTextFieldWithTitle(String title, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(title),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        cursorColor: Colors.red,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
        ),
        maxLines: null,
      ),
    ],
  );
}
