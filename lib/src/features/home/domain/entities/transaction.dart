import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final String? relatedDoc;

  TransactionEntity({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    this.relatedDoc,
    String? id,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, category, description, amount, date];
}
