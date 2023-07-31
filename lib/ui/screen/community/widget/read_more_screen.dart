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
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Đáng chú ý",
          style: TextStyle(fontSize: 16, color: themeData.colorScheme.onBackground,fontWeight: FontWeight.w500),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [SinglePost(),
          PremiumPostGroup()
          ],
        ),
      ),
    );
  }
}
