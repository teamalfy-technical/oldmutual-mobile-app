class PolicyReport {
  int? id;
  String? type;
  String? status;
  String? filePath;
  Filters? filters;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  PolicyReport({
    this.id,
    this.type,
    this.status,
    this.filePath,
    this.filters,
    this.downloadUrl,
    this.createdAt,
    this.updatedAt,
  });

  PolicyReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    filePath = json['file_path'];
    filters = (json['filters'] != null && json['filters'] is Map)
        ? Filters.fromJson(json['filters'])
        : (json['filters'] != null &&
              json['filters'] is List &&
              json['filters'].isNotEmpty)
        ? Filters.fromJson(json['filters'].first)
        : null;
    downloadUrl = json['download_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['status'] = status;
    data['file_path'] = filePath;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    data['download_url'] = downloadUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Filters {
  String? year;
  String? policyNumber;

  Filters({this.year, this.policyNumber});

  Filters.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    policyNumber = json['policy_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['policy_number'] = policyNumber;
    return data;
  }
}
