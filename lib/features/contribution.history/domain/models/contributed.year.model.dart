class ContributedYear {
  int? fundYear;
  double? totalContribution;
  double? employeeContribution;

  ContributedYear({
    this.fundYear,
    this.totalContribution,
    this.employeeContribution,
  });

  ContributedYear.fromJson(Map<String, dynamic> json) {
    fundYear = json['fund_year'];
    totalContribution = json['TotalContribution']?.toDouble();
    employeeContribution = json['EmployeeContribution']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fund_year'] = fundYear;
    data['TotalContribution'] = totalContribution;
    data['EmployeeContribution'] = employeeContribution;
    return data;
  }
}
