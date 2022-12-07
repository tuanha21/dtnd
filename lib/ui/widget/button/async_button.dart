import 'package:dtnd/utilities/typedef.dart';
import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.style,
  });
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final OnAsyncButtonPressed onPressed;
  final ButtonStyle? style;
  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Widget button = TextButton(
      onPressed: () async {
        if (loading) {
          return;
        } else {
          setState(() {
            loading = true;
          });
          await widget.onPressed.call();
          setState(() {
            loading = false;
          });
        }
      },
      child: Builder(
        builder: (context) {
          if (loading) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
          return widget.child;
        },
      ),
    );
    return button;
  }
}
