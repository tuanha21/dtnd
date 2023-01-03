import 'package:dtnd/ui/screen/community/widget/post_widget.dart';
import 'package:flutter/material.dart';
import '../../../widget/my_appbar.dart';

class CommentDetailPage extends StatefulWidget {
  const CommentDetailPage({Key? key}) : super(key: key);

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Chi tiết bài viết',
      ),
      body: Column(
        children: const [
          PostWidget(),
          
        ],
      ),
    );
  }
}
