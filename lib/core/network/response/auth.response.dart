class AuthResponse {
  bool? status;
  String? error;
  String? title;
  Data? data;
  String? userId;

  AuthResponse({this.status, this.error, this.title, this.data, this.userId});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    title = json['title'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['title'] = title;
    if (data['data'] != null) {
      data['data'] = this.data?.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class Data {
  String? token;
  String? message;

  Data({this.token, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}
