import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final String relatedDoc;

  const ExpenseEntity({
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
