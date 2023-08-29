import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AsyncSingleColorTextButton extends StatefulWidget {
  const AsyncSingleColorTextButton({
    super.key,
    required this.text,
    required this.color,
    this.textStyle,
    this.onTap,
  });
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final AsyncCallback? onTap;

  @override
  State<AsyncSingleColorTextButton> createState() =>
      _AsyncSingleColorTextButtonState();
}

class _AsyncSingleColorTextButtonState
    extends State<AsyncSingleColorTextButton> {
  bool loading = false;

  void _onTap() async {
    if (loading) {
      return;
    } else {
      setState(() {
        loading = true;
      });
      await widget.onTap!();
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Builder(
              builder: (context) {
                if (loading) {
                  return const SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Text(
                  widget.text,
                  style: widget.textStyle ??
                      AppTextStyle.titleSmall_14.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
