import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PAffluentCardPage extends StatefulWidget {
  final Member? user;
  const PAffluentCardPage({super.key, this.user});

  @override
  State<PAffluentCardPage> createState() => _PAffluentCardPageState();
}

class _PAffluentCardPageState extends State<PAffluentCardPage> {
  final vm = PAffluentVm.instance;
  final GlobalKey _cardKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _shareCard() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      // Capture the card as an image
      final boundary = _cardKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Could not capture card image');
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Could not convert image to bytes');
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/affluent_card.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Share the image
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'My Old Mutual Affluent Member Card',
          subject: 'Affluent Member Card',
        ),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'Could not share card. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);
    final user = widget.user;

    return Scaffold(
      backgroundColor: isDarkMode ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('my_affluent_card'.tr)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affluent Card with Gradient Border
            RepaintBoundary(
              key: _cardKey,
              child: PAffluentMemberCard(
                memberName: user?.name ?? '',
                cardNumber: user?.ghanaCardNumber ?? 'AFF-2024-00847',
                memberSince: 'Jan 2023',
                relationshipOfficer: 'Sarah Osei',
              ),
            ),

            PAppSize.s25.verticalSpace,

            //  Action Buttons
            Row(
              children: [
                Expanded(
                  child: PGradientButton(
                    label: 'download_card'.tr.toUpperCase(),
                    showIcon: false,
                    textColor: PAppColor.whiteColor,
                    onTap: () {},
                  ),
                ),
                PAppSize.s12.horizontalSpace,
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSharing ? null : _shareCard,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDarkMode
                          ? PAppColor.whiteColor
                          : PAppColor.blackColor,
                      side: BorderSide(
                        color: isDarkMode
                            ? PAppColor.whiteColor
                            : PAppColor.blackColor,
                      ),
                      minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PAppSize.s24),
                      ),
                    ),
                    child: _isSharing
                        ? SizedBox(
                            width: PAppSize.s20,
                            height: PAppSize.s20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDarkMode
                                  ? PAppColor.whiteColor
                                  : PAppColor.blackColor,
                            ),
                          )
                        : Text(
                            'share_securely'.tr.toUpperCase(),
                            style: TextStyle(
                              fontSize: PAppSize.s16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),

            PAppSize.s20.verticalSpace,
            // Bookmarked Articles Section
            PSeeAllWidget(
              leadingText: 'save_content'.tr,

              onTap: () => PHelperFunction.switchScreen(
                destination: Routes.financialInsightPage,
              ),
            ),

            PAppSize.s6.verticalSpace,

            Text(
              'bookmarked_articles'.tr,
              style: TextStyle(
                fontSize: PAppSize.s14,
                fontWeight: FontWeight.w400,
              ),
            ),

            PAppSize.s12.verticalSpace,

            // Bookmarked Articles List
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                itemCount: vm.bookmarkedArticles.length,

                separatorBuilder: (context, index) =>
                    PAppSize.s12.verticalSpace,
                itemBuilder: (context, index) {
                  final article = vm.bookmarkedArticles[index];
                  return _BookmarkedArticleCard(
                    onTap: () => PHelperFunction.switchScreen(
                      destination: Routes.financialInsightDetailPage,
                      args: article,
                    ),
                    type:
                        (article['type'] as ContentType).name.capitalizeFirst ??
                        '',
                    duration: '${article['duration']} read',
                    title: article['title'] ?? '',
                    description: article['description'] ?? '',
                  );
                },
              ),
            ),

            PAppSize.s20.verticalSpace,

            // Text(
            //   'track_claims_text'.tr,
            //   style: TextStyle(
            //     fontSize: PAppSize.s14,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            PSeeAllWidget(leadingText: 'track_claims_text'.tr, onTap: () {}),

            PAppSize.s12.verticalSpace,

            // Expandable Claim Tracking Tiles
            _ClaimTrackingTile(
              title: 'Medical Claim',
              submitDate: 'Ref: CLM-2025-0001142',
              status: 'Review Ongoing',
              currentStage: 0,
            ),

            PAppSize.s12.verticalSpace,

            _ClaimTrackingTile(
              title: 'Policy Update',
              submitDate: 'Ref: CLM-2025-0001142',
              status: 'Completed',
              currentStage: 3,
            ),

            PAppSize.s12.verticalSpace,

            _ClaimTrackingTile(
              title: 'Document Request',
              submitDate: 'Ref: CLM-2025-0001142',
              status: 'Completed',
              currentStage: 3,
            ),

            PAppSize.s20.verticalSpace,
          ],
        ).all(PAppSize.s20).scrollable(),
      ),
    );
  }
}

