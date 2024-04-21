import '../../domain/entities/account.dart';

class AccountDto extends AccountEntity {
  AccountDto({
    required super.id,
    required super.name,
    required super.createdBy,
    required super.owner,
    required super.totalBalance,
    super.expenses,
    super.income,
    super.transactions,
  });

  factory AccountDto.fromJson(final Map<String, dynamic> json) {
    final num totalBalance = json['totalBalance'];
    return AccountDto(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      createdBy: json['createdBy'],
      totalBalance: totalBalance.toDouble(),
    );
  }

  factory AccountDto.fromEntity(final AccountEntity entity) {
    return AccountDto(
      id: entity.id,
      name: entity.name,
      owner: entity.owner,
      createdBy: entity.createdBy,
      totalBalance: entity.totalBalance,
      expenses: entity.expenses,
      income: entity.income,
      transactions: entity.transactions,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'owner': owner,
      'totalBalance': totalBalance,
      'expenses': expenses,
      'income': income,
      'transactions': transactions,
    };
  }
}
