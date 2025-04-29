class ReportStatus {
  String? status;
  String? createdAt;
  String? downloadUrl;
  String? period;

  ReportStatus({this.status, this.createdAt, this.downloadUrl, this.period});

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

  ReportStatus copyWith({
    String? status,
    String? createdAt,
    String? downloadUrl,
    String? period,
  }) {
    return ReportStatus(
      status: status ?? status,
      createdAt: createdAt ?? createdAt,
      downloadUrl: downloadUrl ?? downloadUrl,
      period: period ?? period,
    );
  }

  bool isEmpty() {
    return status == null && createdAt == null && downloadUrl == null;
  }
}
