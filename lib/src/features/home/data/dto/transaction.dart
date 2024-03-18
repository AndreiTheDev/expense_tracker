import '../../domain/entities/transaction.dart';

class TransactionDto extends TransactionEntity {
  TransactionDto({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    super.relatedDoc,
    super.id,
  });

  factory TransactionDto.fromEntity(final TransactionEntity entity) {
    return TransactionDto(
      id: entity.id,
      category: entity.category,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
      relatedDoc: entity.relatedDoc,
    );
  }

  factory TransactionDto.fromJson(final Map<String, dynamic> json) {
    return TransactionDto(
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
