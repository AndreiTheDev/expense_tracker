import '../../domain/entities/expense.dart';

class ExpenseDto extends ExpenseEntity {
  const ExpenseDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.id,
  });

  factory ExpenseDto.fromJson(final Map<String, dynamic> json) {
    return ExpenseDto(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }
}
