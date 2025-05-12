class Contribution {
  String? month;
  double? mainCurrentValue;
  double? monthlyChange;
  String? scheme;
  String? lastUpdated;

  Contribution({
    this.month,
    this.mainCurrentValue,
    this.monthlyChange,
    this.scheme,
    this.lastUpdated,
  });

  Contribution.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    mainCurrentValue = json['main_current_value']?.toDouble();
    monthlyChange = json['monthly_change']?.toDouble();
    scheme = json['scheme'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['main_current_value'] = mainCurrentValue;
    data['monthly_change'] = monthlyChange;
    data['scheme'] = scheme;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
