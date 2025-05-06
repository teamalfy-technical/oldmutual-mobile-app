import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomFilledTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  const PCustomFilledTextfield({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
        PAppSize.s4.verticalSpace,
        TextFormField(
          controller: controller,
          keyboardType: textInputType,
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            counter: SizedBox.shrink(),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: PAppSize.s10,
              color: PAppColor.errorColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: PAppSize.s20,
              vertical: PAppSize.s6,
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(PAppSize.s5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(PAppSize.s5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(PAppSize.s5),
            ),
            fillColor: PAppColor.fillColor2,
            filled: true,
          ),
        ),
      ],
    );
  }
}
