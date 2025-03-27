class ContributionYear {
  int? fundYear;
  double? totalContribution;
  int? employeeContribution;

  ContributionYear({
    this.fundYear,
    this.totalContribution,
    this.employeeContribution,
  });

  ContributionYear.fromJson(Map<String, dynamic> json) {
    fundYear = json['fund_year'];
    totalContribution = json['TotalContribution'];
    employeeContribution = json['EmployeeContribution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fund_year'] = fundYear;
    data['TotalContribution'] = totalContribution;
    data['EmployeeContribution'] = employeeContribution;
    return data;
  }
}
