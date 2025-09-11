class PolicySummary {
  int? totalPolicies;
  int? activePolicies;
  int? expiredPolicies;
  int? totalClaimAmount;
  int? pendingClaims;
  String? lastUpdated;

  PolicySummary({
    this.totalPolicies,
    this.activePolicies,
    this.expiredPolicies,
    this.totalClaimAmount,
    this.pendingClaims,
    this.lastUpdated,
  });

  PolicySummary.fromJson(Map<String, dynamic> json) {
    totalPolicies = json['total_policies'];
    activePolicies = json['active_policies'];
    expiredPolicies = json['expired_policies'];
    totalClaimAmount = json['total_claim_amount'];
    pendingClaims = json['pending_claims'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_policies'] = this.totalPolicies;
    data['active_policies'] = this.activePolicies;
    data['expired_policies'] = this.expiredPolicies;
    data['total_claim_amount'] = this.totalClaimAmount;
    data['pending_claims'] = this.pendingClaims;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
