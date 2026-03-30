class Upsell {
  int? id;
  int? userId;
  String? policyNumber;
  String? currentPremium;
  String? recommendedPremium;
  String? newSumAssured;
  String? confidenceLevel;
  bool? isDismissed;
  String? dismissedAt;
  bool? isActive;
  String? status;
  String? acceptedAt;
  dynamic channel;
  String? createdAt;
  String? updatedAt;

  Upsell({
    this.id,
    this.userId,
    this.policyNumber,
    this.currentPremium,
    this.recommendedPremium,
    this.newSumAssured,
    this.confidenceLevel,
    this.isDismissed,
    this.dismissedAt,
    this.isActive,
    this.status,
    this.acceptedAt,
    this.channel,
    this.createdAt,
    this.updatedAt,
  });

  Upsell.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    policyNumber = json['policy_number'];
    currentPremium = json['current_premium'];
    recommendedPremium = json['recommended_premium'];
    newSumAssured = json['new_sum_assured'];
    confidenceLevel = json['confidence_level'];
    isDismissed = json['is_dismissed'];
    dismissedAt = json['dismissed_at'];
    isActive = json['is_active'];
    status = json['status'];
    acceptedAt = json['accepted_at'];
    channel = json['channel'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['policy_number'] = policyNumber;
    data['current_premium'] = currentPremium;
    data['recommended_premium'] = recommendedPremium;
    data['new_sum_assured'] = newSumAssured;
    data['confidence_level'] = confidenceLevel;
    data['is_dismissed'] = isDismissed;
    data['dismissed_at'] = dismissedAt;
    data['is_active'] = isActive;
    data['status'] = status;
    data['accepted_at'] = acceptedAt;
    data['channel'] = channel;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
