class BioData {
  String? memberNo;
  String? fullName;
  int? monthlySalary;
  double? monthlyContribution;
  String? tin;
  String? ssnitNumber;
  String? mobileNo;
  String? email;
  String? employerNumber;
  String? employerName;
  String? pensionTypeId;
  String? pensionTypeName;
  int? schemeId;
  String? schemeName;

  BioData({
    this.memberNo,
    this.fullName,
    this.monthlySalary,
    this.monthlyContribution,
    this.tin,
    this.ssnitNumber,
    this.mobileNo,
    this.email,
    this.employerNumber,
    this.employerName,
    this.pensionTypeId,
    this.pensionTypeName,
    this.schemeId,
    this.schemeName,
  });

  BioData.fromJson(Map<String, dynamic> json) {
    memberNo = json['member_no'];
    fullName = json['FullName'];
    monthlySalary = json['monthly_salary'];
    monthlyContribution = json['MonthlyContribution'];
    tin = json['tin'];
    ssnitNumber = json['ssnit_number'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    employerNumber = json['EmployerNumber'];
    employerName = json['EmployerName'];
    pensionTypeId = json['pension_type_id'];
    pensionTypeName = json['pension_type_name'];
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_no'] = memberNo;
    data['FullName'] = fullName;
    data['monthly_salary'] = monthlySalary;
    data['MonthlyContribution'] = monthlyContribution;
    data['tin'] = tin;
    data['ssnit_number'] = ssnitNumber;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['EmployerNumber'] = employerNumber;
    data['EmployerName'] = employerName;
    data['pension_type_id'] = pensionTypeId;
    data['pension_type_name'] = pensionTypeName;
    data['scheme_id'] = schemeId;
    data['scheme_name'] = schemeName;
    return data;
  }
}
