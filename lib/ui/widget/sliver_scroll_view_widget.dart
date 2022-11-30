import 'package:flutter/material.dart';

class SliverScrollViewWidget extends StatelessWidget {
  const SliverScrollViewWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: child,
          ),
        ],
      ),
    );
  }
}
