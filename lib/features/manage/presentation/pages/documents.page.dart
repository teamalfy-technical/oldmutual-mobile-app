import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/manage/manage.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDocumentsPage extends StatelessWidget {
  PDocumentsPage({super.key});

  final vm = Get.put(PManageVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('documents'.tr)),
      body: SafeArea(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s8.verticalSpace,
                // Username
                Text(
                  'manage_docs_here'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : Color(0xFF666666),
                  ),
                ),

                PAppSize.s14.verticalSpace,

                // Documents section
                PCustomCardWidget(
                  useBorder: false,
                  padding: EdgeInsets.symmetric(vertical: PAppSize.s8),
                  child: RefreshIndicator.adaptive(
                    onRefresh: vm.fetchDocuments,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Assets.icons.draft.svg(
                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.darkAppBarColor,
                          ),
                          title: Text(
                            'Crossborder letter',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            PFormatter.formatDate(
                              date: DateTime.now().subtract(Duration(days: 3)),
                              dateFormat: DateFormat('dd MMMM yyyy'),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          trailing: Assets.icons.fileDownload.svg(
                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.darkAppBarColor,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 3,
                    ),
                  ),
                ),
              ],
            ).scrollable().symmetric(
              horizontal: PAppSize.s20,
              vertical: PAppSize.s20,
            ),
      ),
    );
  }
}
