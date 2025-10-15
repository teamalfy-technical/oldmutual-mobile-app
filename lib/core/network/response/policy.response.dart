import 'package:oldmutual_pensions_app/features/home/home.dart';

class PolicyResponse {
  List<Policy>? policyDetails;
  PolicyCounts? policyCounts;
  AppliedFilter? appliedFilter;

  PolicyResponse({this.policyDetails, this.policyCounts, this.appliedFilter});

  PolicyResponse.fromJson(Map<String, dynamic> json) {
    if (json['policy_details'] != null) {
      policyDetails = <Policy>[];
      json['policy_details'].forEach((v) {
        policyDetails!.add(Policy.fromJson(v));
      });
    }
    policyCounts = json['policy_counts'] != null
        ? PolicyCounts.fromJson(json['policy_counts'])
        : null;
    appliedFilter = json['applied_filter'] != null
        ? AppliedFilter.fromJson(json['applied_filter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (policyDetails != null) {
      data['policy_details'] = policyDetails!.map((v) => v.toJson()).toList();
    }
    if (policyCounts != null) {
      data['policy_counts'] = policyCounts!.toJson();
    }
    if (appliedFilter != null) {
      data['applied_filter'] = appliedFilter!.toJson();
    }
    return data;
  }
}

class PolicyCounts {
  int? totalFiltered;
  int? nonExpired;
  int? expired;

  PolicyCounts({this.totalFiltered, this.nonExpired, this.expired});

  PolicyCounts.fromJson(Map<String, dynamic> json) {
    totalFiltered = json['total_filtered'];
    nonExpired = json['non_expired'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_filtered'] = totalFiltered;
    data['non_expired'] = nonExpired;
    data['expired'] = expired;
    return data;
  }
}

class AppliedFilter {
  String? status;

  AppliedFilter({this.status});

  AppliedFilter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
