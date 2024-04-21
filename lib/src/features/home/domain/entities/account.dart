import 'package:equatable/equatable.dart';

import '../../../../core/interfaces/entities/account_interface.dart';
import 'transaction.dart';

class AccountEntity extends Equatable implements IAccountEntity {
  @override
  final String createdBy;
  @override
  final String owner;
  @override
  final String id;
  @override
  final String name;
  @override
  final double income;
  @override
  final double expenses;
  @override
  final double totalBalance;
  @override
  final List<TransactionEntity> transactions;

  const AccountEntity({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.income,
    required this.expenses,
    required this.totalBalance,
    required this.transactions,
    this.owner = '',
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
