import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PIdEntryPage extends StatefulWidget {
  const PIdEntryPage({super.key});

  @override
  State<PIdEntryPage> createState() => _PIdEntryPageState();
}

class _PIdEntryPageState extends State<PIdEntryPage> {
  final ctrl = Get.put(PAuthVm());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('identify_verification'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s8.verticalSpace,
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PAppSize.s8.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'identify_verification_hint'.tr,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.secondary500
                                  : PAppColor.darkAppBarColor2,
                              fontSize: PAppSize.s16,
                            ),
                      ),
                    ),

                    PAppSize.s34.verticalSpace,

                    PCustomTextField(
                      // labelText: 'password'.tr,
                      controller: ctrl.ghanaCardNumberTEC,
                      prefixText: 'GHA-',
                      labelText: 'ghana_card_number'.tr,
                      textInputType: TextInputType.number,
                      validator: PValidator.validateIdNumber,
                      maxLength: 11,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        IdNumberFormatter(),
                      ],
                    ),
                    PAppSize.s28.verticalSpace,

                    Obx(
                      () => PGradientButton(
                        label: 'continue'.tr,
                        showIcon: false,
                        loading: ctrl.loading.value,
                        width: PDeviceUtil.getDeviceWidth(context),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            ctrl.verifyGhanaCard();
                          }
                        },
                      ),
                    ),
                    PAppSize.s40.verticalSpace,

                    NoteWidget(
                      title: 'why_ghana_card'.tr,
                      description: 'why_ghana_card_msg'.tr,
                    ), // already have an account
                  ],
                ).scrollable(),
              ),
            ),

            // PAppSize.s10.verticalSpace,
          ],
        ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
      ),
    );
  }
}
