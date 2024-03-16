import '../../domain/entities/income.dart';

class IncomeDto extends IncomeEntity {
  const IncomeDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.id,
  });

  factory IncomeDto.fromJson(final Map<String, dynamic> json) {
    return IncomeDto(
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
