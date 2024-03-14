import '../../domain/entities/income.dart';

class IncomeDto extends IncomeEntity {
  const IncomeDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
  });

  factory IncomeDto.fromJson(final Map<String, dynamic> json) {
    return IncomeDto(
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
