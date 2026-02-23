import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PClaimTrackingList extends StatelessWidget {
  const PClaimTrackingList({
    super.key,
    required this.claims,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  final List<Map<String, dynamic>> claims;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: claims.length,
      separatorBuilder: (context, index) => PAppSize.s12.verticalSpace,
      itemBuilder: (context, index) {
        final claim = claims[index];
        return PClaimTrackingTile(
          title: claim['title'] as String,
          submitDate: claim['submitDate'] as String,
          status: claim['status'] as String,
          currentStage: claim['currentStage'] as int,
        );
      },
    );
  }
}

class PClaimTrackingTile extends StatefulWidget {
  const PClaimTrackingTile({
    super.key,
    required this.title,
    required this.submitDate,
    required this.status,
    required this.currentStage,
  });

  final String title;
  final String submitDate;
  final String status;
  final int currentStage;

  @override
  State<PClaimTrackingTile> createState() => _PClaimTrackingTileState();
}

class _PClaimTrackingTileState extends State<PClaimTrackingTile> {
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
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(PAppSize.s16),
            child: Padding(
              padding: EdgeInsets.all(PAppSize.s16),
              child: Row(
                children: [
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
              Column(
                children: [
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
                  if (!isLast)
                    Container(
                      width: 2,
                      height: PAppSize.s40,
                      color: isCompleted && index < widget.currentStage
                          ? PAppColor.primary
                          : PAppColor.greyColor.withOpacityExt(PAppSize.s0_3),
                    ),
                ],
              ),
              PAppSize.s12.horizontalSpace,
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
