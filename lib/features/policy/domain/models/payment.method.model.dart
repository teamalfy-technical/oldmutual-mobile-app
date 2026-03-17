import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class PaymentMethod extends Equatable {
  String? name;
  String? code;

  PaymentMethod({this.name, this.code});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    code = json['emp_code'];
  }

  
  @override
  List<Object?> get props => [code, name];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['emp_code'] = code;
    return data;
  }
}
