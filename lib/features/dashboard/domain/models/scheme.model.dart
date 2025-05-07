class Scheme {
  String? memberName;
  String? masterSchemeDescription;
  String? penTypeDescription;
  String? memberNumber;
  int? memberId;
  String? effectiveDate;
  double? monthlyContribution;
  String? ssnitNumber;
  String? employerNumber;
  double? schemeCurrentValue;
  String? employerName;
  String? email;
  String? dob;
  String? dateJoined;
  String? sex;
  String? nationality;

  Scheme({
    this.memberName,
    this.masterSchemeDescription,
    this.penTypeDescription,
    this.memberNumber,
    this.memberId,
    this.effectiveDate,
    this.monthlyContribution,
    this.ssnitNumber,
    this.employerNumber,
    this.schemeCurrentValue,
    this.employerName,
    this.email,
    this.dob,
    this.dateJoined,
    this.sex,
    this.nationality,
  });

  Scheme.fromJson(Map<String, dynamic> json) {
    memberName = json['MemberName'];
    masterSchemeDescription = json['MasterSchemeDescription'];
    penTypeDescription = json['PenTypeDescription'];
    memberNumber = json['MemberNumber'];
    memberId = json['MemberId'];
    effectiveDate = json['EffectiveDate'];
    monthlyContribution = json['MonthlyContribution']?.toDouble();
    ssnitNumber = json['ssnitNumber'];
    employerNumber = json['EmployerNumber'];
    schemeCurrentValue = json['SchemeCurrentValue'];
    employerName = json['EmployerName'];
    email = json['Email'];
    dob = json['Dob'];
    dateJoined = json['Date_joined'];
    sex = json['Sex'];
    nationality = json['Nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberName'] = memberName;
    data['MasterSchemeDescription'] = masterSchemeDescription;
    data['PenTypeDescription'] = penTypeDescription;
    data['MemberNumber'] = memberNumber;
    data['MemberId'] = memberId;
    data['EffectiveDate'] = effectiveDate;
    data['MonthlyContribution'] = monthlyContribution;
    data['ssnitNumber'] = ssnitNumber;
    data['EmployerNumber'] = employerNumber;
    data['SchemeCurrentValue'] = schemeCurrentValue;
    data['EmployerName'] = employerName;
    data['Email'] = email;
    data['Dob'] = dob;
    data['Date_joined'] = dateJoined;
    data['Sex'] = sex;
    data['Nationality'] = nationality;
    return data;
  }
}
