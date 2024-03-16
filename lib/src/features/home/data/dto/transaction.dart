import '../../domain/entities/transaction.dart';

class TransactionDto extends TransactionEntity {
  const TransactionDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.id,
  });

  factory TransactionDto.fromJson(final Map<String, dynamic> json) {
    return TransactionDto(
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
