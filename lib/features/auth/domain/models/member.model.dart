class Member {
  String? token;
  String? name;
  String? memberNumber;
  String? phone;
  String? email;
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

  Member({
    this.token,
    this.name,
    this.memberNumber,
    this.phone,
    this.email,
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
  });

  Member.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    memberNumber = json['member_number'];
    phone = json['phone'];
    email = json['email'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['member_number'] = memberNumber;
    data['phone'] = phone;
    data['email'] = email;
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
    return data;
  }
}
