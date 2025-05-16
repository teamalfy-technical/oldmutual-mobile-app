class ContributionSummary {
  double? totalContributions;
  double? totalEmployerContributions;
  double? totalUnits;
  double? currentUnitPrice;
  double? currentValue;
  double? mainCurrentValue;
  double? gainLoss;
  double? totalInterest;
  String? status;
  double? totalRedemption;
  String? lastContributionDate;

  ContributionSummary({
    this.totalContributions,
    this.totalEmployerContributions,
    this.totalUnits,
    this.currentUnitPrice,
    this.currentValue,
    this.mainCurrentValue,
    this.gainLoss,
    this.totalInterest,
    this.status,
    this.totalRedemption,
    this.lastContributionDate,
  });

  ContributionSummary.fromJson(Map<String, dynamic> json) {
    totalContributions = json['total_contributions']?.toDouble();
    totalEmployerContributions = json['total_employer_contributions'];
    totalUnits = json['total_units'];
    currentUnitPrice = json['current_unit_price'];
    currentValue = json['current_value'];
    mainCurrentValue = json['main_current_value'];
    gainLoss = json['gain_loss'];
    totalInterest = json['total_interest'];
    status = json['status'];
    totalRedemption = json['total_redemption']?.toDouble();
    lastContributionDate = json['last_contribution_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_contributions'] = totalContributions;
    data['total_employer_contributions'] = totalEmployerContributions;
    data['total_units'] = totalUnits;
    data['current_unit_price'] = currentUnitPrice;
    data['current_value'] = currentValue;
    data['main_current_value'] = mainCurrentValue;
    data['gain_loss'] = gainLoss;
    data['total_interest'] = totalInterest;
    data['status'] = status;
    data['total_redemption'] = totalRedemption;
    data['last_contribution_date'] = lastContributionDate;
    return data;
  }

  bool get isEmpty =>
      totalContributions == null &&
      totalEmployerContributions == null &&
      totalUnits == null &&
      currentUnitPrice == null &&
      currentValue == null &&
      mainCurrentValue == null &&
      gainLoss == null &&
      totalInterest == null &&
      status == null &&
      totalRedemption == null &&
      lastContributionDate == null;
}
