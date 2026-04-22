import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MVestFrequency { monthly, yearly, lumpSum }

enum MVestAgeCategory { teen, adult }

class MVestBeneficiary {
  final String name;
  final String relationship;
  final double percentage;
  final String phone;
  final DateTime? dateOfBirth;

  /// Origin id when selected from an existing beneficiaries pool;
  /// null for beneficiaries added via the "New" form.
  final String? sourceId;

  const MVestBeneficiary({
    required this.name,
    required this.relationship,
    required this.percentage,
    this.phone = '',
    this.dateOfBirth,
    this.sourceId,
  });

  /// Categorises by age: under 18 = Teen, otherwise Adult.
  /// When DOB is unknown, defaults to Adult.
  MVestAgeCategory get ageCategory {
    if (dateOfBirth == null) return MVestAgeCategory.adult;
    final now = DateTime.now();
    var age = now.year - dateOfBirth!.year;
    final hadBirthday =
        now.month > dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day >= dateOfBirth!.day);
    if (!hadBirthday) age -= 1;
    return age < 18 ? MVestAgeCategory.teen : MVestAgeCategory.adult;
  }
}

class ExistingBeneficiaryOption {
  final String id;
  final String name;
  final String relationship;
  final String dob;
  final String phone;

  const ExistingBeneficiaryOption({
    required this.id,
    required this.name,
    required this.relationship,
    required this.dob,
    this.phone = '233275534095',
  });
}

class PMVestVm extends GetxController {
  static PMVestVm get instance => Get.find();

  static const int maxBeneficiaries = 10;

  // Scheme details
  final contributionAmountTEC = TextEditingController();
  final Rx<MVestFrequency?> selectedFrequency = Rx<MVestFrequency?>(
    MVestFrequency.monthly,
  );

  // Beneficiaries list
  final RxList<MVestBeneficiary> beneficiaries = <MVestBeneficiary>[].obs;

  // Add-beneficiary bottom sheet state
  final addBeneficiaryFormKey = GlobalKey<FormState>();
  final firstNameTEC = TextEditingController();
  final lastNameTEC = TextEditingController();
  final dobTEC = TextEditingController();
  final phoneTEC = TextEditingController();
  final allocationTEC = TextEditingController();

  final RxnString selectedRelationship = RxnString();
  final RxnString selectedGender = RxnString();
  final RxnString selectedIdType = RxnString();

  final relationships = const <String>[
    'Spouse',
    'Child',
    'Parent',
    'Sibling',
    'Other',
  ];
  final genders = const <String>['Male', 'Female'];
  final idTypes = const <String>[
    'Ghana Card',
    'Passport',
    "Driver's Licence",
    'Voter ID',
  ];

  // Existing beneficiaries (pool) and per-id allocation map for the sheet
  final RxList<ExistingBeneficiaryOption> existingBeneficiaries =
      <ExistingBeneficiaryOption>[
        const ExistingBeneficiaryOption(
          id: '1',
          name: 'Obiajulu Anayo',
          relationship: 'Spouse',
          dob: '1985-06-15',
          phone: '233275534095',
        ),
        const ExistingBeneficiaryOption(
          id: '2',
          name: 'Kwame Nkrumah',
          relationship: 'Child',
          dob: '2005-03-22',
          phone: '233555534403',
        ),
        const ExistingBeneficiaryOption(
          id: '3',
          name: 'Nana Yaa',
          relationship: 'Spouse',
          dob: '2015-06-15',
          phone: '233245534430',
        ),
        const ExistingBeneficiaryOption(
          id: '4',
          name: 'Kojo Antwi',
          relationship: 'Parent',
          dob: '20012-03-15',
          phone: '233265534435',
        ),
      ].obs;

  final RxMap<String, double> existingAllocations = <String, double>{}.obs;

  // --- Derived state ---
  double get allocatedPercentage =>
      beneficiaries.fold(0.0, (sum, b) => sum + b.percentage);

  bool get canAddMoreBeneficiaries =>
      beneficiaries.length < maxBeneficiaries && allocatedPercentage < 100;

  double get sheetExistingAllocatedPercentage =>
      existingAllocations.values.fold(0.0, (sum, v) => sum + v);

  bool isExistingSelected(String id) => (existingAllocations[id] ?? 0) > 0;

