import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String category;
  final String description;
  final double amount;
  final DateTime date;

  const TransactionEntity({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, category, description, amount, date];
}
