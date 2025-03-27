class ContributionHistory {
  TransactionHistory? transactionHistory;
  List<dynamic>? memberClaims;

  ContributionHistory({this.transactionHistory, this.memberClaims});

  ContributionHistory.fromJson(Map<String, dynamic> json) {
    transactionHistory =
        json['transaction_history'] != null
            ? TransactionHistory.fromJson(json['transaction_history'])
            : null;
    if (json['member_claims'] != null) {
      memberClaims = <Null>[];
      json['member_claims'].forEach((v) {
        // memberClaims!.add(new Null.fromJson(v));
        memberClaims!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactionHistory != null) {
      data['transaction_history'] = transactionHistory!.toJson();
    }
    if (memberClaims != null) {
      data['member_claims'] = memberClaims!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  String? status;
  int? accountValue;
  double? totalContributionTally;
  double? employerContribution;
  double? transferReceived;
  double? totalRedemption;
  double? gainLoss;
  double? currentPrice;
  String? dateJoined;
  String? retirementData;
  double? unitsBf;
  List<Transactions>? transactions;

  TransactionHistory({
    this.status,
    this.accountValue,
    this.totalContributionTally,
    this.employerContribution,
    this.transferReceived,
    this.totalRedemption,
    this.gainLoss,
    this.currentPrice,
    this.dateJoined,
    this.retirementData,
    this.unitsBf,
    this.transactions,
  });

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accountValue = json['account_value'];
    totalContributionTally = json['total_contribution_tally'].toDouble();
    employerContribution = json['employer_contribution'].toDouble();
    transferReceived = json['transfer_received'].toDouble();
    totalRedemption = json['total_redemption'].toDouble();
    gainLoss = json['gain_loss'].toDouble();
    currentPrice = json['current_price'].toDouble();
    dateJoined = json['date_joined'];
    retirementData = json['retirement_data'];
    unitsBf = json['units_bf'].toDouble();
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['account_value'] = accountValue;
    data['total_contribution_tally'] = totalContributionTally;
    data['employer_contribution'] = employerContribution;
    data['transfer_received'] = transferReceived;
    data['total_redemption'] = totalRedemption;
    data['gain_loss'] = gainLoss;
    data['current_price'] = currentPrice;
    data['date_joined'] = dateJoined;
    data['retirement_data'] = retirementData;
    data['units_bf'] = unitsBf;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? paymentDate;
  double? received;
  String? pensionTypeId;
  String? paymentFlag;
  String? pensionTypeName;
  int? schemeId;
  String? schemeName;
  double? unitsAllocated;
  double? unitPrice;
  double? employerContribution;
  String? narration;

  Transactions({
    this.paymentDate,
    this.received,
    this.pensionTypeId,
    this.paymentFlag,
    this.pensionTypeName,
    this.schemeId,
    this.schemeName,
    this.unitsAllocated,
    this.unitPrice,
    this.employerContribution,
    this.narration,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    paymentDate = json['payment_date'];
    received = json['received'].toDouble();
    pensionTypeId = json['pension_type_id'];
    paymentFlag = json['payment_flag'];
    pensionTypeName = json['pension_type_name'];
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
    unitsAllocated = json['units_allocated'].toDouble();
    unitPrice = json['unit_price'].toDouble();
    employerContribution = json['employer_contribution'].toDouble();
    narration = json['narration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_date'] = paymentDate;
    data['received'] = received;
    data['pension_type_id'] = pensionTypeId;
    data['payment_flag'] = paymentFlag;
    data['pension_type_name'] = pensionTypeName;
    data['scheme_id'] = schemeId;
    data['scheme_name'] = schemeName;
    data['units_allocated'] = unitsAllocated;
    data['unit_price'] = unitPrice;
    data['employer_contribution'] = employerContribution;
    data['narration'] = narration;
    return data;
  }
}
