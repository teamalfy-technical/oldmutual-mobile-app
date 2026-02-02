class InitiatePaymentResponse {
  String? checkoutUrl;

  InitiatePaymentResponse({this.checkoutUrl});

  InitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    checkoutUrl = _parseString(json['checkoutUrl'] ?? json['checkout_url']);
  }

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

class InitiatePensionsPaymentRequest {
  double amount;
  String currency;

  InitiatePensionsPaymentRequest({
    required this.amount,
    this.currency = 'GHS',
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}

class InitiatePolicyPaymentRequest {
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

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'policy_number': policyNumber,
      'product': product,
      'currency': currency,
    };
  }
}
