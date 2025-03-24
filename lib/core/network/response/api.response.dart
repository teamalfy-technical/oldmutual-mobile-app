class ApiResponse<T> {
  bool? success;
  T? data;
  String? message;

  ApiResponse({this.success, this.data, this.message});

  ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    success = json['success'];
    data = json['data'] != null ? fromJsonT(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data != null && toJsonT != null ? toJsonT(data as T) : null;
    json['message'] = message;
    return json;
  }
}
