import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/expense.dart';

class ExpenseDto extends ExpenseEntity {
  const ExpenseDto({
    required super.id,
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.relatedDoc,
  });

  factory ExpenseDto.fromEntity(final ExpenseEntity entity) {
    return ExpenseDto(
      id: entity.id,
      category: entity.category,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
      relatedDoc: entity.relatedDoc,
    );
  }

  factory ExpenseDto.fromJson(final Map<String, dynamic> json) {
    final Timestamp date = json['date'];
    return ExpenseDto(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: date.toDate(),
      relatedDoc: json['relatedDoc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
      'relatedDoc': relatedDoc,
    };
  }
}
