import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class TermsModel {
  final String title;
  final String subTitle;
  Color? textColor;
  FontWeight? fontWeight;

  TermsModel({
    required this.title,
    required this.subTitle,
    this.textColor,
    this.fontWeight,
  });
}

List<TermsModel> terms = [
  TermsModel(
    title:
        'PLEASE READ THIS TERMS OF SERVICE CAREFULLY. IT IS A BINDING CONTRACT.',
    subTitle:
        'The My Old Mutual Ghana App (the “App”), provided by Old Mutual Ghana (“we,” “us,” or “our”) is a digital channel provided to support both customers and non-customers of Old Mutual Life Assurance Company Ghana Limited and Old Mutual Pensions Trust. By downloading, installing, or using this App, you agree to be bound by these Terms and Conditions. If you do not agree, please do not use the App.',
    fontWeight: FontWeight.w500,
  ),
  TermsModel(
    title: '1. Eligibility',
    subTitle:
        'You must be 18 years or older and legally permitted to enter into a contract in Ghana to use this App. By using the App, you represent and warrant that you meet this requirement.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),

  TermsModel(
    title: '2. Use of the App',
    subTitle:
        'You agree to use the App only for lawful purposes and in accordance with these Terms. You are responsible for maintaining the confidentiality of your login credentials and for all activities that occur under your account.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),

  TermsModel(
    title: '3. Features and Services',
    subTitle: '''
The App allows users to:
- View their life insurance policy and pensions scheme details
- View their life insurance policy and pensions scheme details, contributions, redemptions, and accrued interest.
- Manage beneficiary and personal information.
- Generate premium, investment and contribution statements and view scheme performance.
- Calculate future pension value projections.
- Make redemption and porting requests.
We reserve the right to modify or discontinue any feature at any time without notice.
''',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '4. Data Privacy and Security',
    subTitle:
        'We are committed to protecting your personal information in accordance with applicable data protection laws. By using the App, you consent to the collection, processing, and storage of your data as outlined in our Privacy Policy accessible through our website at https://www.oldmutual.com.gh/privacy-notice/. We may through the app offer you extended services from Old Mutual and our trusted partners. You will be notified where such services require data to be shared outside of our organization.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '5. Accuracy of Information',
    subTitle:
        'While we strive to ensure all account data and projections are accurate and up-to-date, we do not guarantee the completeness or accuracy of any information presented. Future value projections are estimates and not financial guarantees.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '6. Third-Party Services',
    subTitle:
        'The App may integrate with external systems and APIs. We are not responsible for the content, functionality, or availability of such third-party services.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '7. Intellectual Property',
    subTitle:
        'All content and technology used in this App, including logos, trademarks, and software, are the property of Old Mutual Ghana or its licensors. You may not reproduce, distribute, or modify any part of the App without prior written consent.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '8. Limitation of Liability',
    subTitle:
        'To the extent permitted by law, you agree to indemnify, defend and hold harmless, Old Mutual and its directors, affiliates, and employees from any and all costs, claims, losses, liabilities, damages and expenses (including reasonable attorneys\' fees, costs, and expert witnesses\' fees)  which may be incurred or suffered by Old Mutual as a result of or arising out of your use or inability to use the App, except for where such losses or damages are due to the negligence, willful neglect or fraud of Old Mutual.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),

  TermsModel(
    title: '9. Termination',
    subTitle:
        '''We may terminate and temporarily suspend your access to the APP if you fail to comply with these T&Cs, Guidelines or the law, for any reason outside of our control, or for any reason, and without advance notice. 
    
We may terminate these T&Cs, stop providing you with all or any part of the APP, or impose new or additional limits on your ability to use the APP. And while we try to give you reasonable notice beforehand, we cannot guarantee that notice will be possible in all circumstances.''',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '10. Amendments',
    subTitle:
        'We may update these Terms from time to time. Any changes will be effective once published within the App. Continued use of the App indicates your acceptance of the revised Terms.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '11. Governing Law',
    subTitle:
        'These Terms are governed by the laws of Ghana. Any disputes shall be subject to the exclusive jurisdiction of the courts of Ghana.',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
  TermsModel(
    title: '12. Contact Us',
    subTitle: '''
For questions about these Terms or the App, please contact our support team at:

Email: digitalsupport@oldmutual.gh.com

Phone: 0307000600
''',
    fontWeight: FontWeight.w600,
    textColor: PAppColor.primary,
  ),
];
