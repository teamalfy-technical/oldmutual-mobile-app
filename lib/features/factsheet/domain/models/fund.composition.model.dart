class FundCompositionModel {
  int? id;
  String? asset;
  String? percentage;
  String? createdAt;
  String? updatedAt;

  FundCompositionModel({
    this.id,
    this.asset,
    this.percentage,
    this.createdAt,
    this.updatedAt,
  });

  FundCompositionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asset = json['asset'];
    percentage = json['percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['asset'] = asset;
    data['percentage'] = percentage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
