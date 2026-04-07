import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class WithdrawalReason extends Equatable {
  int? id;
  String? description;

  WithdrawalReason({this.id, this.description});

  WithdrawalReason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['Description'];
  }

  @override
  List<Object?> get props => [id, description];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Description'] = description;
    return data;
  }
}
