import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:url_launcher/url_launcher.dart';

class PTermsTab extends StatelessWidget {
  const PTermsTab({super.key});

  final String text =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 

Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      body: Container(
        padding: EdgeInsets.all(PAppSize.s16),
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
        ),
        child: ListView.builder(
          itemCount: terms.length,
          itemBuilder: (context, index) {
            final term = terms[index];
            return _buildTermsWidget(
              context: context,
              title: term.title,
              subTitle: term.subTitle,
              fontWeight: term.fontWeight,
              titleColor: term.textColor,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTermsWidget({
    required BuildContext context,
    required String title,
    Color? titleColor,
    FontWeight? fontWeight,
    required String subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: titleColor,
            fontWeight: fontWeight,
          ),
        ),
        PAppSize.s8.verticalSpace,
        Linkify(
          onOpen: (link) async {
            final Uri uri;

            if (link.url.contains('@') && !link.url.startsWith('http')) {
              // Email link
              uri = Uri(scheme: 'mailto', path: link.url);
            } else if (RegExp(r'^\+?[0-9]+$').hasMatch(link.url)) {
              // phone call
              uri = Uri(scheme: 'tel', path: link.url);
            } else {
              // Normal link
              uri = Uri.parse(link.url);
            }

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              pensionAppLogger.e("Could not launch $uri");
            }
          },
          text: subTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          linkStyle: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.none,
          ),
        ),
        // Text(
        //   subTitle,
        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        // ),
      ],
    ).bottom(PAppSize.s20);
  }
}
