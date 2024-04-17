import '../../domain/entities/account.dart';

class AccountDto extends AccountEntity {
  const AccountDto({
    required super.id,
    required super.name,
    required super.totalBalance,
    super.owner,
  });

  // TODO(accountDto): do not forget about owner field
  factory AccountDto.fromJson(final Map<String, dynamic> json) {
    final num totalBalance = json['totalBalance'];
    return AccountDto(
      id: json['id'],
      name: json['name'],
      totalBalance: totalBalance.toDouble(),
    );
  }
}
