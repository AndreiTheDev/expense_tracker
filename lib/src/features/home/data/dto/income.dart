import '../../domain/entities/income.dart';

class IncomeDto extends IncomeEntity {
  IncomeDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    super.relatedDoc,
    super.id,
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
    return IncomeDto(
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
