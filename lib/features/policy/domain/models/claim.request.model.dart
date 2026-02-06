class ClaimRequestResponse {
  String? claimId;
  String? policyNumber;
  double? claimAmount;
  String? status;
  String? message;
  String? createdAt;

  ClaimRequestResponse({
    this.claimId,
    this.policyNumber,
    this.claimAmount,
    this.status,
    this.message,
    this.createdAt,
  });

  ClaimRequestResponse.fromJson(Map<String, dynamic> json) {
    claimId = json['claim_id']?.toString();
    policyNumber = json['policy_number'];
    claimAmount = (json['claim_amount'] as num?)?.toDouble();
    status = json['status'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claim_id'] = claimId;
    data['policy_number'] = policyNumber;
    data['claim_amount'] = claimAmount;
    data['status'] = status;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
