import 'package:flutter/material.dart';

class Step1CreateGroup extends StatefulWidget {
  const Step1CreateGroup({Key? key}) : super(key: key);

  @override
  State<Step1CreateGroup> createState() => _Step1CreateGroupState();
}

class _Step1CreateGroupState extends State<Step1CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tên nhóm",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
            ],
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
              hintText: "Tên của nhóm",
            ),
            maxLines: null,
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Lưu ý : ",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                TextSpan(
                  text:
                      "Bạn sẽ không được thay đổi tên nhóm sau khi tạo phòng.",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Giới thiệu về nhóm",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            child: TextField(
              cursorColor: Colors.red,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                disabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Mô tả về nhóm",
              ),
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
}
