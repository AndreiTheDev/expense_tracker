import 'transaction.dart';

class ExpenseEntity extends TransactionEntity {
  ExpenseEntity({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    super.relatedDoc,
    super.id,
  });
}
