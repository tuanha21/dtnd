import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class MaterialDialog extends StatelessWidget {
  const MaterialDialog(
      {super.key,
      required this.header,
      required this.content,
      required this.buttons});
  final Widget header;
  final Widget content;
  final List<Widget> buttons;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox.square(
                    dimension: 60,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary_03,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        size: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Center(
              child: Column(
                // direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  header,
                  const SizedBox(height: 16),
                  content,
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: buttons,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
