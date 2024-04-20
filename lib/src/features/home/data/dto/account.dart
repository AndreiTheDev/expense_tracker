import '../../domain/entities/account.dart';

class AccountDto extends AccountEntity {
  const AccountDto({
    required super.id,
    required super.name,
    required super.income,
    required super.expenses,
    required super.totalBalance,
    required super.transactions,
    required super.createdBy,
  });

  factory AccountDto.fromJson(final Map<String, dynamic> json) {
    return AccountDto(
      id: json['id'],
      createdBy: json['createdBy'],
      name: json['name'],
      income: json['income'],
      expenses: json['expenses'],
      totalBalance: json['totalBalance'],
      transactions: json['transactions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'name': name,
      'income': income,
      'expenses': expenses,
      'totalBalance': totalBalance,
      'transactions': transactions,
    };
  }
}
