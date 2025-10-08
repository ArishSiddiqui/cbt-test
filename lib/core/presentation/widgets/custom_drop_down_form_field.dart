import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomDropDownFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>>? items;
  const CustomDropDownFormField({
    required this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.validator,
    required this.items,
    super.key,
  });

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
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
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 7.0),
        DropdownButtonFormField<String>(
          value: widget.value,
          validator: widget.validator,
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.grey,
          ),
          hint: widget.hint == null
              ? null
              : Text(
                  widget.hint!,
                  style: const TextStyle(color: AppColors.grey),
                ),
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 11.0,
              horizontal: 15.0,
            ),
            border: borderDeco,
            enabledBorder: borderDeco,
            disabledBorder: borderDeco,
            errorBorder: errorBorderDeco,
            focusedErrorBorder: errorBorderDeco,
            focusedBorder: focusedBorderDeco,
          ),
          items: widget.items,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
