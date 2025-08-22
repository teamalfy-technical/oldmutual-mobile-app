import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PCustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget>? children;
  const PCustomExpansionTile({super.key, required this.title, this.children});

  @override
  State<PCustomExpansionTile> createState() => _PCustomExpansionTileState();
}

class _PCustomExpansionTileState extends State<PCustomExpansionTile> {
  bool expanded = false;

  onExpansionChanged() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: () => onExpansionChanged(),
          label: Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
          ),
          icon: expanded
              ? Assets.icons.keyboardArrowDown.svg()
              : Assets.icons.keyboardArrowRight.svg(),
        ),
        PAppSize.s10.verticalSpace,
        Visibility(
          visible: expanded,
          child: Column(
            children:
                widget.children ??
                [
                  ServiceLinkWidget(
                    label: 'special_investments_plan'.tr,
                    onLinkTap: () {},
                  ),
                  PAppSize.s10.verticalSpace,
                  ServiceLinkWidget(
                    label: 'travel_insurance'.tr,
                    onLinkTap: () {},
                  ),
                  PAppSize.s10.verticalSpace,
                  ServiceLinkWidget(
                    label: 'personal_accident'.tr,
                    onLinkTap: () {},
                  ),
                  PAppSize.s10.verticalSpace,
                  ServiceLinkWidget(label: 'ekyire_asem'.tr, onLinkTap: () {}),
                  PAppSize.s10.verticalSpace,
                  ServiceLinkWidget(
                    label: 'mvest_pensions'.tr,
                    onLinkTap: () {},
                  ),
                  PAppSize.s10.verticalSpace,
                  ServiceLinkWidget(
                    label: 'transitions_plus_plan'.tr,
                    onLinkTap: () {},
                  ),
                ],
          ),
        ),
      ],
    );

    // return Theme(
    //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    //   child: ExpansionTile(
    //     initiallyExpanded: expanded,
    //     onExpansionChanged: (value) {
    //       setState(() {
    //         expanded = value;
    //       });
    //     },
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(PAppSize.s20),
    //     ),
    //     title: Text(
    //       widget.title,
    //       style: Theme.of(context).textTheme.headlineSmall,
    //     ),
    //     trailing: expanded
    //         ? Assets.icons.keyboardArrowDown.svg()
    //         : Assets.icons.keyboardArrowRight.svg(),
    //     childrenPadding: EdgeInsets.symmetric(vertical: PAppSize.s10),
    //     children:
    //         widget.children ??
    //         [
    //           ServiceLinkWidget(
    //             label: 'special_investments_plan'.tr,
    //             onLinkTap: () {},
    //           ),
    //           PAppSize.s10.verticalSpace,
    //           ServiceLinkWidget(label: 'travel_insurance'.tr, onLinkTap: () {}),
    //           PAppSize.s10.verticalSpace,
    //           ServiceLinkWidget(
    //             label: 'personal_accident'.tr,
    //             onLinkTap: () {},
    //           ),
    //           PAppSize.s10.verticalSpace,
    //           ServiceLinkWidget(label: 'ekyire_asem'.tr, onLinkTap: () {}),
    //           PAppSize.s10.verticalSpace,
    //           ServiceLinkWidget(label: 'mvest_pensions'.tr, onLinkTap: () {}),
    //           PAppSize.s10.verticalSpace,
    //           ServiceLinkWidget(
    //             label: 'transitions_plus_plan'.tr,
    //             onLinkTap: () {},
    //           ),
    //         ],
    //   ),
    // );
  }
}
