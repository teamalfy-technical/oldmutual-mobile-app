class Member {
  String? memberId;
  String? name;
  String? memberNumber;
  String? phone;
  String? email;
  String? employerNumber;
  String? ssnitNumber;
  String? avatar;
  String? notificationsEnabled;
  String? terms;
  String? lastLoggedIn;
  String? lastLoggedInIp;
  String? lastLoggedInAgent;
  String? token;
  String? error;

  Member({
    this.memberId,
    this.name,
    this.memberNumber,
    this.phone,
    this.email,
    this.employerNumber,
    this.ssnitNumber,
    this.avatar,
    this.notificationsEnabled,
    this.terms,
    this.lastLoggedIn,
    this.lastLoggedInIp,
    this.lastLoggedInAgent,
    this.token,
    this.error,
  });

  Member.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    name = json['name'];
    memberNumber = json['member_number'];
    phone = json['phone'];
    email = json['email'];
    employerNumber = json['employer_number'];
    ssnitNumber = json['ssnit_number'];
    avatar = json['avatar'];
    notificationsEnabled = json['notifications_enabled'];
    terms = json['terms'];
    lastLoggedIn = json['last_logged_in'];
    lastLoggedInIp = json['last_logged_in_ip'];
    lastLoggedInAgent = json['last_logged_in_agent'];
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_id'] = memberId;
    data['name'] = name;
    data['member_number'] = memberNumber;
    data['phone'] = phone;
    data['email'] = email;
    data['employer_number'] = employerNumber;
    data['ssnit_number'] = ssnitNumber;
    data['avatar'] = avatar;
    data['notifications_enabled'] = notificationsEnabled;
    data['terms'] = terms;
    data['last_logged_in'] = lastLoggedIn;
    data['last_logged_in_ip'] = lastLoggedInIp;
    data['last_logged_in_agent'] = lastLoggedInAgent;
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
