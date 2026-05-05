import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class InitiatePaymentResponse extends Equatable {
  String? checkoutUrl;
  String? checkoutId;
  String? clientReference;
  String? message;
  String? checkoutDirectUrl;

  InitiatePaymentResponse({
    this.checkoutUrl,
    this.checkoutId,
    this.clientReference,
    this.message,
    this.checkoutDirectUrl,
  });

  InitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    checkoutUrl = _parseString(json['checkoutUrl'] ?? json['checkout_url']);
    checkoutId = _parseString(json['checkoutId'] ?? json['checkout_id']);
    clientReference = _parseString(
      json['clientReference'] ?? json['client_reference'],
    );
    message = _parseString(json['message']);
    checkoutDirectUrl = _parseString(
      json['checkoutDirectUrl'] ?? json['checkout_direct_url'],
    );
  }


  @override
  List<Object?> get props => [
    checkoutUrl,
    checkoutId,
    clientReference,
    checkoutDirectUrl,
  ];

  Map<String, dynamic> toJson() {
    return {
      'checkoutUrl': checkoutUrl,
      'checkoutId': checkoutId,
      'clientReference': clientReference,
      'message': message,
      'checkoutDirectUrl': checkoutDirectUrl,
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
