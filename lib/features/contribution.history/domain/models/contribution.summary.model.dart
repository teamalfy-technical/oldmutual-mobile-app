class ContributionSummary {
  double? totalContributions;
  double? totalEmployerContributions;
  double? totalUnits;
  double? currentUnitPrice;
  double? currentValue;
  double? gainLoss;
  double? totalInterest;
  String? status;
  String? lastContributionDate;

  ContributionSummary({
    this.totalContributions,
    this.totalEmployerContributions,
    this.totalUnits,
    this.currentUnitPrice,
    this.currentValue,
    this.gainLoss,
    this.totalInterest,
    this.status,
    this.lastContributionDate,
  });

  ContributionSummary.fromJson(Map<String, dynamic> json) {
    totalContributions = json['total_contributions'];
    totalEmployerContributions =
        json['total_employer_contributions'].toDouble();
    totalUnits = json['total_units'];
    currentUnitPrice = json['current_unit_price'];
    currentValue = json['current_value'];
    gainLoss = json['gain_loss'];
    totalInterest = json['total_interest'];
    status = json['status'];
    lastContributionDate = json['last_contribution_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_contributions'] = totalContributions;
    data['total_employer_contributions'] = totalEmployerContributions;
    data['total_units'] = totalUnits;
    data['current_unit_price'] = currentUnitPrice;
    data['current_value'] = currentValue;
    data['gain_loss'] = gainLoss;
    data['total_interest'] = totalInterest;
    data['status'] = status;
    data['last_contribution_date'] = lastContributionDate;
    return data;
  }
}
