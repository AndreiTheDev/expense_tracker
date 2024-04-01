import 'package:equatable/equatable.dart';

import '../../../../core/interfaces/entities/transaction_interface.dart';

class TransactionEntity extends Equatable implements ITransactionEntity {
  @override
  final String id;
  @override
  final String category;
  @override
  final String description;
  @override
  final double amount;
  @override
  final DateTime date;
  @override
  final String relatedDoc;

  const TransactionEntity({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.relatedDoc,
  });

  @override
  List<Object?> get props => [
        id,
        category,
        description,
        amount,
        date,
        relatedDoc,
      ];
}
