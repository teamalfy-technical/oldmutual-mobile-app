import 'package:flutter/material.dart';

class ComplimentaryService {
  final Widget icon;
  final String title;
  final String description;
  final DateTime createdAt;

  ComplimentaryService({
    required this.icon,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
