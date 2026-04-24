import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

Future<void> showAddBeneficiarySheet(BuildContext context) {
  final isDark = PHelperFunction.isDarkMode(context);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    backgroundColor: isDark ? PAppColor.darkAppBarColor : PAppColor.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(PAppSize.s24),
        topRight: Radius.circular(PAppSize.s24),
      ),
    ),
    builder: (_) => const _AddBeneficiarySheet(),
  );
}

class _AddBeneficiarySheet extends StatefulWidget {
  const _AddBeneficiarySheet();

  @override
  State<_AddBeneficiarySheet> createState() => _AddBeneficiarySheetState();
}

class _AddBeneficiarySheetState extends State<_AddBeneficiarySheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final PMVestVm ctrl = Get.find<PMVestVm>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          constraints: BoxConstraints(
            maxHeight: PDeviceUtil.getDeviceHeight(context) * 0.90,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s12.verticalSpace,
              Center(
                child: Container(
                  width: PAppSize.s40,
                  height: PAppSize.s4,
                  decoration: BoxDecoration(
                    color: PAppColor.fillColor4,
                    borderRadius: BorderRadius.circular(PAppSize.s4),
                  ),
                ),
              ),
              PAppSize.s12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'add_beneficiary'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: PAppSize.s20,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? PAppColor.whiteColor
                            : PAppColor.text700,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: PAppSize.s18,
                    backgroundColor: isDark
                        ? PAppColor.cardDarkColor
                        : PAppColor.fillColor,
                    child: Assets.icons.closeIcon.svg(
                      height: PAppSize.s16,
                      color: isDark
                          ? PAppColor.fillColor
                          : PAppColor.darkAppBarColor,
                    ),
                  ).onPressed(
                    onTap: PHelperFunction.pop,
                    radius: BorderRadius.circular(PAppSize.s18),
                  ),
                ],
              ),
              PAppSize.s16.verticalSpace,
              SizedBox(
                height: PAppSize.s40,
                child: PCustomTabBarWidget(
                  controller: _tabController,
                  horizontalPadding: PAppSize.s4,
                  verticalPadding: PAppSize.s0,
                  verticalIndicatorPadding: PAppSize.s6,
                  borderRadius: BorderRadius.circular(PAppSize.s8),
                  tabs: [
                    Tab(text: 'new'.tr),
                    Tab(text: 'from_existing'.tr),
                  ],
                ),
              ),
              PAppSize.s16.verticalSpace,
              Expanded(
                child: IndexedStack(
                  index: _tabController.index,
                  children: [
                    _NewBeneficiaryTab(ctrl: ctrl),
                    _ExistingBeneficiariesTab(ctrl: ctrl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewBeneficiaryTab extends StatelessWidget {
  final PMVestVm ctrl;
  const _NewBeneficiaryTab({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Form(
      key: ctrl.addBeneficiaryFormKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: PAppSize.s16),
              child: Column(
                children: [
                  PCustomTextField(
                    labelText: 'first_name'.tr,
                    controller: ctrl.firstNameTEC,
                    validator: PValidator.validateText,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  PAppSize.s16.verticalSpace,
                  PCustomTextField(
                    labelText: 'last_name'.tr,
                    controller: ctrl.lastNameTEC,
                    validator: PValidator.validateText,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  PAppSize.s16.verticalSpace,
                  Obx(
                    () => PCustomDropdownField<String>(
                      labelText: 'relationship'.tr,
                      initialValue: ctrl.selectedRelationship.value,
                      onChanged: (v) => ctrl.selectedRelationship.value = v,
                      items: ctrl.relationships
                          .map(
                            (r) => DropdownMenuItem<String>(
                              value: r,
                              child: Text(r),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  PAppSize.s16.verticalSpace,
                  PCustomTextField(
                    labelText: 'date_of_birth'.tr,
                    controller: ctrl.dobTEC,
                    enabled: false,
                    suffixIcon: Assets.icons.calendarIcon.svg(
                      color: isDark
                          ? PAppColor.whiteColor
                          : PAppColor.darkBgColor,
                      width: PAppSize.s20,
                      height: PAppSize.s20,
                    ),
                  ).onPressed(
                    onTap: () async {
                      final date = await showDatePickerModal(context);
                      if (date != null) {
                        ctrl.dobTEC.text = DateFormat(
                          'dd-MM-yyyy',
                        ).format(date);
                      }
                    },
                  ),
                  PAppSize.s16.verticalSpace,
                  PCustomTextField(
                    labelText: 'phone_number'.tr,
                    controller: ctrl.phoneTEC,
                    textInputType: TextInputType.phone,
                    validator: PValidator.validatePhoneNumber,
                  ),
                  PAppSize.s16.verticalSpace,
                  Obx(
                    () => PCustomDropdownField<String>(
                      labelText: 'gender_optional'.tr,
                      initialValue: ctrl.selectedGender.value,
                      onChanged: (v) => ctrl.selectedGender.value = v,
                      items: ctrl.genders
                          .map(
                            (g) => DropdownMenuItem<String>(
                              value: g,
                              child: Text(g),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  PAppSize.s16.verticalSpace,
                  Obx(
                    () => PCustomDropdownField<String>(
                      labelText: 'id_type_optional'.tr,
                      initialValue: ctrl.selectedIdType.value,
                      onChanged: (v) => ctrl.selectedIdType.value = v,
                      items: ctrl.idTypes
                          .map(
                            (t) => DropdownMenuItem<String>(
                              value: t,
                              child: Text(t),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  PAppSize.s16.verticalSpace,
                  PCustomTextField(
                    labelText: 'allocation_percentage'.tr,
                    controller: ctrl.allocationTEC,
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: PValidator.validatePaymentAmount,
                  ),
                ],
              ),
            ),
          ),
          PAppSize.s8.verticalSpace,
          PGradientButton(
            label: 'save_beneficiary'.tr,
            showIcon: false,
            textColor: PAppColor.whiteColor,
            width: PDeviceUtil.getDeviceWidth(context),
            onTap: () {
              if (ctrl.addBeneficiaryFormKey.currentState?.validate() ??
                  false) {
                final error = ctrl.commitNewBeneficiaryFromSheet();
                if (error != null) {
                  PPopupDialog(context).warningMessage(
                    title: 'beneficiary_duplicate_title'.tr,
                    message: error.tr,
                  );
                  return;
                }
                PHelperFunction.pop();
              }
            },
          ),
          PAppSize.s8.verticalSpace,
        ],
      ),
    );
  }
}

class _ExistingBeneficiariesTab extends StatelessWidget {
  final PMVestVm ctrl;
  const _ExistingBeneficiariesTab({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'select_existing_beneficiaries_hint'.tr,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s13,
              color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
            ),
          ),
        ),
        PAppSize.s12.verticalSpace,
        Obx(
          () => PMVestGradientProgressBar(
            percentage: ctrl.sheetExistingAllocatedPercentage,
          ),
        ),
        PAppSize.s8.verticalSpace,
        Obx(
          () => Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'allocated_of_total'.trParams({
                'value': ctrl.sheetExistingAllocatedPercentage.toStringAsFixed(
                  0,
                ),
              }),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: PAppSize.s13,
                fontWeight: FontWeight.w600,
                color: isDark ? PAppColor.whiteColor : PAppColor.text700,
              ),
            ),
          ),
        ),
        PAppSize.s16.verticalSpace,
        Expanded(
          child: Obx(
            () => ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: ctrl.existingBeneficiaries.length,
              separatorBuilder: (_, _) => PAppSize.s12.verticalSpace,
              itemBuilder: (_, i) {
                final option = ctrl.existingBeneficiaries[i];
                return _ExistingBeneficiaryTile(option: option, ctrl: ctrl);
              },
            ),
          ),
        ),
        PAppSize.s8.verticalSpace,
        PGradientButton(
          label: 'save_beneficiary'.tr,
          showIcon: false,
          textColor: PAppColor.whiteColor,
          width: PDeviceUtil.getDeviceWidth(context),
          onTap: () {
            ctrl.commitExistingBeneficiariesFromSheet();
            PHelperFunction.pop();
          },
        ),
        PAppSize.s8.verticalSpace,
      ],
    );
  }
}

class _ExistingBeneficiaryTile extends StatefulWidget {
  final ExistingBeneficiaryOption option;
  final PMVestVm ctrl;
  const _ExistingBeneficiaryTile({required this.option, required this.ctrl});

  @override
  State<_ExistingBeneficiaryTile> createState() =>
      _ExistingBeneficiaryTileState();
}

class _ExistingBeneficiaryTileState extends State<_ExistingBeneficiaryTile> {
  late final TextEditingController _allocationTEC;

  @override
  void initState() {
    super.initState();
    final inProgress = widget.ctrl.existingAllocations[widget.option.id];
    final committed = widget.ctrl.committedExistingAllocation(widget.option.id);
    final initial = inProgress ?? (committed > 0 ? committed : null);
    _allocationTEC = TextEditingController(
      text: initial != null ? initial.toStringAsFixed(0) : '',
    );
  }

  @override
  void dispose() {
    _allocationTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Obx(() {
      final alreadyAdded = widget.ctrl.isExistingAlreadyAdded(
        widget.option.id,
      );
      final isSelected =
          !alreadyAdded && widget.ctrl.isExistingSelected(widget.option.id);
      final tile = Container(
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s16,
          vertical: PAppSize.s14,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? ( //
                isDark
                    ? PAppColor.primary.withOpacityExt(PAppSize.s0_1)
                    : Color(0XFFF5FFF4))
              : (isDark ? PAppColor.cardDarkColor : PAppColor.whiteColor),
          border: Border.all(
            color: isSelected ? PAppColor.primary : PAppColor.fillColor4,
            width: PAppSize.s1,
          ),
          borderRadius: BorderRadius.circular(PAppSize.s12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.option.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                    ),
                  ),
                  PAppSize.s2.verticalSpace,
                  Text(
                    widget.option.relationship,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s13,
                      color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                    ),
                  ),
                ],
              ),
            ),
            PAppSize.s12.horizontalSpace,
            SizedBox(
              width: PAppSize.s130,
              height: PAppSize.s45,
              child: PCustomTextField(
                labelText: 'allocation_percentage'.tr,
                controller: _allocationTEC,
                // textAlign: TextAlign.center,
                labelFontSize: PAppSize.s12,
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                hintText: 'allocation_percentage'.tr,

                onChanged: (v) {
                  final stored = widget.ctrl.setExistingAllocation(
                    widget.option.id,
                    v,
                  );
                  final expected = stored > 0 ? stored.toStringAsFixed(0) : '';
                  final typed = double.tryParse(v.trim()) ?? 0;
                  if (typed > stored && expected != _allocationTEC.text) {
                    _allocationTEC.value = TextEditingValue(
                      text: expected,
                      selection: TextSelection.collapsed(
                        offset: expected.length,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
      if (alreadyAdded) {
        return Opacity(
          opacity: 0.5,
          child: AbsorbPointer(child: tile),
        );
      }
      return tile;
    });
  }
}
