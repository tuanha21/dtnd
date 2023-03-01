import 'package:flutter/material.dart';

import '../components/user_catalog_widget.dart';

class InterestedTab extends StatefulWidget {
  const InterestedTab({Key? key}) : super(key: key);

  @override
  State<InterestedTab> createState() => _InterestedTabState();
}

class _InterestedTabState extends State<InterestedTab> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: UserCatalogWidget(),
    );
  }
}
