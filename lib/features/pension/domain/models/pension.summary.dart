import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class PensionSummary extends Equatable {
  int? totalPensions;
  double? totalInvestment;

  PensionSummary({this.totalPensions, this.totalInvestment});

  PensionSummary.fromJson(Map<String, dynamic> json) {
    totalPensions = (json['total_pensions'] as num?)?.toInt();
    totalInvestment = (json['total_investment'] as num?)?.toDouble();
  }

  
  @override
  List<Object?> get props => [totalPensions];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_pensions'] = totalPensions;
    data['total_investment'] = totalInvestment;
    return data;
  }
}
