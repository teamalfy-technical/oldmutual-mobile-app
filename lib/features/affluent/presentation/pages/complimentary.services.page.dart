import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

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
      subtitle: 'Partner Medical Facilities',
      description:
          'Complimentary annual health screening at top medical facilities including full body checkup and consultation',
      createdAt: DateTime.now().add(const Duration(days: 50)),
      overview:
          'As an Old Mutual Affluent member, you have access to complimentary annual health screenings at top medical facilities across Ghana. Our partner hospitals provide comprehensive checkups to help you maintain your health and wellbeing.',
      whatsIncluded: [
        'Full body health checkup',
        'Blood pressure and cholesterol screening',
        'Diabetes screening',
        'BMI and body composition analysis',
        'Consultation with specialist physician',
        'Detailed health report',
        'Follow-up recommendations',
        'Priority scheduling',
      ],
      redemptionType: RedemptionType.card,
      redemptionText: 'Simply present your Affluent Card',
      phoneNumber: '+233 302 123 456',
      email: 'healthpartners@oldmutual.com.gh',
      termsAndConditions: [
        'Valid for one screening per calendar year',
        'Appointment must be booked 48 hours in advance',
        'Valid ID and Affluent Card required',
        'Non-transferable benefit',
        'Subject to partner hospital availability',
        'Additional tests may incur extra charges',
        'Results provided within 5 business days',
        'Benefit expires at end of membership year',
      ],
      partnerUrl: 'https://healthpartners.oldmutual.com.gh',
    ),
    ComplimentaryService(
      icon: Assets.icons.airportSecurityIcon.svg(),
      title: 'Airport Lounge Access',
      subtitle: 'Priority Pass & Partner Lounges',
      description:
          'Complimentary access to premium airport lounges at Accra and major international airports.',
      createdAt: DateTime.now().add(const Duration(days: 30)),
      overview:
          'Enjoy complimentary access to premium airport lounges at Kotoka International Airport and select international airports. Relax in comfort before your flight with complimentary refreshments, Wi-Fi, and business facilities.',
      whatsIncluded: [
        'Complimentary food and beverages',
        'High-speed Wi-Fi access',
        'Comfortable seating areas',
        'Business center facilities',
        'Shower facilities',
        'Flight information displays',
        'Newspapers and magazines',
        'Charging stations',
      ],
      redemptionType: RedemptionType.card,
      redemptionText: 'Simply present your Affluent Card',
      phoneNumber: '+233 302 789 012',
      email: 'loungeaccess@oldmutual.com.gh',
      termsAndConditions: [
        'Valid for cardholder and one guest',
        'Maximum stay of 3 hours per visit',
        'Subject to lounge capacity',
        'Valid boarding pass required',
        'Children under 2 years enter free',
        'Smart casual dress code applies',
        'No outside food or beverages',
        'Benefit limited to 4 visits per year',
        'Additional guests at discounted rate',
      ],
      partnerUrl: 'https://lounges.oldmutual.com.gh',
    ),
    ComplimentaryService(
      icon: Assets.icons.colorFoodIcon.svg(),
      title: 'Fine Dining Discounts',
      subtitle: 'Partner Restaurants & Venues',
      description:
          '15% discount at partner restaurants including Santoku, Chez Clarisse, and more premium venues',
      createdAt: DateTime.now().add(const Duration(days: 20)),
      overview:
          'Indulge in exceptional dining experiences at Ghana\'s finest restaurants. As an Affluent member, enjoy exclusive discounts at our partner restaurants featuring international and local cuisines.',
      whatsIncluded: [
        '15% discount on food and beverages',
        'Priority reservations',
        'Complimentary welcome drink',
        'Access to special tasting menus',
        'Invitations to exclusive culinary events',
        'Birthday month special offers',
        'Private dining room access',
        'Sommelier consultations',
      ],
      redemptionType: RedemptionType.qrCode,
      redemptionText:
          'Scan this QR code at the restaurant to redeem your discount',
      qrCodeUrl:
          'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=OLDMUTUAL-DINING-AFFLUENT',
      phoneNumber: '+233 302 345 678',
      email: 'dining@oldmutual.com.gh',
      termsAndConditions: [
        'Valid at participating restaurants only',
        'Not combinable with other offers',
        'Reservation recommended',
        'Discount applies to food and beverages only',
        'Service charge not included',
        'Valid for up to 6 guests per visit',
        'Blackout dates may apply',
        'Management reserves final decision',
      ],
      partnerUrl: 'https://dining.oldmutual.com.gh',
    ),
    ComplimentaryService(
      icon: Assets.icons.hotelIcon.svg(),
      title: 'Luxury Spa Services',
      subtitle: 'Partner Wellness Centers',
      description:
          'Exclusive spa treatments and wellness packages at premium spa facilities.',
      createdAt: DateTime.now().add(const Duration(days: 14)),
      overview:
          'Rejuvenate your body and mind with exclusive spa treatments at our partner wellness centers. Enjoy premium services including massages, facials, and holistic treatments at discounted rates.',
      whatsIncluded: [
        '20% discount on all spa treatments',
        'Complimentary wellness consultation',
        'Access to sauna and steam rooms',
        'Relaxation lounge access',
        'Herbal tea and refreshments',
        'Priority booking',
        'Exclusive member packages',
        'Birthday month complimentary treatment',
      ],
      redemptionType: RedemptionType.code,
      redemptionText: 'Present this redemption code at the spa reception',
      redemptionCode: 'AFFLUENT-SPA-2024',
      phoneNumber: '+233 302 567 890',
      email: 'spa@oldmutual.com.gh',
      termsAndConditions: [
        'Valid at partner spa locations only',
        'Advance booking required',
        'Code valid for single use per visit',
        'Non-transferable',
        'Gratuity not included',
        'Cancellation policy applies',
        'Some treatments require consultation',
        'Age restrictions may apply',
        'Valid membership card required',
      ],
      partnerUrl: 'https://spa.oldmutual.com.gh',
    ),
    ComplimentaryService(
      icon: Assets.icons.golfIcon.svg(),
      title: 'Golf Club Access',
      subtitle: 'Partner Golf Clubs',
      description:
          'Guest privileges at premium golf clubs and exclusive member rates for affluent cardholders.',
      createdAt: DateTime.now().add(const Duration(days: 7)),
      overview:
          'Experience world-class golfing at Ghana\'s premier golf clubs. Enjoy guest privileges, discounted green fees, and access to exclusive member amenities.',
      whatsIncluded: [
        'Discounted green fees',
        'Guest playing privileges',
        'Access to practice facilities',
        'Clubhouse amenities',
        'Pro shop discounts',
        'Golf cart included',
        'Locker room access',
        'Invitations to member tournaments',
      ],
      redemptionType: RedemptionType.card,
      redemptionText: 'Simply present your Affluent Card',
      phoneNumber: '+233 302 901 234',
      email: 'golf@oldmutual.com.gh',
      termsAndConditions: [
        'Valid at partner golf clubs only',
        'Advance tee time booking required',
        'Proper golf attire required',
        'Equipment rental available',
        'Caddy fees not included',
        'Maximum 4 guests per booking',
        'Weekend availability limited',
        'Handicap certificate may be required',
      ],
      partnerUrl: 'https://golf.oldmutual.com.gh',
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
                  return _ServiceCard(
                    service: service,
                    onTap: () => PHelperFunction.switchScreen(
                      destination: Routes.complimentaryServiceDetailPage,
                      args: service,
                    ),
                  );
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
