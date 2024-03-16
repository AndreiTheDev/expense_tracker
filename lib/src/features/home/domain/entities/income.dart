import 'transaction.dart';

class IncomeEntity extends TransactionEntity {
  const IncomeEntity({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.id,
  });
}
