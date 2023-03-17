import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Color? fillColor;
  final InputBorder? border;
  final GestureTapCallback? onTap;

  final TextEditingController? controller;

  const AppTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.fillColor,
    this.border,
    this.onTap,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  Widget? get suffixIcon {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    return !widget.obscureText
        ? null
        : GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined));
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return TextField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: widget.border,
            focusedBorder: widget.border,
            enabledBorder: widget.border,
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            labelText: widget.labelText,
            hintText: widget.hintText,
            suffixIcon: suffixIcon,
          ),
        );
      },
    );
  }
}
