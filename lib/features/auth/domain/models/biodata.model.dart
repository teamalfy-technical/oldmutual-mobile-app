import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class BioData extends Equatable {
  String? memberNo;
  String? fullName;
  String? firstName;
  String? otherNames;
  String? dob;
  String? ghanaCardNumber;
  String? staffNumber;
  String? sex;
  double? monthlySalary;
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
    this.firstName,
    this.otherNames,
    this.dob,
    this.ghanaCardNumber,
    this.staffNumber,
    this.sex,
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
    firstName = json['FirstName'];
    otherNames = json['other_names'];
    dob = json['dob'];
    ghanaCardNumber = json['GIN'];
    staffNumber = json['StaffNumber'];
    sex = json['sex'];

    monthlySalary = json['monthly_salary'].toDouble();
    monthlyContribution = json['MonthlyContribution'].toDouble();
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

  
  @override
  List<Object?> get props => [memberNo, ghanaCardNumber, schemeId];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_no'] = memberNo;
    data['FullName'] = fullName;
    data['FirstName'] = firstName;
    data['other_names'] = otherNames;
    data['dob'] = dob;
    data['GIN'] = ghanaCardNumber;
    data['StaffNumber'] = staffNumber;
    data['Sex'] = sex;
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
