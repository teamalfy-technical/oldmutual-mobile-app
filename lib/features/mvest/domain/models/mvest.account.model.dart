import 'package:equatable/equatable.dart';

class CreateMVestAccountRequest extends Equatable {
  final String mvestPlan;
  final double monthlyContribution;

  const CreateMVestAccountRequest({
    required this.mvestPlan,
    required this.monthlyContribution,
  });

  @override
  List<Object?> get props => [mvestPlan, monthlyContribution];

  Map<String, dynamic> toJson() {
    return {
      'mvest_plan': mvestPlan,
      'monthly_contribution': monthlyContribution,
    };
  }
}

/// Beneficiary as returned inline in MVest account responses
/// (different shape from the top-level GET /mvest/beneficiaries list).
// ignore: must_be_immutable
class MVestAccountBeneficiary extends Equatable {
  String? firstname;
  String? othername;
  String? beneficiaryContact;
  double? percentageAllocation;
  String? birthDate;
  String? relation;

  MVestAccountBeneficiary({
    this.firstname,
    this.othername,
    this.beneficiaryContact,
    this.percentageAllocation,
    this.birthDate,
    this.relation,
  });

  MVestAccountBeneficiary.fromJson(Map<String, dynamic> json) {
    firstname = _parseString(json['firstname']);
    othername = _parseString(json['othername']);
    beneficiaryContact = _parseString(json['beneficiaryContact']);
    percentageAllocation = _parseDouble(json['percentageAllocation']);
    birthDate = _parseString(json['birth_date']);
    relation = _parseString(json['relation']);
  }

  @override
  List<Object?> get props => [
    firstname,
    othername,
    beneficiaryContact,
    percentageAllocation,
  ];

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'othername': othername,
      'beneficiaryContact': beneficiaryContact,
      'percentageAllocation': percentageAllocation,
      'birth_date': birthDate,
      'relation': relation,
    };
  }

  String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

// ignore: must_be_immutable
class MVestAccount extends Equatable {
  int? id;
  String? mvestPlan;
  String? memberNumber;
  double? monthlyContribution;
  double? yearlyContribution;
  double? lumpSum;
  List<MVestAccountBeneficiary>? beneficiaries;
  String? createdAt;
  String? updatedAt;

  MVestAccount({
    this.id,
    this.mvestPlan,
    this.memberNumber,
    this.monthlyContribution,
    this.yearlyContribution,
    this.lumpSum,
    this.beneficiaries,
    this.createdAt,
    this.updatedAt,
  });

  MVestAccount.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    mvestPlan = _parseString(json['mvest_plan']);
    memberNumber = _parseString(json['member_number']);
    monthlyContribution = _parseDouble(json['monthly_contribution']);
    yearlyContribution = _parseDouble(json['yearly_contribution']);
    lumpSum = _parseDouble(json['lump_sum']);
    final rawBens = json['beneficiaries'];
    beneficiaries = rawBens is List
        ? rawBens
              .map((e) => MVestAccountBeneficiary.fromJson(e))
              .toList()
        : null;
    createdAt = _parseString(json['created_at']);
    updatedAt = _parseString(json['updated_at']);
  }

  @override
  List<Object?> get props => [id, memberNumber, mvestPlan];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mvest_plan': mvestPlan,
      'member_number': memberNumber,
      'monthly_contribution': monthlyContribution,
      'yearly_contribution': yearlyContribution,
      'lump_sum': lumpSum,
      'beneficiaries': beneficiaries?.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
