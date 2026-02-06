class PaymentMethod {
  String? id;
  String? name;
  String? code;

  PaymentMethod({this.id, this.name, this.code});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    code = json['emp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['emp_code'] = code;
    return data;
  }
}
