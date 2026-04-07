import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomDropdownField<T> extends StatelessWidget {
  const PCustomDropdownField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    this.items,
  });
  final String labelText;
  final T? initialValue;
  final Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      dropdownColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.cardDarkColor
          : PAppColor.whiteColor,
      menuMaxHeight: PDeviceUtil.getDeviceHeight(context) * 0.30,
      decoration: InputDecoration(labelText: labelText),
      initialValue: initialValue,
      onChanged: onChanged,
      items: items,
    );
  }
}
