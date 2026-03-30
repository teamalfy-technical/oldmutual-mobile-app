import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class NotificationModel extends Equatable {
  String? id;
  String? type;
  int? notifiableId;
  String? notifiableType;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.type,
    this.notifiableId,
    this.notifiableType,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableId = json['notifiable_id'];
    notifiableType = json['notifiable_type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  
  @override
  List<Object?> get props => [id, type];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['notifiable_id'] = notifiableId;
    data['notifiable_type'] = notifiableType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// ignore: must_be_immutable
class Data extends Equatable {
  String? title;
  String? message;
  String? paymentDate;

  Data({this.title, this.message, this.paymentDate});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    paymentDate = json['payment_date'];
  }

  
  @override
  List<Object?> get props => [title, message];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['payment_date'] = paymentDate;
    return data;
  }
}
