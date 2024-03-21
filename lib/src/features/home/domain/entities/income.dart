import 'transaction.dart';

class IncomeEntity extends TransactionEntity {
  IncomeEntity({
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    super.relatedDoc,
    super.id,
  });
}
