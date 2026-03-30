import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class PolicyTransaction extends Equatable {
  int? id;
  String? policyNo;
  int? policyId;
  String? paymentDate;
  double? received;
  double? modalPremium;
  int? prevMainSusp;
  int? mainSusp;
  String? premDueDate;
  int? prevPremUnits;
  int? premUnits;
  int? currentPremiums;
  String? paymentStatus;
  int? cashValue;
  double? commPayable;
  double? moneyAllocated;
  int? agentNo;
  int? investmentPrem;
  String? investmentDate;
  String? transType;
  double? polFee;
  int? adminCharge;
  bool? isRefunded;
  int? sa;
  int? totalCashValue;
  int? intDays;
  double? netPremium;
  int? periodYear;
  int? periodMonth;
  bool? accumulated;
  bool? isArrears;
  int? interestAmt;
  int? netAccValue;
  bool? isManualReceipts;
  String? createdOn;
  dynamic comment;
  String? source;
  String? receiptNumber;
  bool? isFirstPremium;
  String? paymentStatusDesc;

  PolicyTransaction({
    this.id,
    this.policyNo,
    this.policyId,
    this.paymentDate,
    this.received,
    this.modalPremium,
    this.prevMainSusp,
    this.mainSusp,
    this.premDueDate,
    this.prevPremUnits,
    this.premUnits,
    this.currentPremiums,
    this.paymentStatus,
    this.cashValue,
    this.commPayable,
    this.moneyAllocated,
    this.agentNo,
    this.investmentPrem,
    this.investmentDate,
    this.transType,
    this.polFee,
    this.adminCharge,
    this.isRefunded,
    this.sa,
    this.totalCashValue,
    this.intDays,
    this.netPremium,
    this.periodYear,
    this.periodMonth,
    this.accumulated,
    this.isArrears,
    this.interestAmt,
    this.netAccValue,
    this.isManualReceipts,
    this.createdOn,
    this.comment,
    this.source,
    this.receiptNumber,
    this.isFirstPremium,
    this.paymentStatusDesc,
  });

  PolicyTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policyNo = json['policy_no'];
    policyId = json['PolicyId'];
    paymentDate = json['payment_date'];
    received = json['received'];
    modalPremium = json['modal_premium'];
    prevMainSusp = json['Prev_main_susp'];
    mainSusp = json['main_susp'];
    premDueDate = json['prem_due_date'];
    prevPremUnits = json['prev_prem_units'];
    premUnits = json['prem_units'];
    currentPremiums = json['current_premiums'];
    paymentStatus = json['payment_status'];
    cashValue = json['cash_value'];
    commPayable = json['comm_payable'];
    moneyAllocated = json['money_allocated'];
    agentNo = json['agent_no'];
    investmentPrem = json['investment_prem'];
    investmentDate = json['investment_date'];
    transType = json['trans_type'];
    polFee = json['pol_fee'];
    adminCharge = json['admin_charge'];
    isRefunded = json['IsRefunded'];
    sa = json['sa'];
    totalCashValue = json['totalCashValue'];
    intDays = json['int_days'];
    netPremium = json['net_premium'];
    periodYear = json['period_year'];
    periodMonth = json['period_month'];
    accumulated = json['accumulated'];
    isArrears = json['isArrears'];
    interestAmt = json['InterestAmt'];
    netAccValue = json['NetAccValue'];
    isManualReceipts = json['IsManualReceipts'];
    createdOn = json['created_on'];
    comment = json['comment'];
    source = json['source'];
    receiptNumber = json['receipt_number'];
    isFirstPremium = json['IsFirstPremium'];
    paymentStatusDesc = json['payment_status_desc'];
  }

  
  @override
  List<Object?> get props => [id, policyNo, policyId];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['policy_no'] = policyNo;
    data['PolicyId'] = policyId;
    data['payment_date'] = paymentDate;
    data['received'] = received;
    data['modal_premium'] = modalPremium;
    data['Prev_main_susp'] = prevMainSusp;
    data['main_susp'] = mainSusp;
    data['prem_due_date'] = premDueDate;
    data['prev_prem_units'] = prevPremUnits;
    data['prem_units'] = premUnits;
    data['current_premiums'] = currentPremiums;
    data['payment_status'] = paymentStatus;
    data['cash_value'] = cashValue;
    data['comm_payable'] = commPayable;
    data['money_allocated'] = moneyAllocated;
    data['agent_no'] = agentNo;
    data['investment_prem'] = investmentPrem;
    data['investment_date'] = investmentDate;
    data['trans_type'] = transType;
    data['pol_fee'] = polFee;
    data['admin_charge'] = adminCharge;
    data['IsRefunded'] = isRefunded;
    data['sa'] = sa;
    data['totalCashValue'] = totalCashValue;
    data['int_days'] = intDays;
    data['net_premium'] = netPremium;
    data['period_year'] = periodYear;
    data['period_month'] = periodMonth;
    data['accumulated'] = accumulated;
    data['isArrears'] = isArrears;
    data['InterestAmt'] = interestAmt;
    data['NetAccValue'] = netAccValue;
    data['IsManualReceipts'] = isManualReceipts;
    data['created_on'] = createdOn;
    data['comment'] = comment;
    data['source'] = source;
    data['receipt_number'] = receiptNumber;
    data['IsFirstPremium'] = isFirstPremium;
    data['payment_status_desc'] = paymentStatusDesc;
    return data;
  }
}
