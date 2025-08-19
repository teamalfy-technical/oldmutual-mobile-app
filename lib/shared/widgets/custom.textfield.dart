import 'package:flutter/material.dart';
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
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        focusColor: widget.focusColor,
        prefixIcon: widget.prefixIcon,
        label: Text(
          widget.labelText,
          style: TextStyle(
            color: _focusNode.hasFocus
                ? PAppColor.primary
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