  /// Returns true if the list already contains a beneficiary matching the
  /// given identity. Matches by `sourceId` when both sides have one, else by
  /// phone (when non-empty on both), else by case/space-insensitive name.
  bool _hasDuplicate({String? sourceId, String phone = '', String name = ''}) {
    final normalisedName = name.trim().toLowerCase();
    final normalisedPhone = phone.trim();
    return beneficiaries.any((b) {
      if (sourceId != null && b.sourceId != null) {
        return b.sourceId == sourceId;
      }
      if (normalisedPhone.isNotEmpty && b.phone.isNotEmpty) {
        return b.phone == normalisedPhone;
      }
      return b.name.trim().toLowerCase() == normalisedName;
    });
  }

  /// True when the given existing-pool id is already on the beneficiaries list.
  bool isExistingAlreadyAdded(String id) =>
      beneficiaries.any((b) => b.sourceId == id);

  // --- Mutations ---
  void onFrequencyChanged(MVestFrequency? value) {
    selectedFrequency.value = value;
  }

  void addBeneficiary(MVestBeneficiary beneficiary) {
    beneficiaries.add(beneficiary);
  }

  void removeBeneficiaryAt(int index) {
    beneficiaries.removeAt(index);
  }

  /// Applies [raw] as this beneficiary's allocation, clamped so the total
  /// across all selected existing beneficiaries never exceeds 100%.
  /// Returns the value actually stored (0 if cleared).
  double setExistingAllocation(String id, String raw) {
    final parsed = double.tryParse(raw.trim()) ?? 0;
    if (parsed <= 0) {
      existingAllocations.remove(id);
      return 0;
    }
    final othersTotal = existingAllocations.entries
        .where((e) => e.key != id)
        .fold(0.0, (sum, e) => sum + e.value);
    final headroom = (100 - othersTotal).clamp(0.0, 100.0);
    final clamped = parsed > headroom ? headroom : parsed;
    if (clamped <= 0) {
      existingAllocations.remove(id);
      return 0;
    }
    existingAllocations[id] = clamped;
    return clamped;
  }

  void resetAddSheet() {
    firstNameTEC.clear();
    lastNameTEC.clear();
    dobTEC.clear();
    phoneTEC.clear();
    allocationTEC.clear();
    selectedRelationship.value = null;
    selectedGender.value = null;
    selectedIdType.value = null;
    existingAllocations.clear();
  }

  /// Returns `null` on success or a translation key describing the failure.
  String? commitNewBeneficiaryFromSheet() {
    final first = firstNameTEC.text.trim();
    final last = lastNameTEC.text.trim();
    final pct = double.tryParse(allocationTEC.text.trim()) ?? 0;
    if (first.isEmpty || pct <= 0) return null;
    final fullName = [first, last].where((s) => s.isNotEmpty).join(' ');
    final phone = phoneTEC.text.trim();
    if (_hasDuplicate(phone: phone, name: fullName)) {
      return 'beneficiary_duplicate_msg';
    }
    DateTime? dob;
    final dobText = dobTEC.text.trim();
    if (dobText.isNotEmpty) {
      final parts = dobText.split('-');
      if (parts.length == 3) {
        final d = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final y = int.tryParse(parts[2]);
        if (d != null && m != null && y != null) {
          dob = DateTime(y, m, d);
        }
      }
    }
    beneficiaries.add(
      MVestBeneficiary(
        name: fullName,
        relationship: selectedRelationship.value ?? '',
        percentage: pct,
        phone: phone,
        dateOfBirth: dob,
      ),
    );
    resetAddSheet();
    return null;
  }

  void commitExistingBeneficiariesFromSheet() {
    for (final entry in existingAllocations.entries) {
      if (entry.value <= 0) continue;
      final option = existingBeneficiaries.firstWhereOrNull(
        (b) => b.id == entry.key,
      );
      if (option == null) continue;
      if (_hasDuplicate(sourceId: option.id)) continue;
      beneficiaries.add(
        MVestBeneficiary(
          name: option.name,
          relationship: option.relationship,
          percentage: entry.value,
          dateOfBirth: DateTime.tryParse(option.dob),
          sourceId: option.id,
        ),
      );
    }
    resetAddSheet();
  }

  @override
  void onClose() {
    contributionAmountTEC.dispose();
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    dobTEC.dispose();
    phoneTEC.dispose();
    allocationTEC.dispose();
    super.onClose();
  }
}
