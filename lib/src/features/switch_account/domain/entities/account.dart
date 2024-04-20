import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/interfaces/entities/account_interface.dart';
import '../../../../core/interfaces/entities/transaction_interface.dart';

class AccountEntity extends Equatable implements IAccountEntity {
  @override
  final String id;
  @override
  final String createdBy;
  @override
  final String name;
  @override
  final String owner;
  @override
  final double expenses;
  @override
  final double income;
  @override
  final double totalBalance;
  @override
  final List<ITransactionEntity> transactions;

  AccountEntity({
    required this.name,
    required this.createdBy,
    required this.owner,
    this.totalBalance = 0,
    this.expenses = 0,
    this.income = 0,
    this.transactions = const [],
    String? id,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [
        id,
        name,
        totalBalance,
        owner,
        createdBy,
        expenses,
        income,
        transactions,
      ];
}
