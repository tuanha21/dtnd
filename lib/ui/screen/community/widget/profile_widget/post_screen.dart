import 'package:flutter/cupertino.dart';

import '../single_post.dart';

class PostScreen extends StatefulWidget {
  final ScrollController scrollController;

  const PostScreen(this.scrollController, {Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: 4,
      itemBuilder: (context, index) {
        return const SinglePost();
      },
    );
  }
}
