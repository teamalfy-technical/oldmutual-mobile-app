class Statement {
  int? id;
  int? userId;
  String? type;
  String? status;
  String? filePath;
  String? downloadUrl;
  Filters? filters;
  String? createdAt;
  String? updatedAt;

  Statement({
    this.id,
    this.userId,
    this.type,
    this.status,
    this.filePath,
    this.downloadUrl,
    this.filters,
    this.createdAt,
    this.updatedAt,
  });

  Statement copyWith({
    int? id,
    int? userId,
    String? type,
    String? status,
    String? filePath,
    String? downloadUrl,
    Filters? filters,
    String? createdAt,
    String? updatedAt,
  }) {
    return Statement(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Statement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    status = json['status'];
    filePath = json['file_path'];
    downloadUrl = json['download_url'];
    filters =
        json['filters'] != null
            ? json['filters'] is List
                ? Filters.fromJson({'year': 'All'})
                : Filters.fromJson(json['filters'])
            : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['file_path'] = filePath;
    data['download_url'] = downloadUrl;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Filters {
  String? year;

  Filters({this.year});

  Filters copyWith({String? year}) {
    return Filters(year: year ?? this.year);
  }

  Filters.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    return data;
  }
}
