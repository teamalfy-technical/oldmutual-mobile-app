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
  // double?
  double? schemeCurrentValue;
  String? employerName;
  String? email;
  String? dob;
  String? dateJoined;
  String? sex;
  String? nationality;
  String? status;
  int? fundYear;
  double? balanceBroughtForward;

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
    this.status,
    this.fundYear,
    this.balanceBroughtForward,
  });

  Scheme.fromJson(Map<String, dynamic> json) {
    memberName = _parseString(json['MemberName']);
    masterSchemeDescription = _parseString(json['MasterSchemeDescription']);
    penTypeDescription = _parseString(json['PenTypeDescription']);
    memberNumber = _parseString(json['MemberNumber']);
    memberId = _parseInt(json['MemberId']);
    effectiveDate = _parseString(json['EffectiveDate']);
    monthlyContribution = _parseDouble(json['MonthlyContribution']);
    ssnitNumber = _parseString(json['ssnitNumber']);
    employerNumber = _parseString(json['EmployerNumber']);
    schemeCurrentValue = _parseDouble(json['SchemeCurrentValue']);
    employerName = _parseString(json['EmployerName']);
    email = _parseString(json['Email']);
    dob = _parseString(json['Dob']);
    dateJoined = _parseString(json['DateJoined']);
    sex = _parseString(json['Sex']);
    nationality = _parseString(json['Nationality']);
    status = _parseString(json['Status']);
    fundYear = _parseInt(json['FundYear']);
    balanceBroughtForward = _parseDouble(json['BalanceBroughtForward']);
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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
    data['Status'] = status;
    data['FundYear'] = fundYear;
    data['BalanceBroughtForward'] = balanceBroughtForward;
    return data;
  }
}
