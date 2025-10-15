class PolicySummary {
  int? totalPolicies;
  int? activePolicies;
  int? expiredPolicies;
  double? totalClaimAmount;
  int? pendingClaims;
  double? totalCover;
  String? availableBalance;
  String? lastUpdated;

  PolicySummary({
    this.totalPolicies,
    this.activePolicies,
    this.expiredPolicies,
    this.totalClaimAmount,
    this.pendingClaims,
    this.totalCover,
    this.availableBalance,
    this.lastUpdated,
  });

  PolicySummary.fromJson(Map<String, dynamic> json) {
    totalPolicies = json['total_policies'];
    activePolicies = json['active_policies'];
    expiredPolicies = json['expired_policies'];
    totalClaimAmount = json['total_claim_amount']?.toDouble();
    pendingClaims = json['pending_claims'];
    totalCover = json['total_cover']?.toDouble();
    availableBalance = json['available_balance'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_policies'] = totalPolicies;
    data['active_policies'] = activePolicies;
    data['expired_policies'] = expiredPolicies;
    data['total_claim_amount'] = totalClaimAmount;
    data['pending_claims'] = pendingClaims;
    data['total_cover'] = totalCover;
    data['available_balance'] = availableBalance;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
