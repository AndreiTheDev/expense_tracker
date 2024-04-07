import 'transaction.dart';

class ExpenseEntity extends TransactionEntity {
  const ExpenseEntity({
    required super.id,
    required super.category,
    required super.description,
    required super.amount,
    required super.date,
    required super.relatedDoc,
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
