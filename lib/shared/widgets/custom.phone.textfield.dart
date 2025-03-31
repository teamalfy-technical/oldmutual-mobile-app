import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomPhoneTextfield extends StatefulWidget {
  final String labelText;
  final bool enabled;
  final dynamic ctrl;
  const PCustomPhoneTextfield({
    super.key,
    required this.ctrl,
    required this.labelText,
    this.enabled = true,
  });

  @override
  State<PCustomPhoneTextfield> createState() => _PCustomPhoneTextfieldState();
}

class _PCustomPhoneTextfieldState extends State<PCustomPhoneTextfield> {
  bool focused = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(focusListener);
    super.initState();
  }

  void focusListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        focused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(focusListener);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s14,
            fontWeight: FontWeight.w600,
          ),
        ),
        PAppSize.s6.verticalSpace,
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PAppSize.s5),
            color: PAppColor.whiteColor,
            border: Border.all(
              width: PAppSize.s1,
              color: focused ? PAppColor.primary : PAppColor.fillColor,
            ),
          ),
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Utils.countryCodeToEmoji(
                          widget.ctrl.selectedCountry.value.countryCode,
                        ),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: PAppSize.s24,
                        ),
                      ),
                      PAppSize.s2.horizontalSpace,
                      Text('+${widget.ctrl.selectedCountry.value.phoneCode}'),
                      PAppSize.s2.horizontalSpace,
                      const Icon(Icons.keyboard_arrow_down),
                      const VerticalDivider(
                        color: PAppColor.text500,
                      ).symmetric(vertical: PAppSize.s6),
                    ],
                  ),
                ).only(left: PAppSize.s16),
                Expanded(
                  child:
                      TextFormField(
                        enabled: widget.enabled,
                        textAlignVertical: TextAlignVertical.center,
                        controller: widget.ctrl!.phoneTEC,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        focusNode: focusNode,
                        onFieldSubmitted: (val) {
                          focusNode.unfocus();
                          if (focused) {
                            setState(() {
                              focused = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          counter: SizedBox.shrink(),
                          // counterText: '',
                          hintText: 'enter_phone_number'.tr,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          focusColor:
                              PDeviceUtil.isKeyboardVisible(context)
                                  ? PAppColor.primary
                                  : PAppColor.text100,
                        ),
                        // validator: PValidator.validatePhoneNumber,
                      ).centered(),
                ),
              ],
            ),
          ),
        ).onPressed(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode:
                  true, // optional. Shows phone code before the country name.
              countryListTheme: CountryListThemeData(
                bottomSheetHeight:
                    PDeviceUtil.getDeviceHeight(context) /
                    2, // Optional. Country list modal height
                //Optional. Sets the border radius for the bottomsheet.
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(PAppSize.s8),
                  topRight: Radius.circular(PAppSize.s8),
                ),
                //Optional. Styles the search field.
                inputDecoration: InputDecoration(
                  labelText: 'Search a country',
                  hintText: 'Start typing to search',
                  labelStyle: const TextStyle().copyWith(fontSize: 14),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: PAppColor.text500,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: PAppColor.text500),
                  ),
                ),
              ),
              onSelect: (Country country) {
                widget.ctrl.setSelectedCountry(country);
              },
            );
          },
        ),
      ],
    );
  }
}
