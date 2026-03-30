import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class InitiatePaymentResponse extends Equatable {
  String? checkoutUrl;

  InitiatePaymentResponse({this.checkoutUrl});

  InitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    checkoutUrl = _parseString(json['checkoutUrl'] ?? json['checkout_url']);
  }

  
  @override
  List<Object?> get props => [checkoutUrl];

  Map<String, dynamic> toJson() {
    return {
      'checkoutUrl': checkoutUrl,
    };
  }

  String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}

class InitiatePensionsPaymentRequest extends Equatable {
  double amount;
  String currency;

  InitiatePensionsPaymentRequest({
    required this.amount,
    this.currency = 'GHS',
  });

  
  @override
  List<Object?> get props => [amount, currency];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class InitiatePolicyPaymentRequest extends Equatable {
  double amount;
  String policyNumber;
  String product;
  String currency;

  InitiatePolicyPaymentRequest({
    required this.amount,
    required this.policyNumber,
    required this.product,
    this.currency = 'GHS',
  });

  
  @override
  List<Object?> get props => [policyNumber, product, amount];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'policy_number': policyNumber,
      'product': product,
      'currency': currency,
    };
  }
}
