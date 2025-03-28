import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/domain/models/contributed.year.model.dart';

class PCustomDropdown<T> extends StatelessWidget {
  final String label;
  final double? height;
  Color color;
  final T? value;
  final Widget? hint;
  final List<T> items;
  final Function(T?)? onChanged;

  PCustomDropdown({
    super.key,
    this.color = PAppColor.blackColor,
    this.height,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        PAppSize.s4.verticalSpace,
        SizedBox(
          height: height,
          child: DropdownButtonFormField<T>(
            focusColor: PAppColor.fillColor2,
            dropdownColor:
                PHelperFunction.isDarkMode(context)
                    ? PAppColor.lightBlackColor
                    : PAppColor.whiteColor,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color:
                  PHelperFunction.isDarkMode(context)
                      ? PAppColor.text50
                      : color,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(PAppSize.s5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(PAppSize.s5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(PAppSize.s5),
              ),
              filled: true,
              fillColor: PAppColor.fillColor2,
              contentPadding: const EdgeInsets.symmetric(
                vertical: PAppSize.s2,
                horizontal: PAppSize.s10,
              ),
            ),
            hint: hint,
            value: value,
            items:
                items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          (e is String)
                              ? e
                              : (e is ContributedYear)
                              ? e.fundYear.toString()
                              : '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    )
                    .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
