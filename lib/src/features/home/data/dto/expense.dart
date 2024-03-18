import '../../domain/entities/expense.dart';

class ExpenseDto extends ExpenseEntity {
  ExpenseDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    super.relatedDoc,
    super.id,
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
    return ExpenseDto(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
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
      'relatedDoc': relatedDoc ?? '',
    };
  }
}
