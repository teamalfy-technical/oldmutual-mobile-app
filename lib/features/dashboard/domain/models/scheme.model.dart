class Scheme {
  String? masterSchemeDescription;
  String? penTypeDescription;
  String? memberNumber;
  int? memberId;
  String? effectiveDate;
  double? monthlyContribution;
  String? ssnitNumber;
  String? employerNumber;
  double? schemeCurrentValue;

  Scheme({
    this.masterSchemeDescription,
    this.penTypeDescription,
    this.memberNumber,
    this.memberId,
    this.effectiveDate,
    this.monthlyContribution,
    this.ssnitNumber,
    this.employerNumber,
    this.schemeCurrentValue,
  });

  Scheme.fromJson(Map<String, dynamic> json) {
    masterSchemeDescription = json['MasterSchemeDescription'];
    penTypeDescription = json['PenTypeDescription'];
    memberNumber = json['MemberNumber'];
    memberId = json['MemberId'];
    effectiveDate = json['EffectiveDate'];
    monthlyContribution = json['MonthlyContribution'].toDouble();
    ssnitNumber = json['ssnitNumber'];
    employerNumber = json['EmployerNumber'];
    schemeCurrentValue = json['SchemeCurrentValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MasterSchemeDescription'] = masterSchemeDescription;
    data['PenTypeDescription'] = penTypeDescription;
    data['MemberNumber'] = memberNumber;
    data['MemberId'] = memberId;
    data['EffectiveDate'] = effectiveDate;
    data['MonthlyContribution'] = monthlyContribution;
    data['ssnitNumber'] = ssnitNumber;
    data['EmployerNumber'] = employerNumber;
    data['SchemeCurrentValue'] = schemeCurrentValue;
    return data;
  }
}
