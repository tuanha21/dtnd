import 'package:dtnd/ui/screen/community/widget/premium_widget/premium_post_group.dart';
import 'package:dtnd/ui/screen/community/widget/single_post.dart';
import 'package:flutter/material.dart';

class ReadMoreScreen extends StatefulWidget {
  const ReadMoreScreen({Key? key}) : super(key: key);

  @override
  State<ReadMoreScreen> createState() => _ReadMoreScreenState();
}

class _ReadMoreScreenState extends State<ReadMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Đáng chú ý",
          style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [SinglePost(),
          PremiumPostGroup()
          ],
        ),
      ),
    );
  }
}
