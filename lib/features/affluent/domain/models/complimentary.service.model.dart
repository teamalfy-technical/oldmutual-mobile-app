import 'package:flutter/material.dart';

enum RedemptionType { card, qrCode, code }

class ComplimentaryService {
  final Widget icon;
  final String title;
  final String subtitle;
  final String description;
  final DateTime createdAt;
  final String? overview;
  final List<String>? whatsIncluded;
  final RedemptionType redemptionType;
  final String? redemptionText;
  final String? redemptionCode;
  final String? qrCodeUrl;
  final String? phoneNumber;
  final String? email;
  final List<String>? termsAndConditions;
  final String? partnerUrl;

  ComplimentaryService({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.createdAt,
    this.overview,
    this.whatsIncluded,
    this.redemptionType = RedemptionType.card,
    this.redemptionText,
    this.redemptionCode,
    this.qrCodeUrl,
    this.phoneNumber,
    this.email,
    this.termsAndConditions,
    this.partnerUrl,
  });
}
