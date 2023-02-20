import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class ListCommentTab extends StatefulWidget {
  const ListCommentTab({Key? key}) : super(key: key);

  @override
  State<ListCommentTab> createState() => _ListCommentTabState();
}

class _ListCommentTabState extends State<ListCommentTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Align(
              alignment: Alignment.centerRight,
              child: Text(S.of(context).interested))
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
