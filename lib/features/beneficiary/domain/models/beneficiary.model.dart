import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class Beneficiary extends Equatable {
  int? beneficiaryId;
  String? fullName;
  double? percAlloc;
  String? birthDate;
  String? address;
  String? relationship;
  String? pensionTypeId;
  String? pensionTypeName;
  int? schemeId;
  String? schemeName;
  bool? show;

  Beneficiary({
    this.beneficiaryId,
    this.fullName,
    this.percAlloc,
    this.birthDate,
    this.address,
    this.relationship,
    this.pensionTypeId,
    this.pensionTypeName,
    this.schemeId,
    this.schemeName,
    this.show = false,
  });

  Beneficiary.fromJson(Map<String, dynamic> json) {
    beneficiaryId = json['beneficiary_id'];
    final firstname = json['firstname'];
    final otherName = json['OtherName'] ?? json['othername'];
    final composed = [
      firstname,
      otherName,
    ].whereType<String>().where((s) => s.isNotEmpty).join(' ');
    fullName = json['FullName'] ?? json['name'] ??
        (composed.isNotEmpty ? composed : null);
    final rawPerc = json['perc_alloc'] ??
        json['percentage_allocation'] ??
        json['percentageAllocation'];
    percAlloc = rawPerc is String
        ? double.tryParse(rawPerc)
        : (rawPerc as num?)?.toDouble();
    birthDate = json['birth_date'];
    address = json['address'] ?? json['beneficiaryContact'];
    relationship =
        json['Relationship'] ?? json['relationship'] ?? json['relation'];
    pensionTypeId = json['pension_type_id'];
    pensionTypeName = json['pension_type_name'];
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
  }

  
  @override
  List<Object?> get props => [beneficiaryId, fullName, schemeId];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beneficiary_id'] = beneficiaryId;
    data['FullName'] = fullName;
    data['perc_alloc'] = percAlloc;
    data['birth_date'] = birthDate;
    data['address'] = address;
    data['Relationship'] = relationship;
    data['pension_type_id'] = pensionTypeId;
    data['pension_type_name'] = pensionTypeName;
    data['scheme_id'] = schemeId;
    data['scheme_name'] = schemeName;
    return data;
  }
}
