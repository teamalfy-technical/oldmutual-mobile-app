import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

class Policy {
  String? policyNo;
  int? planCode;
  String? name;
  String? mobile;
  String? fullAddress;
  String? tIN;
  String? planDescription;
  double? sumAssured;
  double? cashValue;
  int? termOfPolicy;
  int? clientAge;
  String? clientNumber;
  double? modalPrem;
  String? paymentFrequency;
  String? paymentModeDescription;
  String? maturityDate;
  String? clientBirthdate;
  String? occupationName;
  String? issuedDate;
  String? premDueDate;
  String? lastPremDate;
  String? commencementDate;
  String? agentName;
  String? agentNo;
  String? agentBranchName;
  String? proposalDate;
  double? premiumPaid;
  double? availableBalance;
  String? status;
  List<Dependant>? dependants;
  List<Beneficiary>? beneficiaries;

  Policy({
    this.policyNo,
    this.planCode,
    this.name,
    this.mobile,
    this.fullAddress,
    this.tIN,
    this.planDescription,
    this.sumAssured,
    this.cashValue,
    this.termOfPolicy,
    this.clientAge,
    this.clientNumber,
    this.modalPrem,
    this.paymentFrequency,
    this.paymentModeDescription,
    this.maturityDate,
    this.clientBirthdate,
    this.occupationName,
    this.issuedDate,
    this.premDueDate,
    this.lastPremDate,
    this.commencementDate,
    this.agentName,
    this.agentNo,
    this.agentBranchName,
    this.proposalDate,
    this.premiumPaid,
    this.status,
    this.dependants,
    this.beneficiaries,
    this.availableBalance,
  });

  Policy.fromJson(Map<String, dynamic> json) {
    policyNo = _parseString(json['policy_no']);
    planCode = _parseInt(json['plan_code']);
    name = _parseString(json['name']);
    mobile = _parseString(json['mobile']);
    fullAddress = _parseString(json['full_address']);
    tIN = _parseString(json['TIN']);
    planDescription = _parseString(json['plan_description']);
    sumAssured = _parseDouble(json['sum_assured']);
    cashValue = _parseDouble(json['cash_value']);
    termOfPolicy = _parseInt(json['term_of_policy']);
    clientAge = _parseInt(json['client_age']);
    clientNumber = _parseString(json['client_number']);
    modalPrem = _parseDouble(json['modal_prem']);
    paymentFrequency = _parseString(json['payment_frequency']);
    paymentModeDescription = _parseString(json['payment_mode_description']);
    maturityDate = _parseString(json['maturity_date']);
    clientBirthdate = _parseString(json['client_birthdate']);
    occupationName = _parseString(json['occupation_name']);
    issuedDate = _parseString(json['issued_date']);
    premDueDate = _parseString(json['prem_due_date']);
    lastPremDate = _parseString(json['last_prem_date']);
    commencementDate = _parseString(json['commencement_date']);
    agentName = _parseString(json['agent_name']);
    agentNo = _parseString(json['agent_no']);
    agentBranchName = _parseString(json['agent_branch_name']);
    proposalDate = _parseString(json['proposal_date']);
    premiumPaid = _parseDouble(json['premium_paid']);
    availableBalance = _parseDouble(json['available_balance']);
    status = _parseString(json['status']);
    if (json['dependants'] != null) {
      dependants = <Dependant>[];
      json['dependants'].forEach((v) {
        dependants!.add(Dependant.fromJson(v));
      });
    }
    if (json['beneficiaries'] != null) {
      beneficiaries = <Beneficiary>[];
      json['beneficiaries'].forEach((v) {
        beneficiaries!.add(Beneficiary.fromJson(v));
      });
    }
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['policy_no'] = policyNo;
    data['plan_code'] = planCode;
    data['name'] = name;
    data['mobile'] = mobile;
    data['full_address'] = fullAddress;
    data['TIN'] = tIN;
    data['plan_description'] = planDescription;
    data['sum_assured'] = sumAssured;
    data['cash_value'] = cashValue;
    data['term_of_policy'] = termOfPolicy;
    data['client_age'] = clientAge;
    data['client_number'] = clientNumber;
    data['modal_prem'] = modalPrem;
    data['payment_frequency'] = paymentFrequency;
    data['payment_mode_description'] = paymentModeDescription;
    data['maturity_date'] = maturityDate;
    data['client_birthdate'] = clientBirthdate;
    data['occupation_name'] = occupationName;
    data['issued_date'] = issuedDate;
    data['prem_due_date'] = premDueDate;
    data['last_prem_date'] = lastPremDate;
    data['commencement_date'] = commencementDate;
    data['agent_name'] = agentName;
    data['agent_no'] = agentNo;
    data['agent_branch_name'] = agentBranchName;
    data['proposal_date'] = proposalDate;
    data['premium_paid'] = premiumPaid;
    data['available_balance'] = availableBalance;
    data['status'] = status;
    if (dependants != null) {
      data['dependants'] = dependants!.map((v) => v.toJson()).toList();
    }
    if (beneficiaries != null) {
      data['beneficiaries'] = beneficiaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dependant {
  String? name;
  String? birthdate;
  String? age;
  String? gender;
  double? premium;
  String? relationship;
  int? sumAssured;

  Dependant({
    this.name,
    this.birthdate,
    this.age,
    this.gender,
    this.premium,
    this.relationship,
    this.sumAssured,
  });

  Dependant.fromJson(Map<String, dynamic> json) {
    name = _parseString(json['name']);
    birthdate = _parseString(json['birthdate']);
    age = _parseString(json['age']);
    gender = _parseString(json['gender']);
    premium = _parseDouble(json['premium']);
    relationship = _parseString(json['relationship']);
    sumAssured = _parseInt(json['sum_assured']);
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['birthdate'] = birthdate;
    data['age'] = age;
    data['gender'] = gender;
    data['premium'] = premium;
    data['relationship'] = relationship;
    data['sum_assured'] = sumAssured;
    return data;
  }
}

// class Beneficiaries {
//   String? name;
//   String? relationship;
//   int? percentageAllocation;

//   Beneficiaries({this.name, this.relationship, this.percentageAllocation});

//   Beneficiaries.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     relationship = json['relationship'];
//     percentageAllocation = json['percentage_allocation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['relationship'] = relationship;
//     data['percentage_allocation'] = percentageAllocation;
//     return data;
//   }
// }
