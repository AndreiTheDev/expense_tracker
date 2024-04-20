import 'transaction_interface.dart';

abstract interface class IAccountEntity {
  String get id;
  String get createdBy;
  String get name;
  String get owner;
  double get expenses;
  double get income;
  double get totalBalance;
  List<ITransactionEntity> get transactions;
}
