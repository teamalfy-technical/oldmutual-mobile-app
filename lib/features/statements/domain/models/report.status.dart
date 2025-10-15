class ReportDownload {
  String? expiresAt;
  String? createdAt;
  String? downloadUrl;
  String? period;

  ReportDownload({
    this.expiresAt,
    this.createdAt,
    this.downloadUrl,
    this.period,
  });

  ReportDownload.fromJson(Map<String, dynamic> json) {
    expiresAt = json['expires_at'];
    createdAt = json['created_at'];
    downloadUrl = json['download_url'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expires_at'] = expiresAt;
    data['created_at'] = createdAt;
    data['download_url'] = downloadUrl;
    data['period'] = period;
    return data;
  }

  ReportDownload copyWith({
    String? expiresAt,
    String? createdAt,
    String? downloadUrl,
    String? period,
  }) {
    return ReportDownload(
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      period: period ?? this.period,
    );
  }

  bool isEmpty() {
    return expiresAt == null && createdAt == null && downloadUrl == null;
  }
}

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
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      period: period ?? this.period,
    );
  }

  bool isEmpty() {
    return status == null && createdAt == null && downloadUrl == null;
  }
}
