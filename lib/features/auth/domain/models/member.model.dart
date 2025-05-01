class Member {
  String? token;
  int? id;
  String? name;
  String? memberNumber;
  String? schemeType;
  String? masterScheme;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? employerNumber;
  String? ssnitNumber;
  String? avatar;
  String? dob;
  String? dateJoined;
  dynamic sex;
  String? nationality;
  String? notificationsEnabled;
  String? terms;
  String? lastLoggedIn;
  String? lastLoggedInIp;
  String? lastLoggedInAgent;
  String? role;
  String? createdAt;
  String? updatedAt;

  Member({
    this.token,
    this.id,
    this.name,
    this.memberNumber,
    this.schemeType,
    this.masterScheme,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.employerNumber,
    this.ssnitNumber,
    this.avatar,
    this.dob,
    this.dateJoined,
    this.sex,
    this.nationality,
    this.notificationsEnabled,
    this.terms,
    this.lastLoggedIn,
    this.lastLoggedInIp,
    this.lastLoggedInAgent,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  Member copyWith({
    String? token,
    int? id,
    String? name,
    String? memberNumber,
    String? schemeType,
    String? masterScheme,
    String? phone,
    String? email,
    String? emailVerifiedAt,
    String? employerNumber,
    String? ssnitNumber,
    String? avatar,
    String? dob,
    String? dateJoined,
    dynamic sex,
    String? nationality,
    String? notificationsEnabled,
    String? terms,
    String? lastLoggedIn,
    String? lastLoggedInIp,
    String? lastLoggedInAgent,
    String? role,
    String? createdAt,
    String? updatedAt,
  }) {
    return Member(
      token: token ?? this.token,
      id: id ?? this.id,
      name: name ?? this.name,
      memberNumber: memberNumber ?? this.memberNumber,
      schemeType: schemeType ?? this.schemeType,
      masterScheme: masterScheme ?? this.masterScheme,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      employerNumber: employerNumber ?? this.employerNumber,
      ssnitNumber: ssnitNumber ?? this.ssnitNumber,
      avatar: avatar ?? this.avatar,
      dob: dob ?? this.dob,
      dateJoined: dateJoined ?? this.dateJoined,
      sex: sex ?? this.sex,
      nationality: nationality ?? this.nationality,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      terms: terms ?? this.terms,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      lastLoggedInIp: lastLoggedInIp ?? this.lastLoggedInIp,
      lastLoggedInAgent: lastLoggedInAgent ?? this.lastLoggedInAgent,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Member.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    memberNumber = json['member_number'];
    schemeType = json['scheme_type'];
    masterScheme = json['master_scheme'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    employerNumber = json['employer_number'];
    ssnitNumber = json['ssnit_number'];
    avatar = json['avatar'];
    dob = json['dob'];
    dateJoined = json['date_joined'];
    sex = json['sex'];
    nationality = json['nationality'];
    notificationsEnabled = json['notifications_enabled'];
    terms = json['terms'];
    lastLoggedIn = json['last_logged_in'];
    lastLoggedInIp = json['last_logged_in_ip'];
    lastLoggedInAgent = json['last_logged_in_agent'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['name'] = name;
    data['member_number'] = memberNumber;
    data['scheme_type'] = schemeType;
    data['master_scheme'] = masterScheme;
    data['phone'] = phone;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['employer_number'] = employerNumber;
    data['ssnit_number'] = ssnitNumber;
    data['avatar'] = avatar;
    data['dob'] = dob;
    data['date_joined'] = dateJoined;
    data['sex'] = sex;
    data['nationality'] = nationality;
    data['notifications_enabled'] = notificationsEnabled;
    data['terms'] = terms;
    data['last_logged_in'] = lastLoggedIn;
    data['last_logged_in_ip'] = lastLoggedInIp;
    data['last_logged_in_agent'] = lastLoggedInAgent;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
