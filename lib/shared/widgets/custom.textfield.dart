import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
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
  final bool? alignLabelWithHint;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

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
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.alignLabelWithHint,
    this.hintText,
    this.errorText,
    this.focusNode,
    this.textInputAction,
  });

  @override
  State<PCustomTextField> createState() => _PCustomTextFieldState();
}

class _PCustomTextFieldState extends State<PCustomTextField> {
  late final FocusNode _focusNode;
  bool _ownsNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsNode = true;
    }
    _focusNode.addListener(() {
      setState(() {}); // rebuild when focus changes
    });
  }

  @override
  void dispose() {
    if (_ownsNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      style: TextStyle(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.whiteColor
            : PAppColor.text500,
        fontWeight: FontWeight.w600,
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: widget.alignLabelWithHint,
        counter: SizedBox.shrink(),
        errorText: widget.errorText,
        focusColor: widget.focusColor,
        prefixText: widget.prefixText,
        prefixIcon: widget.prefixIcon,
        prefixStyle: TextStyle(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.text500,
          fontWeight: FontWeight.w600,
        ),
        hintText: widget.hintText,
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
