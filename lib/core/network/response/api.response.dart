class ApiResponse {
  bool? status;
  String? error;
  String? title;
  dynamic data;
  String? userId;

  ApiResponse({this.status, this.error, this.title, this.data, this.userId});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    title = json['title'];
    // data =
    //     (json['data'] is String) ? json['data'] : Data.fromJson(json['data']);
    data = json['data'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['title'] = title;
    // if (data['data'] is Map) {
    //   data['data'] = this.data.toJson();
    // } else {
    //   data['data'] = this.data;
    // }
    data['data'] = this.data;
    data['userId'] = userId;
    return data;
  }
}
