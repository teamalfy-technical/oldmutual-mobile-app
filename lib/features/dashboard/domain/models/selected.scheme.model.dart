class SelectedScheme {
  int? id;
  String? name;
  String? memberNumber;
  String? phone;
  String? email;
  String? employerNumber;
  String? ssnitNumber;
  String? emailVerifiedAt;
  String? avatar;
  String? lastLoggedIn;
  String? lastLoggedInIp;
  String? lastLoggedInAgent;
  int? terms;
  String? createdAt;
  String? updatedAt;
  int? notificationsEnabled;
  String? dob;
  String? dateJoined;
  String? sex;
  String? nationality;
  String? role;
  String? masterScheme;
  String? schemeType;

  SelectedScheme({
    this.id,
    this.name,
    this.memberNumber,
    this.phone,
    this.email,
    this.employerNumber,
    this.ssnitNumber,
    this.emailVerifiedAt,
    this.avatar,
    this.lastLoggedIn,
    this.lastLoggedInIp,
    this.lastLoggedInAgent,
    this.terms,
    this.createdAt,
    this.updatedAt,
    this.notificationsEnabled,
    this.dob,
    this.dateJoined,
    this.sex,
    this.nationality,
    this.role,
    this.masterScheme,
    this.schemeType,
  });

  SelectedScheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    memberNumber = json['member_number'];
    phone = json['phone'];
    email = json['email'];
    employerNumber = json['employer_number'];
    ssnitNumber = json['ssnit_number'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    lastLoggedIn = json['last_logged_in'];
    lastLoggedInIp = json['last_logged_in_ip'];
    lastLoggedInAgent = json['last_logged_in_agent'];
    terms = json['terms'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notificationsEnabled = json['notifications_enabled'];
    dob = json['dob'];
    dateJoined = json['date_joined'];
    sex = json['sex'];
    nationality = json['nationality'];
    role = json['role'];
    masterScheme = json['master_scheme'];
    schemeType = json['scheme_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['member_number'] = memberNumber;
    data['phone'] = phone;
    data['email'] = email;
    data['employer_number'] = employerNumber;
    data['ssnit_number'] = ssnitNumber;
    data['email_verified_at'] = emailVerifiedAt;
    data['avatar'] = avatar;
    data['last_logged_in'] = lastLoggedIn;
    data['last_logged_in_ip'] = lastLoggedInIp;
    data['last_logged_in_agent'] = lastLoggedInAgent;
    data['terms'] = terms;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['notifications_enabled'] = notificationsEnabled;
    data['dob'] = dob;
    data['date_joined'] = dateJoined;
    data['sex'] = sex;
    data['nationality'] = nationality;
    data['role'] = role;
    data['master_scheme'] = masterScheme;
    data['scheme_type'] = schemeType;
    return data;
  }
}
