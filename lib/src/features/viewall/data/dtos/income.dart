import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/income.dart';

class IncomeDto extends IncomeEntity {
  const IncomeDto({
    required super.id,
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.relatedDoc,
  });

  factory IncomeDto.fromEntity(final IncomeEntity entity) {
    return IncomeDto(
      id: entity.id,
      category: entity.category,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
      relatedDoc: entity.relatedDoc,
    );
  }

  factory IncomeDto.fromJson(final Map<String, dynamic> json) {
    final Timestamp date = json['date'];
    return IncomeDto(
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