class _ClaimTrackingTile extends StatefulWidget {
  const _ClaimTrackingTile({
    required this.title,
    required this.submitDate,
    required this.status,
    required this.currentStage,
  });

  final String title;
  final String submitDate;
  final String status;
  final int
  currentStage; // 0: Request Received, 1: Review Ongoing, 2: Payment Processing, 3: Claim Paid

  @override
  State<_ClaimTrackingTile> createState() => _ClaimTrackingTileState();
}

class _ClaimTrackingTileState extends State<_ClaimTrackingTile> {
  bool _isExpanded = false;

  final List<Map<String, String>> _stages = [
    {'title': 'Request Received', 'subtitle': 'Mar 2, 2026 • 10:30 AM'},
    {
      'title': 'Review Ongoing',
      'subtitle': 'In Progress • Est. 2-3 business days',
    },
    {'title': 'Payment Processing', 'subtitle': 'Mar 6, 2026 • 10:30 AM'},
    {'title': 'Claim Paid', 'subtitle': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? PAppColor.cardDarkColor : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s16),
      ),
      child: Column(
        children: [
          // Header Row
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(PAppSize.s16),
            child: Padding(
              padding: EdgeInsets.all(PAppSize.s16),
              child: Row(
                children: [
                  // Left: Title and Submit Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: PAppSize.s16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        PAppSize.s4.verticalSpace,
                        Text(
                          widget.submitDate,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: PAppSize.s13,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Right: Status with Gradient and Toggle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            PAppColor.primaryGradient.createShader(bounds),
                        child: Text(
                          widget.status,
                          style: TextStyle(
                            fontSize: PAppSize.s13,
                            fontWeight: FontWeight.w600,
                            color: PAppColor.whiteColor,
                          ),
                        ),
                      ),
                      PAppSize.s8.horizontalSpace,
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: isDarkMode
                              ? PAppColor.whiteColor
                              : PAppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildStatusTracker(context, isDarkMode),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTracker(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(
        left: PAppSize.s16,
        right: PAppSize.s16,
        bottom: PAppSize.s16,
      ),
      child: Column(
        children: List.generate(_stages.length, (index) {
          final stage = _stages[index];
          final isCompleted = index <= widget.currentStage;
          final isLast = index == _stages.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Indicator Column
              Column(
                children: [
                  // Check Icon or Circle
                  if (isCompleted)
                    Container(
                      width: PAppSize.s24,
                      height: PAppSize.s24,
                      decoration: const BoxDecoration(
                        color: PAppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: PAppColor.whiteColor,
                        size: PAppSize.s16,
                      ),
                    )
                  else
                    Container(
                      width: PAppSize.s24,
                      height: PAppSize.s24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode
                              ? PAppColor.fillColor2
                              : PAppColor.greyColor,
                          width: 1,
                        ),
                      ),
                    ),

                  // Connecting Line
                  if (!isLast)
                    Container(
                      width: 2,
                      height: PAppSize.s40,
                      color: isCompleted && index < widget.currentStage
                          ? PAppColor.primary
                          : (isDarkMode
                                ? PAppColor.greyColor.withOpacityExt(
                                    PAppSize.s0_3,
                                  )
                                : PAppColor.greyColor.withOpacityExt(
                                    PAppSize.s0_3,
                                  )),
                    ),
                ],
              ),

              PAppSize.s12.horizontalSpace,

              // Stage Details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : PAppSize.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage['title']!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s15,
                          fontWeight: FontWeight.w600,
                          color: isCompleted
                              ? (isDarkMode
                                    ? PAppColor.whiteColor
                                    : PAppColor.blackColor)
                              : PAppColor.greyColor,
                        ),
                      ),
                      PAppSize.s2.verticalSpace,
                      Text(
                        stage['subtitle']!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: PAppSize.s13,
                          fontWeight: isCompleted
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color: isCompleted
                              ? (isDarkMode
                                    ? PAppColor.whiteColor
                                    : PAppColor.blackColor)
                              : PAppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _BookmarkedArticleCard extends StatelessWidget {
  const _BookmarkedArticleCard({
    required this.type,
    required this.duration,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String type;
  final String duration;
  final String title;
  final String description;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.cardDarkColor
            : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type and Duration
          Text(
            '$type • $duration',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w400,
            ),
          ),

          PAppSize.s8.verticalSpace,

          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w600,
            ),
          ),

          PAppSize.s4.verticalSpace,

          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ).paddingAll(PAppSize.s20).onPressed(onTap: onTap),
    );
  }
}
