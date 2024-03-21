import 'package:equatable/equatable.dart';

import 'transaction.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final double income;
  final double expenses;
  final double totalBalance;
  final List<TransactionEntity> transactions;

  const AccountEntity({
    required this.id,
    required this.name,
    required this.income,
    required this.expenses,
    required this.totalBalance,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        income,
        expenses,
        totalBalance,
        transactions,
      ];
}
