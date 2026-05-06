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
  final ctrl = Get.find<PMVestVm>();
  final wasEditing = ctrl.isEditingBeneficiary;
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
  ).whenComplete(() {
    // Drop in-flight edit state if the sheet was dismissed without saving.
    if (wasEditing && ctrl.isEditingBeneficiary) {
      ctrl.cancelEditingBeneficiary();
    }
  });
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
    if (ctrl.apiBeneficiaries.isEmpty &&
        ctrl.loading.value != LoadingState.loading) {
      ctrl.getBeneficiariesRemote();
    }
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
    final isEditing = ctrl.isEditingBeneficiary;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          constraints: BoxConstraints(
            maxHeight: PDeviceUtil.getDeviceHeight(context) * 0.85,
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
                      isEditing ? 'edit_beneficiary'.tr : 'add_beneficiary'.tr,
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
              if (!isEditing) ...[
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
              ],
              Expanded(
                child: isEditing
                    ? _NewBeneficiaryTab(ctrl: ctrl)
                    : IndexedStack(
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
                    validator: PValidator.validateDate,
                    suffixIcon: Assets.icons.calendarIcon.svg(
                      color: isDark
                          ? PAppColor.whiteColor
                          : PAppColor.darkBgColor,
                      width: PAppSize.s20,
                      height: PAppSize.s20,
                    ),
                  ).onPressed(
                    onTap: () async {
                      final date = await showDatePickerModal(
                        context,
                        maximumDate: DateTime.now(),
                      );
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
            label: ctrl.isEditingBeneficiary
                ? 'save_changes'.tr
                : 'save_beneficiary'.tr,
            showIcon: false,
            textColor: PAppColor.whiteColor,
            width: PDeviceUtil.getDeviceWidth(context),
            onTap: () {
              if (ctrl.addBeneficiaryFormKey.currentState?.validate() ??
                  false) {
                final error = ctrl.commitNewBeneficiaryFromSheet();
                if (error != null) {
                  final title = switch (error) {
                    'beneficiary_allocation_exceeds_msg' =>
                      'beneficiary_allocation_exceeds_title'.tr,
                    'beneficiary_relationship_required_msg' =>
                      'beneficiary_relationship_required_title'.tr,
                    _ => 'beneficiary_duplicate_title'.tr,
                  };
                  PPopupDialog(
                    context,
                  ).warningMessage(title: title, message: error.tr);
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
          child: Obx(() {
            final isLoading =
                ctrl.loading.value == LoadingState.loading &&
                ctrl.apiBeneficiaries.isEmpty;
            final options = ctrl.existingBeneficiaries;
            if (!isLoading && options.isEmpty) {
              return PEmptyStateWidget(message: 'no_existing_beneficiaries'.tr);
            }
            return PShimmerListView<ExistingBeneficiaryOption>(
              loading: isLoading,
              items: options,
              padding: EdgeInsets.zero,
              placeholderCount: 4,
              placeholderItem: const ExistingBeneficiaryOption(
                id: '__placeholder__',
                name: 'Beneficiary name',
                relationship: 'Relationship',
                dob: '',
                phone: '',
              ),
              separatorBuilder: (_, _) => PAppSize.s12.verticalSpace,
              itemBuilder: (_, i, option) => _ExistingBeneficiaryTile(
                key: isLoading ? ValueKey('shimmer-$i') : ValueKey(option.id),
                option: option,
                ctrl: ctrl,
              ),
            );
          }),
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
  const _ExistingBeneficiaryTile({
    super.key,
    required this.option,
    required this.ctrl,
  });

  @override
  State<_ExistingBeneficiaryTile> createState() =>
      _ExistingBeneficiaryTileState();
}

class _ExistingBeneficiaryTileState extends State<_ExistingBeneficiaryTile> {
  late final TextEditingController _allocationTEC;

  @override
  void initState() {
    super.initState();
    // Allocation is sourced from the backend's `percAlloc` and is read-only;
    // ignore any in-progress / committed sheet state for the displayed value.
    final backend = widget.option.percentageAllocation ?? 0;
    _allocationTEC = TextEditingController(
      text: backend > 0 ? backend.toStringAsFixed(0) : '',
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
      final alreadyAdded = widget.ctrl.isExistingAlreadyAdded(widget.option.id);
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
                enabled: false,
                labelFontSize: PAppSize.s12,
                hintText: 'allocation_percentage'.tr,
              ),
            ),
          ],
        ),
      );
      if (alreadyAdded) {
        return Opacity(opacity: 0.5, child: AbsorbPointer(child: tile));
      }
      // Allocation field is read-only, so tile body drives selection.
      // Tapping toggles the backend's `percAlloc` into the in-progress map;
      // an already-selected tile is cleared on tap.
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isSelected) {
            widget.ctrl.setExistingAllocation(widget.option.id, '');
            return;
          }
          final allocation = widget.option.percentageAllocation ?? 0;
          if (allocation <= 0) return;
          widget.ctrl.setExistingAllocation(
            widget.option.id,
            allocation.toString(),
          );
        },
        child: tile,
      );
    });
  }
}
