import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PComplimentaryServicePage extends StatefulWidget {
  const PComplimentaryServicePage({super.key});

  @override
  State<PComplimentaryServicePage> createState() =>
      _PComplimentaryServicePageState();
}

class _PComplimentaryServicePageState extends State<PComplimentaryServicePage> {
  final vm = PAffluentVm.instance;

  final List<ComplimentaryService> services = [
    ComplimentaryService(
      icon: Assets.icons.healthIcons.svg(),
      title: 'Premium Health Screening',
      description:
          'Complimentary annual health screening at top medical facilities including full body checkup and consultation',
      createdAt: DateTime.now().add(const Duration(days: 50)),
    ),
    ComplimentaryService(
      icon: Assets.icons.airportSecurityIcon.svg(),
      title: 'Airport Lounge Access',
      description:
          'Complimentary access to premium airport lounges at Accra and major international airports.',
      createdAt: DateTime.now().add(const Duration(days: 30)),
    ),
    ComplimentaryService(
      icon: Assets.icons.colorFoodIcon.svg(),
      title: 'Fine Dining Discounts',
      description:
          '15% discount at partner restaurants including Santoku, Chez Clarisse, and more premium venues',
      createdAt: DateTime.now().add(const Duration(days: 20)),
    ),
    ComplimentaryService(
      icon: Assets.icons.hotelIcon.svg(),
      title: 'Hotel Upgrades',
      description:
          'Complimentary room upgrades and late checkout at participating luxury hotels worldwide.',
      createdAt: DateTime.now().add(const Duration(days: 14)),
    ),
    ComplimentaryService(
      icon: Assets.icons.golfIcon.svg(),
      title: 'Golf Club Access',
      description:
          'Guest privileges at premium golf clubs and exclusive member rates for affluent cardholders.',
      createdAt: DateTime.now().add(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('complementary_benefits'.tr)),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PAppSize.s16.verticalSpace,

            // Category Pills
            PCategoryPills(
              categories: vm.cCategories,
              selectedIndex: vm.selectedCCategoryIndex.value,
              onSelected: vm.onSelectedCCategory,
            ),

            PAppSize.s16.verticalSpace,

            // Services List
            Expanded(
              child: ListView.separated(
                itemCount: services.length,
                separatorBuilder: (context, index) =>
                    PAppSize.s16.verticalSpace,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _ServiceCard(service: service, onTap: () {});
                },
              ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, this.onTap});

  final ComplimentaryService service;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.cardDarkColor
            : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s20),
      ),
      child:
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: EdgeInsets.all(PAppSize.s16),
                    decoration: BoxDecoration(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor.withOpacityExt(PAppSize.s0_1)
                          : PAppColor.primary.withOpacityExt(PAppSize.s0_1),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: PAppSize.s24,
                      height: PAppSize.s24,
                      child: service.icon,
                    ),
                  ),

                  PAppSize.s12.verticalSpace,

                  // Title
                  Text(
                    service.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  PAppSize.s8.verticalSpace,

                  // Description
                  Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  PAppSize.s8.verticalSpace,

                  // Date
                  Text(
                    'valid_until'.trParams({
                      'date': PFormatter.formatDate(
                        dateFormat: DateFormat('MMM yyyy'),
                        date: service.createdAt,
                      ),
                    }),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s13,
                      fontWeight: FontWeight.w500,
                      color: PAppColor.primary,
                    ),
                  ),
                ],
              )
              .paddingAll(PAppSize.s24)
              .onPressed(
                onTap: onTap,
                radius: BorderRadius.circular(PAppSize.s20),
              ),
    );
  }
}
