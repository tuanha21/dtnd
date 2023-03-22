import 'dart:async';

import 'package:flutter/material.dart';

enum ValidateType { delay, immediately }

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
  final GlobalKey<FormFieldState<String?>>? formKey;
  final ValidateType validateType;

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
    this.formKey,
    this.validateType = ValidateType.delay,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final TextEditingController _textFieldController;
  late final GlobalKey<FormFieldState<String?>> formKey;
  bool _obscureText = false;
  Timer? _debounce;
  String? _errorMessage;

  String? _validator(String? value) {
    setState(() {
      _errorMessage = widget.validator?.call(value);
    });
    return _errorMessage;
  }

  void _onChanged(FormFieldState<String?> state, String input) {
    widget.onChanged?.call(input);
    state.didChange(input);
    // Cancel previous timer if it exists
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    // Set up a new timer
    _debounce =
        Timer(const Duration(milliseconds: 500), () => state.validate());
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  void initState() {
    _textFieldController = widget.controller ?? TextEditingController();
    formKey = widget.formKey ?? GlobalKey<FormFieldState<String?>>();
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
    return FormField<String?>(
      key: formKey,
      validator: _validator,
      builder: (state) {
        return Column(
          children: [
            TextField(
              onTap: widget.onTap,
              autocorrect: false,
              enableSuggestions: false,
              readOnly: widget.readOnly,
              obscureText: _obscureText,
              controller: _textFieldController,
              onChanged: (value) => _onChanged(state, value),
              decoration: InputDecoration(
                errorText: _errorMessage,
                border: widget.border,
                focusedBorder: widget.border,
                enabledBorder: widget.border,
                fillColor: widget.fillColor,
                filled: widget.fillColor != null,
                labelText: widget.labelText,
                hintText: widget.hintText,
                suffixIcon: suffixIcon,
              ),
            ),
            // ExpandedSection(
            //     expand: _errorMessage != null,
            //     child: Text(
            //       _errorMessage ?? "",
            //       style: const TextStyle(color: Colors.red),
            //     ))
          ],
        );
      },
    );
  }
}
