import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatter;
  final int? minLines;
  final int? maxLines;
  final bool canEdit;
  final void Function()? onTap;
  final AutovalidateMode autovalidateMode;
  const CustomTextField({
    required this.label,
    this.hint,
    this.onChanged,
    this.validator,
    this.controller,
    this.keyboardType,
    this.isPasswordField = false,
    this.inputFormatter,
    this.minLines = 1,
    this.maxLines = 1,
    this.canEdit = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onTap,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool hasFocus = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    obscureText = widget.isPasswordField;
    _focusNode.addListener(() {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    });
  }

  final OutlineInputBorder borderDeco = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
  );

  final OutlineInputBorder focusedBorderDeco = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: AppColors.violet, width: 1.0),
  );

  final OutlineInputBorder errorBorderDeco = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: AppColors.red, width: 1.0),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.deepBlack,
          ),
        ),
        const SizedBox(height: 7.0),
        GestureDetector(
          onTap: widget.canEdit ? null : widget.onTap,
          child: TextFormField(
            autovalidateMode: widget.autovalidateMode,
            readOnly: !widget.canEdit,
            onTap: widget.onTap,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            focusNode: _focusNode,
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: obscureText,
            inputFormatters: widget.inputFormatter,
            style: const TextStyle(color: AppColors.deepBlack),
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              isCollapsed: true,
              suffixIcon: widget.isPasswordField
                  ? GestureDetector(
                      onTap: () => setState(() {
                        obscureText = !obscureText;
                      }),
                      child: Icon(
                        obscureText
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: hasFocus ? AppColors.violet : AppColors.grey,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 11.0,
                horizontal: 15.0,
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(color: AppColors.grey),
              border: borderDeco,
              enabledBorder: borderDeco,
              disabledBorder: borderDeco,
              errorBorder: errorBorderDeco,
              focusedErrorBorder: errorBorderDeco,
              focusedBorder: focusedBorderDeco,
            ),
          ),
        ),
      ],
    );
  }
}
