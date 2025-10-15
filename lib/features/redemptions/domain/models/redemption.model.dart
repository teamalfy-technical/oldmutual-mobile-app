class Redemption {
  String? nationalId;
  String? redemptionType;
  String? percentage;
  String? amount;
  String? redemptionReason;
  String? bankAccount;
  String? bankName;
  String? accountHolderName;
  String? updatedAt;
  String? createdAt;
  int? id;
  int? userId;
  String? scheme;
  String? memberNumber;
  String? ssnitNumber;

  Redemption({
    this.nationalId,
    this.redemptionType,
    this.percentage,
    this.amount,
    this.redemptionReason,
    this.bankAccount,
    this.bankName,
    this.accountHolderName,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.userId,
    this.scheme,
    this.memberNumber,
    this.ssnitNumber,
  });

  Redemption.fromJson(Map<String, dynamic> json) {
    nationalId = json['national_id'];
    redemptionType = json['redemption_type'];
    percentage = json['percentage'];
    amount = json['amount'];
    redemptionReason = json['redemption_reason'];
    bankAccount = json['bank_account'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    userId = json['user_id'];
    scheme = json['scheme'];
    memberNumber = json['member_number'];
    ssnitNumber = json['ssnit_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['national_id'] = nationalId;
    data['redemption_type'] = redemptionType;
    data['percentage'] = percentage;
    data['amount'] = amount;
    data['redemption_reason'] = redemptionReason;
    data['bank_account'] = bankAccount;
    data['bank_name'] = bankName;
    data['account_holder_name'] = accountHolderName;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['user_id'] = userId;
    data['scheme'] = scheme;
    data['member_number'] = memberNumber;
    data['ssnit_number'] = ssnitNumber;
    return data;
  }
}
