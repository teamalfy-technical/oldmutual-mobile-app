import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class Payment extends Equatable {
  int? id;
  int? userId;
  String? product;
  String? policyNumber;
  String? description;
  String? clientReference;
  String? paymentReference;
  String? amount;
  String? currency;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? paymentChannel;
  String? paymentResponse;
  String? completedAt;
  String? failureReason;
  String? failedAt;

  Payment({
    this.id,
    this.userId,
    this.product,
    this.policyNumber,
    this.description,
    this.clientReference,
    this.paymentReference,
    this.amount,
    this.currency,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentChannel,
    this.paymentResponse,
    this.completedAt,
    this.failureReason,
    this.failedAt,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    userId = _parseInt(json['user_id']);
    product = _parseString(json['product']);
    policyNumber = _parseString(json['policy_number']);
    description = _parseString(json['description']);
    clientReference = _parseString(json['client_reference']);
    paymentReference = _parseString(json['payment_reference']);
    amount = _parseString(json['amount']);
    currency = _parseString(json['currency']);
    status = _parseString(json['status']);
    createdAt = _parseString(json['created_at']);
    updatedAt = _parseString(json['updated_at']);
    paymentChannel = _parseString(json['payment_channel']);
    paymentResponse = _parseString(json['payment_response']);
    completedAt = _parseString(json['completed_at']);
    failureReason = _parseString(json['failure_reason']);
    failedAt = _parseString(json['failed_at']);
  }

  
  @override
  List<Object?> get props => [id, clientReference, paymentReference];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product': product,
      'policy_number': policyNumber,
      'description': description,
      'client_reference': clientReference,
      'payment_reference': paymentReference,
      'amount': amount,
      'currency': currency,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'payment_channel': paymentChannel,
      'payment_response': paymentResponse,
      'completed_at': completedAt,
      'failure_reason': failureReason,
      'failed_at': failedAt,
    };
  }

  String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Get parsed amount as double
  double get amountAsDouble => double.tryParse(amount ?? '0') ?? 0.0;

  /// Check if payment was successful
  bool get isSuccessful => status?.toUpperCase() == 'SUCCESS';

  /// Check if payment failed
  bool get isFailed => status?.toUpperCase() == 'FAILED';

  /// Check if payment is pending
  bool get isPending => status?.toUpperCase() == 'PENDING';
}
