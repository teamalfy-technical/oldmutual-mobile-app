class Factsheet {
  int? id;
  String? scheme;
  String? year;
  String? month;
  String? filePath;
  String? downloadLink;
  String? createdAt;
  String? updatedAt;

  Factsheet({
    this.id,
    this.scheme,
    this.year,
    this.month,
    this.filePath,
    this.downloadLink,
    this.createdAt,
    this.updatedAt,
  });

  Factsheet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheme = json['scheme'];
    year = json['year'];
    month = json['month'];
    filePath = json['file_path'];
    downloadLink = json['download_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['scheme'] = scheme;
    data['year'] = year;
    data['month'] = month;
    data['file_path'] = filePath;
    data['download_link'] = downloadLink;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
