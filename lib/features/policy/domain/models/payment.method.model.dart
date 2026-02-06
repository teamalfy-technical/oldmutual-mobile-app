class PaymentMethod {
  String? name;
  String? code;

  PaymentMethod({this.name, this.code});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    code = json['emp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['emp_code'] = code;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentMethod &&
        other.code == code &&
        other.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}
