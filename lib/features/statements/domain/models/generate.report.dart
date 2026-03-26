import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class GenerateReport extends Equatable {
  String? data;
  IMessage? message;

  GenerateReport({this.data, this.message});

  GenerateReport.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message =
        json['message'] != null ? IMessage.fromJson(json['message']) : null;
  }

  GenerateReport copyWith({String? data, IMessage? message}) {
    return GenerateReport(data: data ?? data, message: message ?? message);
  }

  
  @override
  List<Object?> get props => [data];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}

// ignore: must_be_immutable
class IMessage extends Equatable {
  int? reportId;

  IMessage({this.reportId});

  IMessage.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
  }

  
  @override
  List<Object?> get props => [reportId];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_id'] = reportId;
    return data;
  }
}
