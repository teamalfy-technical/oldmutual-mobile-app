class ReportStatus {
  String? status;
  String? createdAt;
  String? downloadUrl;

  ReportStatus({this.status, this.createdAt, this.downloadUrl});

  ReportStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    createdAt = json['created_at'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['created_at'] = createdAt;
    data['download_url'] = downloadUrl;
    return data;
  }

  bool isEmpty() {
    return status == null && createdAt == null && downloadUrl == null;
  }
}
