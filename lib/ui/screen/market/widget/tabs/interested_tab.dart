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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Danh mục theo dõi",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(child: UserCatalogWidget()),
          const SizedBox(height: 65),
        ],
      ),
    );
  }
}
