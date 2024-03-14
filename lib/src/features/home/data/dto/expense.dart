import '../../domain/entities/expense.dart';

class ExpenseDto extends ExpenseEntity {
  const ExpenseDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
  });

  factory ExpenseDto.fromJson(final Map<String, dynamic> json) {
    return ExpenseDto(
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }
}
