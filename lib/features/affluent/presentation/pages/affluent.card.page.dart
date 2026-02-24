import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:gal/gal.dart';
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
  final PageController _pageController = PageController();
  final int _currentPage = 0;
  bool _isSharing = false;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    vm.fetchBookmarkedContents();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _shareCard() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      // Capture the card as an image
      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

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

  Future<void> _downloadCard() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      // Check and request gallery access
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        final granted = await Gal.requestAccess(toAlbum: true);
        if (!granted) {
          if (mounted) {
            PPopupDialog(context).errorMessage(
              title: 'error'.tr,
              message:
                  'Gallery permission is required to save the card. Please enable it in Settings.',
            );
          }
          return;
        }
      }

      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Could not capture card image');
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Could not convert image to bytes');
      }

      // Save to temporary file first
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/affluent_card.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Save to device gallery
      await Gal.putImage(file.path, album: 'Old Mutual');

      if (mounted) {
        PPopupDialog(context).successMessage(
          title: 'success'.tr,
          message: 'download_complete'.tr,
        );
      }
    } catch (e) {
      if (mounted) {
        PPopupDialog(context).errorMessage(
          title: 'error'.tr,
          message: 'error_occurred_msg'.tr,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);
    final user = widget.user;

    final cardCount = 1;

    return Scaffold(
      backgroundColor: isDarkMode ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('my_affluent_card'.tr)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affluent Card PageView
            // SizedBox(
            //   height: 220.h,
            //   child: PageView.builder(
            //     controller: _pageController,
            //     itemCount: cardCount,
            //     onPageChanged: (index) => setState(() => _currentPage = index),
            //     itemBuilder: (context, index) {
            //       return RepaintBoundary(
            //         key: index == 0 ? _cardKey : null,
            //         child: PAffluentMemberCard(
            //           memberName: user?.name ?? '',
            //           cardNumber: user?.ghanaCardNumber ?? 'AFF-2024-00847',
            //           memberSince: 'Jan 2023',
            //           relationshipOfficer: 'Sarah Osei',
            //         ),
            //       ).symmetric(horizontal: PAppSize.s4);
            //     },
            //   ),
            // ),
            RepaintBoundary(
              key: _cardKey,
              child: PAffluentMemberCard(
                memberName: user?.name ?? '',
                cardNumber: user?.ghanaCardNumber ?? 'AFF-2024-00847',
                memberSince: PFormatter.formatDate(
                  dateFormat: DateFormat('MMM yyyy'),
                  date: DateTime.parse(
                    user?.dateJoined ?? DateTime.now().toIso8601String(),
                  ),
                ),
                relationshipOfficer: 'Sarah Osei',
              ),
            ).symmetric(horizontal: PAppSize.s4),

            PAppSize.s20.verticalSpace,

            // Dot Indicator
            if (cardCount >= 2) ...[
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: PAppSize.s14,
                    vertical: PAppSize.s6,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? PAppColor.cardDarkColor
                        : PAppColor.whiteColor,
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      cardCount,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: PAppSize.s4),
                        width: _currentPage == index
                            ? PAppSize.s12
                            : PAppSize.s6,
                        height: _currentPage == index
                            ? PAppSize.s12
                            : PAppSize.s6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: _currentPage == index
                              ? PAppColor.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    PAppColor.greyColor,
                                    PAppColor.greyColor,
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PAppSize.s20.verticalSpace,
            ],

            //  Action Buttons
            Row(
              children: [
                Expanded(
                  child: PGradientButton(
                    label: 'download_card'.tr.toUpperCase(),
                    showIcon: false,
                    textColor: PAppColor.whiteColor,
                    fontSize: PAppSize.s14,
                    loading: _isDownloading
                        ? LoadingState.loading
                        : LoadingState.completed,
                    onTap: _isDownloading ? null : _downloadCard,
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
                              fontSize: PAppSize.s14,
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
                destination: Routes.saveContentPage,
              ),
            ),

            PAppSize.s4.verticalSpace,

            Text(
              'bookmarked_articles'.tr,
              style: TextStyle(
                fontSize: PAppSize.s14,
                fontWeight: FontWeight.w500,
              ),
            ),

            PAppSize.s12.verticalSpace,

            // Bookmarked Articles List
            Obx(() {
              if (vm.contentsLoading.value == LoadingState.loading &&
                  vm.bookmarkedContents.isEmpty) {
                return ShimmerWrapper(
                  child: _BookmarkedArticleCard(
                    type: 'Article',
                    duration: '5 mins read',
                    title: 'Placeholder title here',
                    description:
                        'Placeholder description text goes here for shimmer',
                  ),
                );
              }

              if (vm.bookmarkedContents.isEmpty) {
                return Center(
                  child: Text(
                    'no_saved_content'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: PAppSize.s14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vm.bookmarkedContents.take(1).length,
                separatorBuilder: (context, index) =>
                    PAppSize.s12.verticalSpace,
                itemBuilder: (context, index) {
                  final bookmarked = vm.bookmarkedContents[index];
                  final content = bookmarked.content;
                  return _BookmarkedArticleCard(
                    onTap: () {
                      if (content != null) {
                        PHelperFunction.switchScreen(
                          destination: Routes.financialInsightDetailPage,
                          args: content,
                        );
                      }
                    },
                    type: content?.contentType?.capitalizeFirst ?? '',
                    duration:
                        '${content?.duration ?? 'default_duration'.tr} read',
                    title: content?.title ?? '',
                    description: content?.description ?? '',
                  );
                },
              );
            }),

            PAppSize.s20.verticalSpace,

            // Text(
            //   'track_claims_text'.tr,
            //   style: TextStyle(
            //     fontSize: PAppSize.s14,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            PSeeAllWidget(
              leadingText: 'track_claims_text'.tr,
              onTap: () => PHelperFunction.switchScreen(
                destination: Routes.trackClaimsPage,
              ),
            ),

            PAppSize.s12.verticalSpace,

            // Expandable Claim Tracking Tiles
            PClaimTrackingList(
              claims: vm.claims,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),

            PAppSize.s20.verticalSpace,
          ],
        ).all(PAppSize.s20).scrollable(),
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
