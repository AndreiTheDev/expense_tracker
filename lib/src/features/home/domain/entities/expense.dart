import 'transaction.dart';

class ExpenseEntity extends TransactionEntity {
  const ExpenseEntity({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.id,
  });
}
