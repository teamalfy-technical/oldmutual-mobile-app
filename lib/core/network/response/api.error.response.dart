class ApiErrorResponse {
  int? status;
  String? error;
  String? title;
  String? traceId;

  ApiErrorResponse({this.status, this.error, this.title, this.traceId});

  ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    title = json['title'];
    traceId = json['traceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['title'] = title;
    data['traceId'] = traceId;
    return data;
  }
}
