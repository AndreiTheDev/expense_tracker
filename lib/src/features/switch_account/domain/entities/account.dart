import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final String? owner;
  final double totalBalance;

  const AccountEntity({
    required this.id,
    required this.name,
    required this.totalBalance,
    this.owner,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalBalance,
        owner,
      ];
}
