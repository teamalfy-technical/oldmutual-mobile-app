class Member {
  String? memberId;
  String? name;
  String? phone;
  String? email;
  String? avatar;
  String? lastLoggedIn;
  String? lastLoggedInIp;
  String? lastLoggedInAgent;
  String? token;
  String? error;

  Member({
    this.memberId,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.lastLoggedIn,
    this.lastLoggedInIp,
    this.lastLoggedInAgent,
    this.token,
    this.error,
  });

  Member.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
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
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['last_logged_in'] = lastLoggedIn;
    data['last_logged_in_ip'] = lastLoggedInIp;
    data['last_logged_in_agent'] = lastLoggedInAgent;
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
