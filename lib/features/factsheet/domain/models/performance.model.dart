class PerformanceModel {
  int? id;
  int? year;
  String? anchor;
  String? benchmark;
  String? createdAt;
  String? updatedAt;

  PerformanceModel({
    this.id,
    this.year,
    this.anchor,
    this.benchmark,
    this.createdAt,
    this.updatedAt,
  });

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    anchor = json['anchor'];
    benchmark = json['benchmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['anchor'] = anchor;
    data['benchmark'] = benchmark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
