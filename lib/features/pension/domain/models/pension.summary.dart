class PensionSummary {
  int? totalPensions;
  double? totalInvestment;

  PensionSummary({this.totalPensions, this.totalInvestment});

  PensionSummary.fromJson(Map<String, dynamic> json) {
    totalPensions = json['total_pensions'];
    totalInvestment = json['total_investment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_pensions'] = totalPensions;
    data['total_investment'] = totalInvestment;

    return data;
  }
}
