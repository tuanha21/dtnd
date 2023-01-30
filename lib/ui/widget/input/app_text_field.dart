import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;

  final TextEditingController? controller;

  const AppTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: widget.readOnly,
        obscureText: _obscureText,
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            suffixIcon: !widget.obscureText
                ? null
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(_obscureText
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined))));
  }
}
