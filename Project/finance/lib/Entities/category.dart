import 'package:finance/methods/getIconData.dart';
import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final int id;
  final String name;
  final double amount;
  final bool isExceeded;
  final bool isExpense;
  final DateTime dateTime;

  Category({
    required this.icon,
    required this.name,
    required this.amount,
    required this.isExceeded,
    required this.isExpense,
    required this.id,
    required this.dateTime,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      icon: getIconData(json['name']),
      name: json['name'],
      amount: json['amount'] + 0.0,
      dateTime: DateTime.parse(json['date_time']),
      isExceeded: json['is_exceeded'],
      isExpense: json['is_expense'],
      id: json['id'],
    );
  }
}
