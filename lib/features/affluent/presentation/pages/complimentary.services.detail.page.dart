import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PComplimentaryServiceDetailPage extends StatelessWidget {
  final ComplimentaryService service;
  const PComplimentaryServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(service.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Subtitle Label
                  Text(
                    service.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PAppSize.s20.verticalSpace,

                  // Overview Section
                  if (service.overview != null) ...[
                    _SectionTitle(title: 'overview'.tr),
                    PAppSize.s12.verticalSpace,
                    Text(
                      service.overview!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                    PAppSize.s24.verticalSpace,
                  ],

                  // What's Included Section
                  if (service.whatsIncluded != null &&
                      service.whatsIncluded!.isNotEmpty) ...[
                    _SectionTitle(title: 'whats_included'.tr),
                    PAppSize.s12.verticalSpace,
                    ...service.whatsIncluded!.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: PAppSize.s8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: PAppSize.s4),
                              child: Icon(
                                Icons.circle,
                                size: PAppSize.s8,
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.blackColor,
                              ),
                            ),
                            PAppSize.s12.horizontalSpace,
                            Expanded(
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: PAppSize.s16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PAppSize.s24.verticalSpace,
                  ],

                  // How to Redeem Section
                  _SectionTitle(title: 'how_to_redeem'.tr),
                  PAppSize.s12.verticalSpace,
                  _buildRedemptionSection(context),
                  PAppSize.s24.verticalSpace,

                  // Contact Information Section
                  if (service.phoneNumber != null || service.email != null) ...[
                    _SectionTitle(title: 'contact_information'.tr),
                    PAppSize.s12.verticalSpace,
                    _buildContactSection(context),
                    PAppSize.s24.verticalSpace,
                  ],

                  // Terms & Conditions Section
                  if (service.termsAndConditions != null &&
                      service.termsAndConditions!.isNotEmpty) ...[
                    _SectionTitle(title: 'terms_and_conditions'.tr),
                    PAppSize.s12.verticalSpace,
                    ...service.termsAndConditions!.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: PAppSize.s8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: PAppSize.s4),
                              child: Icon(
                                Icons.circle,
                                size: PAppSize.s8,
                                color: PHelperFunction.isDarkMode(context)
                                    ? PAppColor.whiteColor
                                    : PAppColor.blackColor,
                              ),
                            ),
                            PAppSize.s12.horizontalSpace,
                            Expanded(
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: PAppSize.s16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PAppSize.s24.verticalSpace,
                  ],
                ],
              ).scrollable(),
            ),

            PAppSize.s20.verticalSpace,

            // Bottom Action Buttons
            Row(
              children: [
                Expanded(
                  child: PGradientButton(
                    label: 'visit_partner'.tr.toUpperCase(),
                    showIcon: false,
                    textColor: PAppColor.whiteColor,
                    onTap: service.partnerUrl != null
                        ? () => _launchPartnerUrl()
                        : null,
                  ),
                ),
                PAppSize.s12.horizontalSpace,
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _contactRelationshipOfficer(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.blackColor,
                      side: BorderSide(
                        color: PHelperFunction.isDarkMode(context)
                            ? PAppColor.whiteColor
                            : PAppColor.blackColor,
                      ),
                      minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PAppSize.s24),
                      ),
                    ),
                    child: Text(
                      'contact_ro'.tr.toUpperCase(),
                      style: TextStyle(
                        fontSize: PAppSize.s16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }

  Widget _buildRedemptionSection(BuildContext context) {
    switch (service.redemptionType) {
      case RedemptionType.qrCode:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (service.redemptionText != null)
              Text(
                service.redemptionText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            PAppSize.s16.verticalSpace,
            Center(
              child: Container(
                padding: EdgeInsets.all(PAppSize.s16),
                decoration: BoxDecoration(
                  color: PAppColor.whiteColor,
                  borderRadius: BorderRadius.circular(PAppSize.s12),
                  border: Border.all(
                    color: PAppColor.greyColor.withOpacityExt(0.3),
                  ),
                ),
                child: service.qrCodeUrl != null
                    ? Image.network(
                        service.qrCodeUrl!,
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildQrPlaceholder(),
                      )
                    : _buildQrPlaceholder(),
              ),
            ),
          ],
        );

      case RedemptionType.code:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (service.redemptionText != null)
              Text(
                service.redemptionText!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            PAppSize.s16.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: PAppSize.s20,
                vertical: PAppSize.s16,
              ),
              decoration: BoxDecoration(
                color: PAppColor.primary.withOpacityExt(0.1),
                borderRadius: BorderRadius.circular(PAppSize.s12),
                border: Border.all(
                  color: PAppColor.primary.withOpacityExt(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.redemptionCode ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s20,
                      fontWeight: FontWeight.w700,
                      color: PAppColor.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  PAppSize.s12.horizontalSpace,
                  IconButton(
                    onPressed: () => _copyToClipboard(context),
                    icon: Icon(
                      Icons.copy_rounded,
                      color: PAppColor.primary,
                      size: PAppSize.s20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case RedemptionType.card:
        return Text(
          service.redemptionText ?? 'simply_present_affluent_card'.tr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: PAppSize.s14,
            fontWeight: FontWeight.w600,
            color: PAppColor.primary,
          ),
        );
    }
  }

  Widget _buildQrPlaceholder() {
    return SizedBox(
      width: 180.w,
      height: 180.w,
      child: Icon(
        Icons.qr_code_2_rounded,
        size: 120.w,
        color: PAppColor.greyColor,
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      children: [
        if (service.phoneNumber != null)
          _ContactInfoRow(
            icon: Assets.icons.call.svg(
              width: PAppSize.s20,
              height: PAppSize.s20,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.primary,
            ),
            value: service.phoneNumber!,
            onTap: () => _makePhoneCall(),
          ),
        if (service.phoneNumber != null && service.email != null)
          PAppSize.s4.verticalSpace,
        if (service.email != null)
          _ContactInfoRow(
            icon: Assets.icons.mail.svg(
              width: PAppSize.s20,
              height: PAppSize.s20,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.primary,
            ),
            value: service.email!,
            onTap: () => _sendEmail(),
          ),
      ],
    );
  }

  void _launchPartnerUrl() {
    // TODO: Implement URL launcher
  }

  void _contactRelationshipOfficer() {
    // TODO: Implement contact RO functionality
  }

  void _makePhoneCall() {
    // TODO: Implement phone call
  }

  void _sendEmail() {
    // TODO: Implement email
  }

  void _copyToClipboard(BuildContext context) {
    if (service.redemptionCode != null) {
      Clipboard.setData(ClipboardData(text: service.redemptionCode!));
      Get.snackbar(
        'copied'.tr,
        'redemption_code_copied'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: PAppSize.s16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ContactInfoRow extends StatelessWidget {
  final Widget icon;
  final String value;
  final VoidCallback? onTap;

  const _ContactInfoRow({required this.icon, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(PAppSize.s8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: PAppSize.s4),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(PAppSize.s8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: PAppSize.s1,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.whiteColor
                      : PAppColor.primary,
                ),
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
              ),
              child: icon,
            ),
            PAppSize.s8.horizontalSpace,
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: PAppSize.s16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
