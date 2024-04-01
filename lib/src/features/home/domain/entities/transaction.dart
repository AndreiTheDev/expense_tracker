import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

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

  TransactionEntity({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    this.relatedDoc = '',
    String? id,
  }) : id = id ?? const Uuid().v4();

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
