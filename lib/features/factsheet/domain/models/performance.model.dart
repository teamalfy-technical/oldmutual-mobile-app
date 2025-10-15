class PerformanceModel {
  int? id;
  int? year;
  String? scheme;
  String? performance;
  String? benchmark;
  String? createdAt;
  String? updatedAt;

  PerformanceModel({
    this.id,
    this.year,
    this.scheme,
    this.performance,
    this.benchmark,
    this.createdAt,
    this.updatedAt,
  });

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'] is String ? int.parse(json['year']) : json['year'];
    scheme = json['scheme'];
    performance = json['performance'];
    benchmark = json['benchmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['scheme'] = scheme;
    data['performance'] = performance;
    data['benchmark'] = benchmark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
