import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

class Policy {
  String? policyNo;
  int? planCode;
  String? name;
  String? mobile;
  String? fullAddress;
  String? tIN;
  String? planDescription;
  int? sumAssured;
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
  });

  Policy.fromJson(Map<String, dynamic> json) {
    policyNo = json['policy_no'];
    planCode = json['plan_code'];
    name = json['name'];
    mobile = json['mobile'];
    fullAddress = json['full_address'];
    tIN = json['TIN'];
    planDescription = json['plan_description'];
    sumAssured = json['sum_assured'];
    termOfPolicy = json['term_of_policy'];
    clientAge = json['client_age'];
    clientNumber = json['client_number'];
    modalPrem = json['modal_prem']?.toDouble();
    paymentFrequency = json['payment_frequency'];
    paymentModeDescription = json['payment_mode_description'];
    maturityDate = json['maturity_date'];
    clientBirthdate = json['client_birthdate'];
    occupationName = json['occupation_name'];
    issuedDate = json['issued_date'];
    premDueDate = json['prem_due_date'];
    lastPremDate = json['last_prem_date'];
    commencementDate = json['commencement_date'];
    agentName = json['agent_name'];
    agentNo = json['agent_no'];
    agentBranchName = json['agent_branch_name'];
    proposalDate = json['proposal_date'];
    premiumPaid = json['premium_paid']?.toDouble();
    status = json['status'];
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
    name = json['name'];
    birthdate = json['birthdate'];
    age = json['age'];
    gender = json['gender'];
    premium = json['premium']?.toDouble();
    relationship = json['relationship'];
    sumAssured = json['sum_assured'];
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
