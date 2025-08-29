import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomTextField extends StatefulWidget {
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? focusColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const PCustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.focusColor,
    required this.controller,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
    this.prefixText,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  State<PCustomTextField> createState() => _PCustomTextFieldState();
}

class _PCustomTextFieldState extends State<PCustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      style: TextStyle(
        color: PAppColor.whiteColor,
        fontWeight: FontWeight.w600,
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        counter: SizedBox.shrink(),
        focusColor: widget.focusColor,
        prefixText: widget.prefixText,
        prefixIcon: widget.prefixIcon,
        prefixStyle: TextStyle(
          color: PAppColor.whiteColor,
          fontWeight: FontWeight.w600,
        ),
        label: Text(
          widget.labelText,
          style: TextStyle(
            color: _focusNode.hasFocus
                ? PAppColor.primaryBorderColor
                : PAppColor.hintTextColor,
          ),
        ),
        suffixIcon: widget.suffixIcon == null
            ? null
            : IconButton(
                onPressed: () {},
                icon: widget.suffixIcon ?? SizedBox.shrink(),
              ),
      ),
    );
  }
}
