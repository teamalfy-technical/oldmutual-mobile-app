import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/widgets/beneficiary.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryPage extends StatefulWidget {
  const PBeneficiaryPage({super.key});

  @override
  State<PBeneficiaryPage> createState() => _PBeneficiaryPageState();
}

class _PBeneficiaryPageState extends State<PBeneficiaryPage> {
  final List<Map<String, dynamic>> beneficiaries = [
    {
      'name': 'John White',
      'dob': '10-05-2003',
      'percentage': '20%',
      'relation': 'son',
      'show': true,
    },
    {
      'name': 'Mary White',
      'dob': '10-05-1998',
      'percentage': '30%',
      'relation': 'son',
      'show': false,
    },
    {
      'name': 'Angela White',
      'dob': '22-04-2000',
      'percentage': '30%',
      'relation': 'son',
      'show': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('beneficiaries'.tr)),
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'beneficiaries_tag'.tr,
            icon: Assets.icons.warningGreenIcon.svg(),
            textAlign: TextAlign.center,
          ),
          // PAppSize.s32.verticalSpace,
          (PDeviceUtil.getDeviceHeight(context) * 0.045).verticalSpace,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: beneficiaries.length,
              itemBuilder: (context, index) {
                final beneficiary = beneficiaries[index];
                return PBeneficiaryWidget(
                  beneficiary: beneficiary,
                  index: index,
                  onExpansionChanged: (value) {
                    setState(() {
                      beneficiary['show'] = value;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
