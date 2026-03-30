class RelationshipOfficer {
  String? agentCode;
  String? email;
  String? phone;
  String? name;

  RelationshipOfficer({this.agentCode, this.email, this.phone, this.name});

  RelationshipOfficer copyWith({
    String? agentCode,
    String? email,
    String? phone,
    String? name,
  }) {
    return RelationshipOfficer(
      agentCode: agentCode ?? this.agentCode,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
    );
  }

  RelationshipOfficer.fromJson(Map<String, dynamic> json) {
    agentCode = json['agent_code'];
    email = json['email'];
    phone = json['phone'];
    name = json['agent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agent_code'] = agentCode;
    data['email'] = email;
    data['phone'] = phone;
    data['agent_name'] = name;
    return data;
  }
}
