import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/shared/widgets/popup.dialog.dart';

enum MVestFrequency { monthly, yearly, lumpSum }

enum MVestAgeCategory { teen, adult }

enum MVestPaymentMethod { mobileMoney }

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
  final double? percentageAllocation;

  const ExistingBeneficiaryOption({
    required this.id,
    required this.name,
    required this.relationship,
    required this.dob,
    this.phone = '',
    this.percentageAllocation,
  });

  factory ExistingBeneficiaryOption.fromBeneficiary(Beneficiary b) {
    return ExistingBeneficiaryOption(
      id: b.beneficiaryId?.toString() ?? '',
      name: b.fullName ?? '',
      relationship: b.relationship ?? '',
      dob: b.birthDate ?? '',
      phone: b.address ?? '',
      percentageAllocation: b.percAlloc,
    );
  }
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

  /// Index in [beneficiaries] of the entry currently being edited via the
  /// sheet, or null when the sheet is in "add" mode.
  final Rxn<int> editingIndex = Rxn<int>();

  bool get isEditingBeneficiary => editingIndex.value != null;

  final RxnString selectedRelationship = RxnString();

  final relationships = const <String>[
    'Spouse',
    'Child',
    'Parent',
    'Brother',
    'Sister',
    'Other',
  ];

  /// Existing-beneficiaries pool surfaced in the "From existing" tab. Derived
  /// from [apiBeneficiaries] so the sheet always reflects the latest server
  /// state. Entries without a usable id or name are dropped because the tile
  /// keys allocations by id.
  List<ExistingBeneficiaryOption> get existingBeneficiaries => apiBeneficiaries
      .where((b) => b.beneficiaryId != null && (b.fullName ?? '').isNotEmpty)
      .map(ExistingBeneficiaryOption.fromBeneficiary)
      .toList();

  final RxMap<String, double> existingAllocations = <String, double>{}.obs;

  // Review page state
  final RxBool declarationAccepted = false.obs;

  // Payment page state
  final Rx<MVestPaymentMethod?> selectedPaymentMethod = Rx<MVestPaymentMethod?>(
    MVestPaymentMethod.mobileMoney,
  );

  // Mobile money page state
  final momoNumberTEC = TextEditingController();

  // --- API state ---
  /// Loading state for fetching the persisted beneficiaries list.
  final loading = LoadingState.completed.obs;

  /// Loading state for create / add / update / delete / payment requests.
  final submitting = LoadingState.completed.obs;

  /// Beneficiaries fetched from GET /mvest/beneficiaries.
  final RxList<Beneficiary> apiBeneficiaries = <Beneficiary>[].obs;

  /// Account-shaped state (returned by create / add / delete / update).
  /// Doubles as the "account already created" guard for [submitInvestment]
  /// retries.
  final Rxn<MVestAccount> mvestAccount = Rxn<MVestAccount>();

  /// Indices into [beneficiaries] that have already been successfully
  /// registered against the MVest account on the server. Used so retrying
  /// [submitInvestment] after a partial failure doesn't re-add entries.
  final RxSet<int> submittedBeneficiaryIndices = <int>{}.obs;

  /// Checkout response returned by the initiate payment endpoint.
  final Rxn<InitiatePaymentResponse> paymentResponse =
      Rxn<InitiatePaymentResponse>();

  /// Currency for MVest payments. Nullable per the API contract.
  String? currency = 'GHS';

  BuildContext get _context => Get.context!;

  // --- Derived state ---
  double get allocatedPercentage =>
      beneficiaries.fold(0.0, (sum, b) => sum + b.percentage);

  bool get canAddMoreBeneficiaries =>
      beneficiaries.length < maxBeneficiaries && allocatedPercentage < 100;

  /// Total allocation attributed to existing-pool beneficiaries: the sum of
  /// in-progress selections in the sheet plus allocations for pool items that
  /// are already committed to the beneficiaries list. Keeps the sheet's
  /// progress indicator consistent after saving and re-opening.
  double get sheetExistingAllocatedPercentage {
    final committed = beneficiaries
        .where((b) => b.sourceId != null)
        .where((b) => !existingAllocations.containsKey(b.sourceId))
        .fold(0.0, (sum, b) => sum + b.percentage);
    final inProgress = existingAllocations.values.fold(
      0.0,
      (sum, v) => sum + v,
    );
    return committed + inProgress;
  }

  bool isExistingSelected(String id) => (existingAllocations[id] ?? 0) > 0;

  /// Committed allocation for an existing-pool id, if it's already on the
  /// beneficiaries list.
  double committedExistingAllocation(String id) =>
      beneficiaries.firstWhereOrNull((b) => b.sourceId == id)?.percentage ?? 0;

  /// Returns true if the list already contains a beneficiary matching the
  /// given identity. Matches by `sourceId` when both sides have one, else by
  /// phone (when non-empty on both), else by case/space-insensitive name.
  /// [ignoreIndex] lets the edit flow skip the entry currently being edited
  /// so it doesn't collide with itself.
  bool _hasDuplicate({
    String? sourceId,
    String phone = '',
    String name = '',
    int? ignoreIndex,
  }) {
    final normalisedName = name.trim().toLowerCase();
    final normalisedPhone = phone.trim();
    for (var i = 0; i < beneficiaries.length; i++) {
      if (i == ignoreIndex) continue;
      final b = beneficiaries[i];
      if (sourceId != null && b.sourceId != null) {
        if (b.sourceId == sourceId) return true;
        continue;
      }
      if (normalisedPhone.isNotEmpty && b.phone.isNotEmpty) {
        if (b.phone == normalisedPhone) return true;
        continue;
      }
      if (b.name.trim().toLowerCase() == normalisedName) return true;
    }
    return false;
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
    final othersInProgress = existingAllocations.entries
        .where((e) => e.key != id)
        .fold(0.0, (sum, e) => sum + e.value);
    final committedTotal = beneficiaries
        .where((b) => b.sourceId != null && b.sourceId != id)
        .where((b) => !existingAllocations.containsKey(b.sourceId))
        .fold(0.0, (sum, b) => sum + b.percentage);
    final headroom = (100 - othersInProgress - committedTotal).clamp(
      0.0,
      100.0,
    );
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
    existingAllocations.clear();
    editingIndex.value = null;
  }

  /// Loads [beneficiaries][index] into the sheet's form fields and flips the
  /// sheet into edit mode. Splits the stored full name back into first/other
  /// names on the first whitespace boundary.
  void beginEditingBeneficiary(int index) {
    if (index < 0 || index >= beneficiaries.length) return;
    final b = beneficiaries[index];
    final parts = b.name.trim().split(RegExp(r'\s+'));
    firstNameTEC.text = parts.isNotEmpty ? parts.first : '';
    lastNameTEC.text = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    phoneTEC.text = b.phone;
    allocationTEC.text = b.percentage.toStringAsFixed(0);
    dobTEC.text = b.dateOfBirth != null
        ? DateFormat('dd-MM-yyyy').format(b.dateOfBirth!)
        : '';
    // Only adopt the stored relationship if it's one of the dropdown's
    // options — otherwise the dropdown asserts on a value with no matching
    // item. Leaving it null nudges the user to pick a supported value.
    selectedRelationship.value = relationships.contains(b.relationship)
        ? b.relationship
        : null;
    existingAllocations.clear();
    editingIndex.value = index;
  }

  /// Discards in-flight edit state without touching the underlying list.
  void cancelEditingBeneficiary() {
    if (!isEditingBeneficiary) return;
    resetAddSheet();
  }

  /// Clears all state accumulated through the MVest onboarding flow so a
  /// user returning to the feature starts from a clean slate.
  void resetInvestmentFlow() {
    contributionAmountTEC.clear();
    momoNumberTEC.clear();
    selectedFrequency.value = MVestFrequency.monthly;
    beneficiaries.clear();
    declarationAccepted.value = false;
    selectedPaymentMethod.value = MVestPaymentMethod.mobileMoney;
    mvestAccount.value = null;
    paymentResponse.value = null;
    submittedBeneficiaryIndices.clear();
    resetAddSheet();
  }

  DateTime? _parseDobInput(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return null;
    final parts = text.split('-');
    if (parts.length != 3) return null;
    final d = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final y = int.tryParse(parts[2]);
    if (d == null || m == null || y == null) return null;
    return DateTime(y, m, d);
  }

  /// Commits the sheet's form. In add mode appends a new entry; in edit mode
  /// replaces the entry at [editingIndex] preserving its `sourceId`.
  /// Returns `null` on success or a translation key describing the failure.
  String? commitNewBeneficiaryFromSheet() {
    final first = firstNameTEC.text.trim();
    final last = lastNameTEC.text.trim();
    final pct = double.tryParse(allocationTEC.text.trim()) ?? 0;
    if (first.isEmpty || pct <= 0) return null;
    final fullName = [first, last].where((s) => s.isNotEmpty).join(' ');
    final phone = phoneTEC.text.trim();
    final editIdx = editingIndex.value;
    if (_hasDuplicate(phone: phone, name: fullName, ignoreIndex: editIdx)) {
      return 'beneficiary_duplicate_msg';
    }
    // Cap total allocation at 100%. In edit mode subtract the entry's
    // existing percentage so re-saving an unchanged value doesn't trip.
    final currentTotal = allocatedPercentage;
    final replacing =
        (editIdx != null && editIdx >= 0 && editIdx < beneficiaries.length)
        ? beneficiaries[editIdx].percentage
        : 0.0;
    if (currentTotal - replacing + pct > 100) {
      return 'beneficiary_allocation_exceeds_msg';
    }
    final dob = _parseDobInput(dobTEC.text);
    final relationship = selectedRelationship.value ?? '';
    if (relationship.isEmpty) {
      return 'beneficiary_relationship_required_msg';
    }
    if (editIdx != null && editIdx >= 0 && editIdx < beneficiaries.length) {
      final original = beneficiaries[editIdx];
      beneficiaries[editIdx] = MVestBeneficiary(
        name: fullName,
        relationship: relationship,
        percentage: pct,
        phone: phone,
        dateOfBirth: dob,
        sourceId: original.sourceId,
      );
    } else {
      beneficiaries.add(
        MVestBeneficiary(
          name: fullName,
          relationship: relationship,
          percentage: pct,
          phone: phone,
          dateOfBirth: dob,
        ),
      );
    }
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

  // --- API calls ---

  String _planFromFrequency(MVestFrequency? freq) {
    switch (freq) {
      case MVestFrequency.monthly:
        return 'Monthly';
      case MVestFrequency.yearly:
        return 'Yearly';
      case MVestFrequency.lumpSum:
        return 'Lump Sum';
      case null:
        return '';
    }
  }

  String _formatBirthDate(DateTime? dob) {
    if (dob == null) return '';
    return DateFormat('yyyy-MM-dd').format(dob);
  }

  /// Inner: POST /mvest-account/create. No [submitting] mutation, no dialog.
  /// The public-facing variants/orchestrators own loading state and error
  /// surfacing so a long submit flow doesn't flicker the UI between calls.
  Future<bool> _createMVestAccountInner() async {
    final result = await mvestService.createMVestAccount(
      mvestPlan: _planFromFrequency(selectedFrequency.value),
      monthlyContribution:
          double.tryParse(contributionAmountTEC.text.trim()) ?? 0,
    );
    return result.fold(
      (err) {
        PPopupDialog(
          _context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        return false;
      },
      (res) {
        mvestAccount.value = res.data;
        pensionAppLogger.i('MVest account created: ${res.data?.toJson()}');
        return true;
      },
    );
  }

  /// POST /mvest-account/create
  Future<bool> createMVestAccount() async {
    submitting.value = LoadingState.loading;
    final ok = await _createMVestAccountInner();
    submitting.value = ok ? LoadingState.completed : LoadingState.error;
    return ok;
  }

  /// Inner: POST /mvest/add-beneficiary. See [_createMVestAccountInner].
  Future<bool> _addBeneficiaryRemoteInner(MVestBeneficiary b) async {
    final parts = b.name.trim().split(RegExp(r'\s+'));
    final firstname = parts.isNotEmpty ? parts.first : '';
    final othername = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    final result = await mvestService.addMVestBeneficiary(
      firstname: firstname,
      othername: othername,
      beneficiaryContact: b.phone.isEmpty ? '0577551020' : b.phone,
      percentageAllocation: b.percentage,
      birthDate: _formatBirthDate(b.dateOfBirth),
      relation: b.relationship,
    );
    return result.fold(
      (err) {
        PPopupDialog(
          _context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        return false;
      },
      (res) {
        mvestAccount.value = res.data;
        return true;
      },
    );
  }

  /// POST /mvest/add-beneficiary
  Future<bool> addBeneficiaryRemote(MVestBeneficiary b) async {
    submitting.value = LoadingState.loading;
    final ok = await _addBeneficiaryRemoteInner(b);
    submitting.value = ok ? LoadingState.completed : LoadingState.error;
    return ok;
  }

  /// DEL /mvest/delete-beneficiary/{beneficiaryContact}
  Future<bool> deleteBeneficiaryRemote(String beneficiaryContact) async {
    submitting.value = LoadingState.loading;
    final result = await mvestService.deleteMVestBeneficiary(
      beneficiaryContact: beneficiaryContact,
    );
    return result.fold(
      (err) {
        submitting.value = LoadingState.error;
        PPopupDialog(
          _context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        return false;
      },
      (res) {
        submitting.value = LoadingState.completed;
        mvestAccount.value = res.data;
        apiBeneficiaries.removeWhere((b) => b.address == beneficiaryContact);
        return true;
      },
    );
  }

  /// GET /mvest/beneficiaries
  Future<void> getBeneficiariesRemote() async {
    loading.value = LoadingState.loading;
    final result = await mvestService.getMVestBeneficiaries();
    result.fold(
      (err) {
        loading.value = LoadingState.error;
        // PPopupDialog(
        //   _context,
        // ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) {
        loading.value = LoadingState.completed;
        apiBeneficiaries.value = res.data ?? [];
      },
    );
  }

  /// POST /mvest/update-beneficiary/{id}
  Future<bool> updateBeneficiaryRemote({
    required int id,
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  }) async {
    submitting.value = LoadingState.loading;
    final result = await mvestService.updateMVestBeneficiary(
      id: id,
      firstname: firstname,
      othername: othername,
      beneficiaryContact: beneficiaryContact,
      percentageAllocation: percentageAllocation,
      birthDate: birthDate,
      relation: relation,
    );
    return result.fold(
      (err) {
        submitting.value = LoadingState.error;
        PPopupDialog(
          _context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        return false;
      },
      (res) {
        submitting.value = LoadingState.completed;
        mvestAccount.value = res.data;
        return true;
      },
    );
  }

  /// Run the full account-creation flow: create the MVest account (only if
  /// not already created), then register every collected beneficiary that
  /// hasn't already been registered on a previous attempt. Stops at the
  /// first failure so we never leave a partially-populated account on the
  /// backend, and tracks per-beneficiary progress so a retry resumes
  /// instead of double-posting.
  ///
  /// NOTE: beneficiaries selected from the existing pool (those with a
  /// `sourceId`) are still POSTed via /mvest/add-beneficiary so the backend
  /// links them to the new MVest scheme. If the API rejects duplicates by
  /// phone, this will surface as a per-beneficiary error and the loop will
  /// halt; the next retry resumes from the first not-yet-submitted index.
  Future<bool> submitInvestment() async {
    submitting.value = LoadingState.loading;
    if (mvestAccount.value == null) {
      final accountOk = await _createMVestAccountInner();
      if (!accountOk) {
        submitting.value = LoadingState.error;
        return false;
      }
    }
    for (var i = 0; i < beneficiaries.length; i++) {
      if (submittedBeneficiaryIndices.contains(i)) continue;
      final ok = await _addBeneficiaryRemoteInner(beneficiaries[i]);
      if (!ok) {
        submitting.value = LoadingState.error;
        return false;
      }
      submittedBeneficiaryIndices.add(i);
    }
    submitting.value = LoadingState.completed;
    return true;
  }

  /// Orchestrates the full mobile-money submit: account create + beneficiary
  /// registration + payment initiation, all under a single [submitting]
  /// loading window so the button doesn't flicker between steps. Idempotent
  /// across retries: skips work that has already succeeded.
  Future<bool> submitAndInitiatePayment() async {
    submitting.value = LoadingState.loading;
    if (mvestAccount.value == null) {
      final accountOk = await _createMVestAccountInner();
      if (!accountOk) {
        submitting.value = LoadingState.error;
        return false;
      }
    }
    for (var i = 0; i < beneficiaries.length; i++) {
      if (submittedBeneficiaryIndices.contains(i)) continue;
      final ok = await _addBeneficiaryRemoteInner(beneficiaries[i]);
      if (!ok) {
        submitting.value = LoadingState.error;
        return false;
      }
      submittedBeneficiaryIndices.add(i);
    }
    final paymentOk = await _initiateMVestPaymentInner();
    submitting.value = paymentOk ? LoadingState.completed : LoadingState.error;
    return paymentOk;
  }

  /// Inner: POST /mvest/payment/initiate. See [_createMVestAccountInner].
  Future<bool> _initiateMVestPaymentInner() async {
    final amount = double.tryParse(contributionAmountTEC.text.trim()) ?? 0;
    final result = await mvestService.initiateMVestPayment(
      amount: amount,
      currency: currency,
    );
    return result.fold(
      (err) {
        PPopupDialog(
          _context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
        return false;
      },
      (res) {
        paymentResponse.value = res.data;
        pensionAppLogger.i('MVest payment initiated: ${res.data?.toJson()}');
        return true;
      },
    );
  }

  /// POST /mvest/payment/initiate
  Future<bool> initiateMVestPayment() async {
    submitting.value = LoadingState.loading;
    final ok = await _initiateMVestPaymentInner();
    submitting.value = ok ? LoadingState.completed : LoadingState.error;
    return ok;
  }

  @override
  void onClose() {
    contributionAmountTEC.dispose();
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    dobTEC.dispose();
    phoneTEC.dispose();
    allocationTEC.dispose();
    momoNumberTEC.dispose();
    super.onClose();
  }
}
